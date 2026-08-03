#!/bin/bash

set -euo pipefail

CHAIN_ID="A"

# Each hypothesis folder is compared only to its own reference model
HYPOTHESIS_DIRS=(
  "working_models/gpa_dsDNA_30nt"
  "working_models/gpa_ssDNA_30nt"
)

REF_MODELS=(
  "working_models/gpa_dsDNA_30nt/gpa_dsDNA_30nt_seed2/gpa_dsDNA_30nt_seed2_model_0.cif"
  "working_models/gpa_ssDNA_30nt/gpa_ssDNA_30nt_seed5/gpa_ssDNA_30nt_seed5_model_0.cif"
)

OUT_DIR="analysis/RMSD"
LOG_DIR="analysis/logs_RMSD"

mkdir -p "$OUT_DIR"
mkdir -p "$LOG_DIR"

run_rmsd_for_hypothesis() {
  
  HYPOTHESIS_DIR="$1"
  REF_MODEL="$2"
  
  hypothesis_name=$(basename "$HYPOTHESIS_DIR")
  
  OUT_FILE="$OUT_DIR/${hypothesis_name}_vs_ref.csv"
  LOG_FILE="$LOG_DIR/${hypothesis_name}_vs_ref.log"
  
  echo "Processing hypothesis: $hypothesis_name"
  echo "Hypothesis folder: $HYPOTHESIS_DIR"
  echo "Reference model: $REF_MODEL"
  
  # Safety checks
  if [ ! -d "$HYPOTHESIS_DIR" ]; then
    echo "ERROR: Hypothesis folder does not exist: $HYPOTHESIS_DIR"
    exit 1
  fi
  
  if [ ! -f "$REF_MODEL" ]; then
    echo "ERROR: Reference model does not exist: $REF_MODEL"
    exit 1
  fi
  
  if [[ "$REF_MODEL" != "$HYPOTHESIS_DIR/"* ]]; then
    echo "ERROR: Reference model is not inside hypothesis folder."
    echo "Hypothesis folder: $HYPOTHESIS_DIR"
    echo "Reference model: $REF_MODEL"
    exit 1
  fi
  
  echo "model,pruned_atom_pairs,pruned_rmsd_to_reference,all_atom_pairs,all_pair_rmsd_to_reference" > "$OUT_FILE"
  > "$LOG_FILE"
  
  cifs=($(find "$HYPOTHESIS_DIR" -name "*.cif" | sort))
  
  echo "Total models found: ${#cifs[@]}"
  
  for cif in "${cifs[@]}"; do
    
    # Skip the reference itself
    if [ "$cif" = "$REF_MODEL" ]; then
      continue
    fi
    
    base=$(basename "$cif" .cif)
    
    echo "Comparing $base to $(basename "$REF_MODEL" .cif)"
    
    tmp_out=$(mktemp)
    
    chimerax --nogui <<EOF > "$tmp_out" 2>> "$LOG_FILE"
open "$REF_MODEL"
open "$cif"
matchmaker #2/$CHAIN_ID to #1/$CHAIN_ID matrix blosum-62
exit
EOF
    
    cat "$tmp_out" >> "$LOG_FILE"
    
    # Example ChimeraX MatchMaker output often contains lines similar to:
    # RMSD between 432 pruned atom pairs is 0.64 angstroms
    # RMSD across all 513 pairs: 1.23
    
    pruned_line=$(grep -i "RMSD between.*pruned.*atom pairs" "$tmp_out" | head -n 1 || true)
    all_line=$(grep -i "RMSD.*all.*pairs" "$tmp_out" | head -n 1 || true)
    
    pruned_atom_pairs=$(echo "$pruned_line" | sed -E 's/.*between[[:space:]]+([0-9]+)[[:space:]]+pruned.*/\1/' )
    pruned_rmsd=$(echo "$pruned_line" | sed -E 's/.*is[[:space:]]+([0-9.]+).*/\1/' )
    
    all_atom_pairs=$(echo "$all_line" | sed -E 's/.*all[[:space:]]+([0-9]+)[[:space:]]+pairs.*/\1/' )
    all_rmsd=$(echo "$all_line" | sed -E 's/.*[:=][[:space:]]*([0-9.]+).*/\1/' )
    
    # If parsing failed, set NA
    if [[ -z "$pruned_line" || "$pruned_atom_pairs" == "$pruned_line" ]]; then
      pruned_atom_pairs="NA"
    fi
    
    if [[ -z "$pruned_line" || "$pruned_rmsd" == "$pruned_line" ]]; then
      pruned_rmsd="NA"
    fi
    
    if [[ -z "$all_line" || "$all_atom_pairs" == "$all_line" ]]; then
      all_atom_pairs="NA"
    fi
    
    if [[ -z "$all_line" || "$all_rmsd" == "$all_line" ]]; then
      all_rmsd="NA"
    fi
    
    echo "$base,$pruned_atom_pairs,$pruned_rmsd,$all_atom_pairs,$all_rmsd" >> "$OUT_FILE"
    
    rm -f "$tmp_out"
    
  done
  
  echo "Finished: $hypothesis_name"
  echo "Output: $OUT_FILE"
  echo ""
}

# Run each hypothesis with its matched reference model
for i in "${!HYPOTHESIS_DIRS[@]}"; do
  run_rmsd_for_hypothesis "${HYPOTHESIS_DIRS[$i]}" "${REF_MODELS[$i]}"
done

echo "All RMSD comparisons finished."