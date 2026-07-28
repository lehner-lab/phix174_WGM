# Bash scripts

This folder contains the Bash scripts used to retrieve the raw sequencing data, prepare the paired-end FASTQ files, and rerun the DiMSum pipeline.

The scripts should be run in numerical order.

## Contents

```text
bash/
├── README.md
├── 01_download_ena_fastq.sh
├── 02_concatenate_lanes.sh
└── 03_run_DiMSum.sh
```

## `01_download_ena_fastq.sh`

Downloads the raw paired-end sequencing reads from the European Nucleotide Archive project:

```text
PRJEB120835
```

The script retrieves the ENA file information, downloads the submitted FASTQ files, and verifies the downloaded files using the MD5 checksums reported by ENA.

### Output

```text
data/raw_fastq/
```

The downloaded filenames retain the library, replicate, selection condition, sequencing lane, and read direction.

Example:

```text
lib6_rep1_input_L001_R1.fastq.gz
lib6_rep1_input_L001_R2.fastq.gz
```

## `02_concatenate_lanes.sh`

Combines sequencing reads generated from separate lanes for the same biological sample.

R1 files are concatenated only with the corresponding R1 files, and R2 files are concatenated only with the corresponding R2 files.

For example:

```text
lib6_rep1_input_L001_R1.fastq.gz
lib6_rep1_input_L002_R1.fastq.gz
```

are combined into:

```text
lib6_rep1_input_R1.fastq.gz
```

The same operation is performed independently for R2.

Libraries without separate lane files are copied directly to the prepared FASTQ directory.

### Input

```text
data/raw_fastq/
```

### Output

```text
data/merged_fastq/
```

The output filenames correspond to the `pair1` and `pair2` entries in the DiMSum experimental-design files.

## `03_run_DiMSum.sh`

Runs DiMSum for all libraries included in:

```text
metadata/DiMSum_library_parameters.tsv
```

For each library, the script loads:

* the experimental-design file;
* the VariantIdentity file;
* the wild-type sequence;
* the `cutadapt5First` sequence;
* the `cutadapt5Second` sequence;
* the DiMSum project name.

The corresponding files are obtained from:

```text
metadata/experiment_designs/
metadata/variant_identity/
```

The script uses the following DiMSum settings:

```text
cutadaptMinLength = 50
cutadaptErrorRate = 0.2
cutadaptOverlap = 3
vsearchMaxee = 0.5
vsearchMinQual = 25
vsearchMinovlen = 10
maxSubstitutions = 3
retainIntermediateFiles = TRUE
indels = all
startStage = 1
stopStage = 5
numCores = 12
```

### Input

```text
data/merged_fastq/
metadata/DiMSum_library_parameters.tsv
metadata/experiment_designs/
metadata/variant_identity/
```

### Output

```text
results/DiMSum/
```

Each library is written to a separate output directory using its pool and library identifier.

Example:

```text
results/DiMSum/pool1_lib6/
```

## Running the scripts

From the repository root:

```bash
bash scripts/bash/01_download_ena_fastq.sh
bash scripts/bash/02_concatenate_lanes.sh
bash scripts/bash/03_run_DiMSum.sh
```

Users reproducing only the downstream analyses do not need to rerun these scripts. The archived DiMSum fitness datasets generated during the original analysis and used in this study are provided separately.

