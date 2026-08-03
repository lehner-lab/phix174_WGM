# phix174_WGM
Complete mutagenesis of the genome and proteome of ΦX174

## Abstract
The bacteriophage ΦX174 was the first genome to be sequenced and the first to be chemically synthesised. Here we present a complete map of the consequences of changing every nucleotide in the ΦX174 genome and every amino acid in the proteome. In total, half of nucleotide and >60% of amino acid changes impair fitness. However, this varies substantially across proteins and non-coding regions. Surprisingly, the most important mechanistic cause of reduced fitness is disruption of protein interaction interfaces, accounting for nearly half of detrimental protein variants. A further one quarter of damaging variants disrupt protein cores but one in four lack a mechanistic explanation. Mutational effects are only moderately-well predicted by state-of-the-art artificial intelligence models, but, combined with structural modelling, provide mechanistic hypotheses and insights into the DNA replication machinery. This complete mutagenesis of a biological system quantifies the limits of our current understanding of, and ability to predict, molecular biology.

## Repository structure
This repository contains the metadata, reference sequences, and analysis scripts used to process deep-sequencing data from ΦX174 variant libraries and calculate variant fitness values using DiMSum.

```text
phix174-WGM/
├── README.md
├── LICENSE
├── environment.yml
├── .gitignore
│
├── R_scripts/
│   ├── README.md
│   ├── 00_R_packages.R
│   ├── 01_fitness_data_normalization.R
│   ├── 02_all_variants_analysis.R
│   ├── 03_single_nucleotide_variants.R
│   ├── 04_single_amino_acid_variants.R
│   ├── 05_evaluate_VEPs.R
│   └── 06_evaluate_AF3_models.R
│
├── data/
│   ├── raw_fitness_data/
│   │   ├── pool*_twist*_lib*_dimsum_fitness.RData
│   │   └── ...
│   │
│   ├── evaluate_VEPs/
│   ├── evaluate_AF3_models/
│   ├── proteins_data/
│   ├── mutant_library/
│   ├── mutant_annotation/
│   ├── EVcouplings/
│   │
│   ├── phix_dimsum_fitness_libraries.rds
│   ├── phix_dms_sub_libraries_normalized.rds
│   ├── phix_all_dms100_sub_libraries_normalized_unique_stat.tsv
│   ├── phix_all_dms100_sub_libraries_normalized_unique_stat_1nt.tsv
│   ├── phix_all_dms100_sub_libraries_normalized_unique_stat_AA.tsv
│   ├── phix_proteome_dms_mut_Fitness_unique_advanced.tsv
│   └── phix_proteome_dms_aa_pos_Fitness_advanced.tsv
│
└── metadata/
    ├── DiMSum_library_parameters.tsv
    ├── experiment_designs/
    └── variant_identity/
```



## Data availability
Raw paired-end sequencing reads are deposited in the European Nucleotide Archive under project accession PRJEB120835. The metadata and scripts required to download the sequencing reads, merge files generated from separate sequencing lanes, and rerun the DiMSum pipeline are provided in this repository.

For exact reproduction of the downstream analyses, we provide datasets required and generated during the analysis and used throughout this study.

Protein structures, AlphaFold 3 models, and other large structural datasets are hosted separately because of their file size.
Structural data: [link to be added] 



## Analysis overview
The downstream analysis consists of the following steps:
1. Load raw DiMSum fitness estimates, associated errors, and library-specific variant annotations.
3. Normalize fitness values within each library and rescale normalized fitness across genes.
4. Combine libraries, merge duplicated genotypes, statistic tests, and mutational effects category.
5. Generate annotated single-nucleotide and single-amino-acid variant datasets, together with residue-level summaries.
6. Perform enrichment tests, comparative analyses, and figure generation.
7. Integrate variant-effect predictor scores and evaluate predictor performance.
8. Use mutational data to evaluate experimentally resolved and predicted protein structures and interaction models.



## Citation
> Huijin Wei, Xianghua Li, Ben Lehner.
> Complete Mutagenesis of the Genome and Proteome of ΦX174.
> *bioRxiv* 2026. https://doi.org/10.64898/2026.07.25.740675




