## R Scripts

The analysis workflow is organized into sequential R scripts. Each script performs a specific stage of the data processing and analysis pipeline and should be executed in the order listed below.

| Script                              | Description                                                                                                                    |
| ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| **00_R_packages.R**                 | Load required R packages, define utility functions, and configure the analysis environment.                                    |
| **01_fitness_data_normalization.R** | Import raw fitness datasets, perform within-library fitness normalization, and generate normalized fitness tables.             |
| **02_all_variants_analysis.R**      | Merge normalized libraries into a unified variant dataset, perform statistical analyses, and classify variant fitness effects. |
| **03_single_nucleotide_variants.R** | Generate, analyze, and visualize the single-nucleotide mutation landscape.                                                     |
| **04_single_amino_acid_variants.R** | Construct the single-amino-acid substitution dataset and perform downstream analyses and visualizations.                       |
| **05_evaluate_VEPs.R**              | Benchmark computational variant-effect predictors against experimentally measured fitness data.                                |
| **06_evaluate_AF3_models.R**        | Evaluate and rank AlphaFold 3 structural models using experimental mutational data and structural analyses.                    |

The scripts are designed to be executed sequentially. We provide the input datasets and key intermediate output datasets required for each analysis step, as well as the key result tables used to generate the figures, see the `data/` directory.

