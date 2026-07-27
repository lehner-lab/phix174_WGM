#!/usr/bin/env bash

set -euo pipefail

DIMSUM="./DiMSum/DiMSum"

PARAM_TABLE="./metadata/DiMSum_library_parameters.tsv"
FASTQ_DIR="./data/merged"
DESIGN_DIR="./metadata/experiment_designs"
VARIANT_IDENTITY_DIR="./metadata/variant_identity"
OUTPUT_ROOT="./results/DiMSum"

mkdir -p "$OUTPUT_ROOT"

tail -n +2 "$PARAM_TABLE" |
while IFS=$'\t' read -r \
    pool \
    twist \
    library_id \
    library_label \
    include \
    experiment_design_file \
    variant_identity_file \
    project_name \
    wildtype_sequence \
    cutadapt5First \
    cutadapt5Second \
    notes
do
    [[ "$include" != "yes" ]] && continue

    output_dir="$OUTPUT_ROOT/$library_label"

    mkdir -p "$output_dir"

    echo "Running DiMSum for $library_label"

    "$DIMSUM" \
        --fastqFileDir "$FASTQ_DIR" \
        --experimentDesignPath "$DESIGN_DIR/$experiment_design_file" \
        --barcodeIdentityPath "$VARIANT_IDENTITY_DIR/$variant_identity_file" \
        --outputPath "$output_dir" \
        --projectName "$project_name" \
        --cutadaptMinLength 50 \
        --cutadaptErrorRate 0.2 \
        --cutadaptOverlap 3 \
        --vsearchMaxee 0.5 \
        --vsearchMinQual 25 \
        --vsearchMinovlen 10 \
        --maxSubstitutions 3 \
        --retainIntermediateFiles TRUE \
        --indels all \
        --wildtypeSequence "$wildtype_sequence" \
        --cutadapt5First "$cutadapt5First" \
        --cutadapt5Second "$cutadapt5Second" \
        --startStage 1 \
        --stopStage 5 \
        --numCores 12

done

