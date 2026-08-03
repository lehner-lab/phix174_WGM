## R Scripts
1. Load dependencies and configure the analysis environment (scripts/00_environment_and_dependencies.R;).
2. Normalize raw fitness values within each library (scripts/01_fitness_data_normalization.R; Inputs: data/01_dimsum_raw_fitness/; Outputs: data/02_normalized_fitness/).
3. Combine all libraries, statistics and classify variant effects (scripts/02_all_variants_analysis.R; Inputs: data/02_normalized_fitness/; Outputs: data/03_combined_variants/, data/04_single_nucleotide/).
4. Analyze and plot single-nucleotide variants (scripts/04_single_nucleotide_analysis.R; Inputs: data/04_single_nucleotide/).


4. Generate amino-acid variant datasets (scripts/03_generate_amino_acid_variants.R; Inputs: data/03_combined_variants/; Outputs: data/05_single_amino_acid/)
6. Analyze and plot single-amino-acid variants (scripts/05_single_amino_acid_analysis.R; Inputs: data/05_single_amino_acid/).
7. Benchmark variant-effect predictors (scripts/06_vep_benchmarking.R; Inputs: data/05_single_amino_acid/; Outputs: data/06_vep_benchmarking/).
8. Evaluate structural predictions using mutational data (scripts/07_structural_prediction_evaluation.R).









