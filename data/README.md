## Datasets

The `data/` directory contains input datasets, intermediate results, and analysis-ready tables required to reproduce the analyses presented in this study.

| Path | Description |
| --- | --- |
| `data/raw_fitness_data/` | Raw DiMSum fitness estimates, sequencing statistics, and associated error estimates for individual mutant libraries. |
| `data/variant_genome_sequences/` | Genome sequences of designed and recovered ΦX174 variants. |
| `data/mutant_library_annotations/` | Mutant library designs and sequence annotations, including designed variants, nucleotide substitutions, and corresponding amino acid changes. |
| `data/proteins_structural_data/` | Protein structural data and residue-level annotations, including secondary structure, relative solvent accessibility (RSASA), and protein interaction interfaces (atomic contacts). |
| `data/processed_fitness_data/` | Normalized and processed fitness datasets, including combined variant-level data and analysis-ready single-nucleotide and single-amino-acid mutation datasets. |
| `data/fitness_scoring_structure/` | Residue-level mutational effect data for coloring and visualizing protein structures in ChimeraX. |
| `data/summary_tables/` | Summary statistics and result tables generated from mutational analyses and used for figures and supplementary data. |
| `data/EVcouplings_MSA/` | Multiple sequence alignments generated using EVcouplings and associated statistics for ΦX174 proteins. |
| `data/evaluate_VEPs/` | Datasets and results for benchmarking computational variant-effect predictors against experimentally measured mutational effects. |
| `data/evaluate_AF3_models/` | Data for evaluating AlphaFold 3 structural models, including model confidence metrics, residue contacts, interface analyses, structural alignments, and enrichment statistics. |

## Data availability 
All sequencing data have been deposited in the European Nucleotide Archive (ENA) at EMBL-EBI under accession number PRJEB120835. Original DiMSum output datasets and sequencing-depth downsampling analysis datasets are available on Zenodo at https://doi.org/10.5281/zenodo.23889881. EVcouplings multiple-sequence alignments for ΦX174 proteins across UniRef100, UniRef90, and MGnify+UniProt searches are available on Zenodo at https://doi.org/10.5281/zenodo.23889160. AlphaFold 3 models and structural analyses of ΦX174 protein A-DNA and protein A-C interactions are available on Zenodo at https://doi.org/10.5281/zenodo.23880305. Sequence alignments Evo-designed ΦX174 genomes are available on Zenodo at https://doi.org/10.5281/zenodo.23890094. All analysis scripts required to reproduce the analyses presented in this study are available from the project's GitHub repository.
