#!/usr/bin/env bash

set -euo pipefail

RAW_DIR="${1:-data/raw}"
MERGED_DIR="${2:-data/merged}"

mkdir -p "$MERGED_DIR"

shopt -s nullglob

for lane1_r1 in "$RAW_DIR"/*_L001_R1.fastq.gz; do
    filename=$(basename "$lane1_r1")
    prefix="${filename%_L001_R1.fastq.gz}"

    echo "Processing $prefix"

    for read in R1 R2; do
        lane1="$RAW_DIR/${prefix}_L001_${read}.fastq.gz"
        lane2="$RAW_DIR/${prefix}_L002_${read}.fastq.gz"
        output="$MERGED_DIR/${prefix}_${read}.fastq.gz"
        partial="${output}.partial"

        for input in "$lane1" "$lane2"; do
            if [[ ! -f "$input" ]]; then
                echo "ERROR: missing lane file: $input"
                exit 1
            fi
        done

        if [[ -e "$output" || -e "$partial" ]]; then
            echo "ERROR: output already exists: $output"
            exit 1
        fi

        # Decompress both lanes in order and create one gzip stream.
        gzip -cd "$lane1" "$lane2" |
            gzip -c > "$partial"

        gzip -t "$partial"
        mv "$partial" "$output"
    done
done

# Libraries without separate lane files, such as libr1.
for source in "$RAW_DIR"/libr1_*_R[12].fastq.gz; do
    destination="$MERGED_DIR/$(basename "$source")"

    if [[ ! -e "$destination" ]]; then
        cp -p "$source" "$destination"
    fi
done

echo "Lane concatenation completed."



