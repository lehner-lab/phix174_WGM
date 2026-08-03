#!/bin/bash

set -euo pipefail

# -------- SETTINGS --------
WORK_DIR="working_models"
#ANALYSIS_DIR="analysis/ipSAE_15"
ANALYSIS_DIR="analysis/ipSAE"
LOG_DIR="analysis/logs_ipSAE"
IPSAE_SCRIPT="./ipSAE/IPSAE/ipsae.py"

CUTOFF1=15
CUTOFF2=15
N_CORES=6

mkdir -p "$ANALYSIS_DIR"
mkdir -p "$LOG_DIR"

echo "Starting ipSAE calculations..."

process_model() {

    cif="$1"
    base=$(basename "$cif" .cif)
    model_dir=$(dirname "$cif")

    # Skip if already processed
    if [ -f "$ANALYSIS_DIR/${base}_${CUTOFF1}_${CUTOFF2}.txt" ]; then
        echo "Skipping $base (already processed)"
        return
    fi

    # Find corresponding full_data JSON
    json_file="$model_dir/${base}_full_data.json"

    if [ ! -f "$json_file" ]; then
        json_file="$model_dir/${base}_full_data_0.json"
    fi

    if [ ! -f "$json_file" ]; then
        echo "WARNING: No full_data JSON found for $base"
        return
    fi

    log_file="$LOG_DIR/${base}.log"

    # Run inside temporary directory
    tmp_dir=$(mktemp -d)
    cd "$tmp_dir"

    python "$IPSAE_SCRIPT" "$json_file" "$cif" "$CUTOFF1" "$CUTOFF2" \
        > "$log_file" 2>&1 || true

    # Move outputs if generated
    for suffix in ".txt" ".pml" "_byres.txt"; do
        file="${base}_${CUTOFF1}_${CUTOFF2}${suffix}"
        if [ -f "$file" ]; then
            mv "$file" "$OLDPWD/$ANALYSIS_DIR/"
        fi
    done

    cd "$OLDPWD"
    rm -rf "$tmp_dir"
}

export -f process_model
export IPSAE_SCRIPT CUTOFF1 CUTOFF2 ANALYSIS_DIR LOG_DIR

find "$WORK_DIR" -name "*.cif" | sort | \
    parallel -j "$N_CORES" process_model {}

echo "ipSAE calculations completed."