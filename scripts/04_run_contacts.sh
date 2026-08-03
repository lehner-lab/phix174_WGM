#!/bin/bash

set -euo pipefail

MODEL_DIR="working_models"
CHAIN_ROLE_FILE="metadata/chain_roles.csv"
ANALYSIS_DIR="analysis/atom_contacts"
LOG_DIR="analysis/logs"
MAP_FILE="metadata/contact_mapping.csv"

N_CORES=6   # Using 6 out of 10 logical cores

mkdir -p "$ANALYSIS_DIR"
mkdir -p "$LOG_DIR"
mkdir -p metadata

# Write header once
echo "structure_file,gene,result_file,n_contacts" > "$MAP_FILE"

process_model() {

    cif="$1"
    base=$(basename "$cif" .cif)

    # Extract biological chain IDs from chain_roles.csv
    chain_A=$(awk -F',' -v model="$base.cif" '$1==model && $7=="A"{print $2; exit}' "$CHAIN_ROLE_FILE")
    chain_C=$(awk -F',' -v model="$base.cif" '$1==model && $7=="C"{print $2; exit}' "$CHAIN_ROLE_FILE")

    raw_A="$ANALYSIS_DIR/${base}_A_contacts_raw.txt"
    raw_C="$ANALYSIS_DIR/${base}_C_contacts_raw.txt"
    log_file="$LOG_DIR/${base}.log"

    # ---- Single ChimeraX session ----
    chimerax --nogui <<EOF > "$log_file" 2>&1
open "$cif"
delete @H
$( [ -n "$chain_A" ] && echo "contact /$chain_A distance 5 select false reveal true makePseudobonds false showDist false intraRes false interSubmodel true ignoreHiddenModels false saveFile \"$raw_A\" log false namingStyle command" )
$( [ -n "$chain_C" ] && echo "contact /$chain_C distance 5 select false reveal true makePseudobonds false showDist false intraRes false interSubmodel true ignoreHiddenModels false saveFile \"$raw_C\" log false namingStyle command" )
exit
EOF

    # ---- Process A contacts ----
    if [[ -n "$chain_A" && -f "$raw_A" ]]; then
        clean_A="$ANALYSIS_DIR/${base}_A_contacts.txt"
        grep '^/' "$raw_A" > "$clean_A" || true
        n_A=$(wc -l < "$clean_A")
        rm -f "$raw_A"
        echo "$base.cif,A,$clean_A,$n_A"
    fi

    # ---- Process C contacts ----
    if [[ -n "$chain_C" && -f "$raw_C" ]]; then
        clean_C="$ANALYSIS_DIR/${base}_C_contacts.txt"
        grep '^/' "$raw_C" > "$clean_C" || true
        n_C=$(wc -l < "$clean_C")
        rm -f "$raw_C"
        echo "$base.cif,C,$clean_C,$n_C"
    fi
}

export -f process_model
export CHAIN_ROLE_FILE ANALYSIS_DIR LOG_DIR

# Run in parallel and append results safely
find "$MODEL_DIR" -name "*.cif" | \
    parallel -j "$N_CORES" process_model {} >> "$MAP_FILE"

echo "Dynamic contact calculations completed."