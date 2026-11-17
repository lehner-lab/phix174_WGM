## Datasets

The `data/` directory contains input datasets, intermediate results, and analysis-ready datasets used for the mutational and structural analyses presented in this study.

| Path | Description |
|---|---|
| `data/raw_fitness_data/` | DiMSum output datasets, including variant fitness estimates, associated errors, and sequencing statistics for individual mutant libraries. |
| `data/processed_fitness_data/` | Normalized and processed mutational data, including combined variant-level datasets and analysis-ready single-nucleotide and single-amino-acid datasets. |
| `data/mutant_library_annotations/` | Mutant library designs and annotations, including nucleotide substitutions and corresponding amino acid changes. |
| `data/variant_genome_sequences/` | Genome sequences of designed and experimentally recovered ΦX174 variants. |
| `data/proteins_structural_data/` | ΦX174 protein structural data and residue-level annotations, including secondary structure, relative solvent accessibility (RSA), and interaction interfaces. |
| `data/fitness_scoring_structure/` | Residue-level mutational-effect data for mapping experimental measurements onto protein structures in ChimeraX. |
| `data/EVcouplings_MSA/` | Multiple sequence alignments and associated statistics generated using EVcouplings for ΦX174 proteins. |
| `data/evaluate_VEPs/` | Input datasets, predictor scores, and benchmarking results for evaluating computational variant-effect predictors against experimental measurements. |
| `data/evaluate_AF3_models/` | AlphaFold 3 model confidence metrics, structural comparisons, residue contacts, interface annotations, and mutational enrichment analyses. |
| `data/resolved_human_protein_complexes/` | Structural analyses of experimentally resolved human protein complexes, including chain mappings, FreeSASA solvent accessibility measurements, and ChimeraX residue contacts. |
| `data/summary_tables/` | Summary statistics and analysis results used to generate manuscript figures and supplementary datasets. |

The original analysis workflows are available in `R_scripts/`.
