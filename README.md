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
The raw paired-end sequencing reads are deposited in the European Nucleotide Archive under project accession PRJEB120835. 

Raw sequencing files are not stored in this GitHub repository. They can be downloaded from ENA using the scripts provided here, and used for running DiMSum pipeline to calculate fitness values for variants after the project is publicly released.


## Analysis overview
1. 
2. 
3. 


## Download data
Download processed data using provided script 


## 






