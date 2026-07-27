# phix174_WGM
Complete mutagenesis of the genome and proteome of ΦX174

## Abstract
The bacteriophage ΦX174 was the first genome to be sequenced and the first to be chemically synthesised. Here we present a complete map of the consequences of changing every nucleotide in the ΦX174 genome and every amino acid in the proteome. In total, half of nucleotide and >60% of amino acid changes impair fitness. However, this varies substantially across proteins and non-coding regions. Surprisingly, the most important mechanistic cause of reduced fitness is disruption of protein interaction interfaces, accounting for nearly half of detrimental protein variants. A further one quarter of damaging variants disrupt protein cores but one in four lack a mechanistic explanation. Mutational effects are only moderately-well predicted by state-of-the-art artificial intelligence models, but, combined with structural modelling, provide mechanistic hypotheses and insights into the DNA replication machinery. This complete mutagenesis of a biological system quantifies the limits of our current understanding of, and ability to predict, molecular biology.

## Repository structure
This repository contains the metadata, reference sequences, and analysis scripts used to process deep-sequencing data from ΦX174 variant libraries and calculate variant fitness values using DiMSum.

```
phix174-WGM/
├── README.md
├── LICENSE
├── environment.yml
├── .gitignore
│
├── metadata/
│   ├── DiMSum_library_parameters.tsv
│   ├── experiment_designs/
│   │   ├── lib1_experiment_design.tsv
│   │   └── ...
│   └── variant_identity/
│       ├── lib1_variant_identity.tsv
│       └── ...
│
├── scripts/
│   ├── 01_download_ena_fastq.sh
│   ├── 02_merge_fastq_lanes.sh
│   ├── 03_run_dimsum.sh
│   ├── 04_collect_dimsum_results.R
│   ├── 05_normalize_fitness.R
│   ├── 06_annotate_variants.R
│   └── ...
│
├── data/
│   ├── 01_dimsum_raw/
│   ├── 02_fitness_combined/
│   ├── 03_fitness_normalized/
│   ├── 04_variants_annotated/
│   └── 05_analysis_ready/
│
└── docs/
    ├── pipeline_overview.md
    └── data_dictionary.md

```


## Data availability
Raw paired-end sequencing reads are deposited in the European Nucleotide Archive under project accession PRJEB120835. The metadata and scripts required to download the sequencing reads, merge files generated from separate sequencing lanes, and rerun the DiMSum pipeline are provided in this repository.

For exact reproduction of the downstream analyses, we also provide the DiMSum fitness datasets generated during the original analysis and used throughout this study.

Protein structures, AlphaFold 3 models, and other large structural datasets are hosted separately because of their file size.
Structural data: [link to be added]


## Analysis overview
The downstream analysis consists of the following steps:
1. Load raw DiMSum fitness estimates, associated errors, and library-specific variant annotations.
3. Normalize fitness values within each library using synonymous and nonsense reference distributions.
4. Combine libraries and merge duplicated genotypes.
5. Generate annotated single-nucleotide and single-amino-acid variant datasets, together with residue-level summaries.
6. Classify variant and mutation effects using statistical significance and fitness-effect thresholds.
7. Perform enrichment tests, comparative analyses, and figure generation.
8. Integrate variant-effect predictor scores and evaluate predictor performance.
9. Use mutational data to evaluate experimentally resolved and predicted protein structures and interaction models.


## Scripts
1. Load dependencies and configure the analysis environment (scripts/00_environment_and_dependencies.R;).
2. Normalize raw fitness values within each library (scripts/01_normalize_library_fitness.R; Inputs: data/01_dimsum_raw_fitness/; Outputs: data/02_normalized_fitness/).
3. Combine normalized datasets and classify variant effects (scripts/02_combine_and_classify_variants.R; Inputs: data/02_normalized_fitness/; Outputs: data/03_combined_variants/, data/04_single_nucleotide/).
4. Generate amino-acid variant datasets (scripts/03_generate_amino_acid_variants.R; Inputs: data/03_combined_variants/; Outputs: data/05_single_amino_acid/)
5. Analyze and plot single-nucleotide variants (scripts/04_single_nucleotide_analysis.R; Inputs: data/04_single_nucleotide/).
6. Analyze and plot single-amino-acid variants (scripts/05_single_amino_acid_analysis.R; Inputs: data/05_single_amino_acid/).
7. Benchmark variant-effect predictors (scripts/06_vep_benchmarking.R; Inputs: data/05_single_amino_acid/; Outputs: data/06_vep_benchmarking/).
8. Evaluate structural predictions using mutational data (scripts/07_structural_prediction_evaluation.R).


## Provided Datasets
1. Raw DiMSum fitness data: library-level DiMSum output tables containing the raw variant fitness estimates and associated error values used as input for downstream normalization (data/01_dimsum_raw_fitness/). ## These files represent DiMSum-derived fitness values before additional within-library normalization, cross-library integration, or biological annotation.

2. Normalized library-level fitness data: fitness values normalized separately within each library using the corresponding library-specific synonymous and nonsense mutational effects, and rescaled across libraries containing reference essential genes (data/02_normalized_fitness/). ## These datasets retain the original library assignments and are used as input for cross-library integration.

3. Combined and deduplicated variant dataset: normalized measurements from all libraries are combined into a single dataset, genotypes measured in more than one library are identified and merged to produce one final measurement per unique genotype (data/03_combined_variants/). ## This directory contains the combined dataset after removal or statistical integration of duplicated genotypes.

4. Single-nucleotide datasets: variant-level and residue-level datasets for single-nucleotide variants are provided with genomic, functional, and mutation-effect annotations (data/04_single_nucleotide/). ## These include single-nucleotide-level variants fitness data, mutation annotations by genomic positions and affected genes (ORFs), statistical significance, mutation-effect categories, and nucleotide-residue summary.

5. Single-amino-acid datasets: variant-level and residue-level datasets for single-amino-acid substitutions are provided with protein, structural, and mutation-effect annotations (data/05_single_amino_acid/). ## These include single-amino-acid variant fitness data, mutation annotations, amino-acid residues annotations, single-ORF and multi-ORF classifications, statistical significance and mutation-effect categories.

6. Variant-effect predictor benchmarking data: benchmarking datasets contain experimentally measured fitness values together with scores generated by selected variant effect predictors (data/06_vep_benchmarking/). ## The supplied files include predictor scores for individual variants, correlations between predictions with experimental data, pre-protein benchmarking, and overall predictor-performance summaries.

7. Structural datasets: experimentally resolved structures (downloaded from PDB), predicted structures, protein–DNA models, protein–protein interaction models, and associated condidence, interface-analysis files; ## The repository contains the scripts and summary tables used to evaluate structural predictions using mutational data, mapping experimentally measured mutational effects onto structures. Large coordinate files and complete prediction outputs can be downloaded from: Structural data: [link to be added]



## Citation
> Huijin Wei, Xianghua Li, Ben Lehner.
> Complete Mutagenesis of the Genome and Proteome of ΦX174.
> *bioRxiv* 2026. https://doi.org/10.64898/2026.07.25.740675




