# Reproduce figures using supplementary data

This folder contains R scripts for reproducing the analyses and figures presented in the manuscript using the published supplementary datasets (Data S1–S6). These scripts allow users to regenerate the main results and figures without rerunning the original data-processing pipelines.

## Supplementary datasets

| Dataset | Contents and main analyses | Figures |
|---|---|---|
| **Data S1** | Complete ΦX174 variant dataset; library normalization, replicate reproducibility, and overall mutational effects. | Fig. S1D, F, G |
| **Data S2** | Single-nucleotide mutational landscape; genomic annotations, mutational effects, and comparison with previously reported mutants. | Fig. 1C–F; Fig. S1E, H–J |
| **Data S3** | Single-amino-acid mutational landscape; protein-level effects, residue annotations, and structural analyses of protein cores and interfaces. | Fig. 2A–C, 3A–B, 4A–F; Fig. S2A–C, S3A–B, D, S4A–C, H–I |
| **Data S4** | Multiple sequence alignments and benchmarking of variant-effect predictors, including sequence-based, structure-based, and Evo2 models. | Fig. 4G; Fig. S4D–G, J–L |
| **Data S5** | AlphaFold 3 model evaluation; model confidence, structural comparisons, predicted residue contacts, and mutational enrichment at interfaces. | Fig. 5E, G; Fig. S5A, C; Fig. S6A, D–H |
| **Data S6** | Evo-designed ΦX174 genomes; designed mutations, genome viability, mutational effects, lytic performance, and changes acquired during rebooting. | Fig. S8A–E |

## Figure reproduction index

The following table lists the supplementary dataset and R script used to reproduce each manuscript figure and its associated panels.

| Figure | Panels | Supplementary data | R script |
|---|---|---|---|
| **Fig. 1** | C, D, E, F | Data S2 | `Data_S2_single_nucleotide.Rmd` |
| **Fig. 2** | A, B, C | Data S3 | `Data_S3_single_amino_acid.Rmd` |
| **Fig. 3** | A, B | Data S3 | `Data_S3_single_amino_acid.Rmd` |
| **Fig. 4** | A, B, C, D, E, F | Data S3 | `Data_S3_single_amino_acid.Rmd` |
| **Fig. 4** | G | Data S4 | `Data_S4_evaluate_VEPs.Rmd` |
| **Fig. 5** | E, G | Data S5 | `Data_S5_evaluate_AF3.Rmd` |
| **Fig. S1** | D, F, G | Data S1 | `Data_S1_all_variants.Rmd` |
| **Fig. S1** | E, H, I, J | Data S2 | `Data_S2_single_nucleotide.Rmd` |
| **Fig. S2** | A, B, C | Data S3 | `Data_S3_single_amino_acid.Rmd` |
| **Fig. S3** | A, B, D | Data S3 | `Data_S3_single_amino_acid.Rmd` |
| **Fig. S4** | A, B, C, H, I | Data S3 | `Data_S3_single_amino_acid.Rmd` |
| **Fig. S4** | D, E, F, G, J, K, L | Data S4 | `Data_S4_evaluate_VEPs.Rmd` |
| **Fig. S5** | A, C | Data S5 | `Data_S5_evaluate_AF3.Rmd` |
| **Fig. S6** | A, D, E, F, G, H | Data S5 | `Data_S5_evaluate_AF3.Rmd` |
| **Fig. S8** | A, B, C, D, E | Data S6 | `Data_S6_evo_phage_genomes.Rmd` |

## Usage

Each R Markdown script loads the corresponding supplementary dataset (Data S1–S6), performs the relevant analyses, and generates the associated figures.

Run the scripts from the repository root directory with the required R packages and supplementary data files available.

