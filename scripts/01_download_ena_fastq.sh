#!/usr/bin/env bash

set -euo pipefail

PROJECT_ACCESSION="${1:-PRJEB120835}"
RAW_DIR="${2:-data/raw}"
METADATA_DIR="${3:-metadata}"

REPORT="$METADATA_DIR/ena_file_report.tsv"
DOWNLOAD_MANIFEST="$METADATA_DIR/ena_download_manifest.tsv"

mkdir -p "$RAW_DIR" "$METADATA_DIR"

echo "Retrieving ENA file report for $PROJECT_ACCESSION"

curl -fsSLG \
    "https://www.ebi.ac.uk/ena/portal/api/filereport" \
    --data-urlencode "accession=$PROJECT_ACCESSION" \
    --data-urlencode "result=read_run" \
    --data-urlencode \
"fields=run_accession,sample_alias,experiment_alias,library_name,submitted_ftp,submitted_md5" \
    --data-urlencode "format=tsv" \
    > "$REPORT"

if [[ $(wc -l < "$REPORT") -le 1 ]]; then
    echo "ERROR: no public read files were returned."
    echo "The ENA project may still be private or under embargo."
    exit 1
fi

printf 'run_accession\tsample_alias\tlibrary_name\tftp_path\tmd5\n' \
    > "$DOWNLOAD_MANIFEST"

awk -F '\t' '
BEGIN {
    OFS = "\t"
}
NR > 1 {
    number_urls = split($5, urls, ";")
    number_md5s = split($6, checksums, ";")

    if (number_urls != number_md5s) {
        print "ERROR: URL/MD5 count mismatch for " $1 > "/dev/stderr"
        exit 1
    }

    for (i = 1; i <= number_urls; i++) {
        if (urls[i] != "") {
            print $1, $2, $4, urls[i], checksums[i]
        }
    }
}
' "$REPORT" >> "$DOWNLOAD_MANIFEST"

while IFS=$'\t' read -r run sample library ftp_path expected_md5; do
    [[ "$run" == "run_accession" ]] && continue

    filename=$(basename "$ftp_path")
    destination="$RAW_DIR/$filename"

    # ENA often returns the host/path without a protocol.
    download_url="${ftp_path#ftp://}"
    download_url="https://$download_url"

    echo "Downloading $filename"
    wget -c "$download_url" -O "$destination"

    observed_md5=$(md5sum "$destination" | awk '{print $1}')

    if [[ "$observed_md5" != "$expected_md5" ]]; then
        echo "ERROR: MD5 mismatch for $filename"
        echo "Expected: $expected_md5"
        echo "Observed: $observed_md5"
        exit 1
    fi

done < "$DOWNLOAD_MANIFEST"

echo "ENA download and MD5 validation completed."



