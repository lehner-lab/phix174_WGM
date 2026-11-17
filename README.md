# phix174_WGM
Complete mutagenesis of the genome and proteome of ΦX174

## Abstract
The bacteriophage ΦX174 was the first genome to be sequenced and the first to be chemically synthesised. Here we present a complete map of the consequences of changing every nucleotide in the ΦX174 genome and every amino acid in the proteome. In total, half of nucleotide and >60% of amino acid changes impair fitness. However, this varies substantially across proteins and non-coding regions. Surprisingly, the most important mechanistic cause of reduced fitness is disruption of protein interaction interfaces, accounting for nearly half of detrimental protein variants. A further one quarter of damaging variants disrupt protein cores but one in four lack a mechanistic explanation. Mutational effects are only moderately-well predicted by state-of-the-art artificial intelligence models, but, combined with structural modelling, provide mechanistic hypotheses and insights into the DNA replication machinery. This complete mutagenesis of a biological system quantifies the limits of our current understanding of, and ability to predict, molecular biology.


## Repository structure

This repository contains the metadata, reference sequences, datasets, and analysis scripts used for the complete mutational analysis of the ΦX174 genome and proteome. It includes the original data-processing workflows and standalone R scripts for reproducing manuscript analyses and figures directly from the supplementary datasets.

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
│   ├── 06_evaluate_AF3_models.R
│   ├── 07a_evo_phage_genomes_analysis.Rmd
│   └── 07b_evo300_phage_genomes_analysis.Rmd
│
├── R_reproduce_figures/
│   ├── README.md
│   ├── Data_S1_all_variants.Rmd
│   ├── Data_S2_single_nucleotide.Rmd
│   ├── Data_S3_single_amino_acid.Rmd
│   ├── Data_S4_evaluate_VEPs.Rmd
│   ├── Data_S5_evaluate_AF3.Rmd
│   ├── Data_S6_evo_phage_genomes.Rmd
│   └── Figure_S7_human_protein_complexes.Rmd
│
├── scripts/
│   ├── README.md
│   ├── 01_download_ena_fastq.sh
│   ├── 02_concatenate_lanes.sh
│   ├── 03_run_DiMSum.sh
│   ├── 04_run_contacts.sh
│   ├── 05_run_ipSAE.sh
│   └── 06_run_internal_RMSD.sh
│
├── data/
│   ├── README.md
│   ├── EVcouplings_MSA/
│   ├── evaluate_AF3_models/
│   ├── evaluate_VEPs/
│   ├── fitness_scoring_structure/
│   ├── mutant_library_annotations/
│   ├── processed_fitness_data/
│   ├── proteins_structural_data/
│   ├── raw_fitness_data/
│   ├── resolved_human_protein_complexes/
│   ├── summary_tables/
│   └── variant_genome_sequences/
│
└── metadata/
    ├── DiMSum_library_parameters.tsv
    ├── experiment_designs/
    └── variant_identity/
```

The `R_scripts/` directory contains the original R analysis workflows, while `R_reproduce_figures/` provides scripts for reproducing manuscript figures directly from supplementary datasets (Data S1–S6) and structural analysis files. The `scripts/` directory contains additional computational pipelines.

The `data/processed_fitness_data/` directory stores the processed, normalized, and analysis-ready variant datasets.


## Data Availability
Raw paired-end sequencing reads have been deposited in the European Nucleotide Archive (ENA) under project accession **PRJEB120835**. This repository provides the metadata and scripts required to download sequencing reads, concatenate FASTQ files from separate sequencing lanes, and run the DiMSum analysis pipeline.

The key input, intermediate, and analysis-ready datasets are provided to facilitate reproducibility. Additional datasets generated during the study are available through the following repositories:

- **Original DiMSum outputs and sequencing-depth downsampling datasets:** https://doi.org/10.5281/zenodo.23889881
- **EVcouplings multiple-sequence alignments** for ΦX174 proteins across UniRef100, UniRef90, and MGnify+UniProt searches: https://doi.org/10.5281/zenodo.23889160
- **AlphaFold 3 models and structural analyses** of ΦX174 protein A–DNA and protein A–C interactions: https://doi.org/10.5281/zenodo.23880305
- **Sequence alignments of Evo-designed ΦX174 genomes:** https://doi.org/10.5281/zenodo.23890094

For convenient reproduction of manuscript analyses and figures, we provide dedicated R scripts that directly load the published supplementary datasets (Data S1–S6), without rerunning the original data-processing pipelines. See [`R_reproduce_figures/`](R_reproduce_figures/) for details and a figure-by-figure reproduction guide.


## Analysis workflow

The following workflow describes the processing of DiMSum output datasets and subsequent downstream analyses:

1. Load DiMSum fitness estimates, associated errors, and library-specific variant annotations.
2. Normalize fitness estimates within individual libraries and rescale normalized values across genes.
3. Combine libraries, merge duplicate genotypes, perform statistical tests, and classify mutational effects.
4. Generate annotated single-nucleotide and single-amino-acid variant datasets, including residue-level summaries.
5. Perform statistical enrichment tests, comparative analyses, and figure generation.
6. Integrate variant-effect predictor scores and benchmark their performance against experimental measurements.
7. Use experimental mutational data to evaluate AlphaFold 3 protein structures and predicted interaction complexes.
8. Analyze Evo-designed ΦX174 genomes, including mutational effects, genome viability, and lytic performance.

The original analysis workflows are provided in [`R_scripts/`](R_scripts/), while scripts for reproducing manuscript analyses and figures directly from supplementary datasets are available in [`R_reproduce_figures/`](R_reproduce_figures/).


## Citation
> Huijin Wei, Xianghua Li, Ben Lehner.
> Complete Mutagenesis of the Genome and Proteome of ΦX174.
> *bioRxiv* 2026. https://doi.org/10.64898/2026.07.25.740675




