# Metadata

This folder contains the metadata and reference files required to reproduce the DiMSum analysis for each ΦX174 mutant library.

## Contents

```text
metadata/
├── README.md
├── DiMSum_library_parameters.tsv
├── experiment_designs/
│   ├── README.md
│   ├── lib1_experiment_design.tsv
│   ├── ...
│   └── libr1_experiment_design.tsv
└── variant_identity/
    ├── README.md
    ├── lib1_variant_identity.tsv
    ├── ...
    └── libr1_variant_identity.tsv
```

## `DiMSum_library_parameters.tsv`

This table contains one row for each mutant library and defines the library-specific inputs used to run DiMSum.

The columns include:

* `pool`: sequencing pool containing the library;
* `twist`: original Twist-library identifier;
* `library_id`: standardized library identifier, such as `lib6`;
* `library_label`: combined pool and library identifier, such as `pool1_lib6`;
* `include`: whether the library is included in the analysis;
* `experiment_design_file`: corresponding DiMSum experimental-design file;
* `variant_identity_file`: corresponding VariantIdentity file;
* `project_name`: project name used for the DiMSum output;
* `wildtype_sequence`: wild-type sequence analyzed for the library;
* `cutadapt5First`: 5′ constant sequence removed from read 1;
* `cutadapt5Second`: 5′ constant sequence removed from read 2;
* `notes`: optional library-specific comments.

The table is read by the DiMSum run script to assign the correct parameters to each library.

## `experiment_designs/`

This folder contains one DiMSum experimental-design file for each library.

Each file defines:

* input and output samples;
* biological replicate identifiers;
* selection status;
* selection replicate;
* technical replicate;
* paired-end FASTQ filenames.

The filenames follow the convention:

```text
<library_id>_experiment_design.tsv
```

For example:

```text
lib6_experiment_design.tsv
```

The FASTQ filenames refer to the lane-merged sequencing files used as input for DiMSum.

## `variant_identity/`

This folder contains one VariantIdentity file for each library.

Each file maps the designed barcode sequence to its corresponding variant sequence and contains two tab-separated columns:

```text
barcode	variant
```

The filenames follow the convention:

```text
<library_id>_variant_identity.tsv
```

For example:

```text
lib6_variant_identity.tsv
```

## Matching files across metadata types

Files belonging to the same library share the same standardized library identifier:

```text
lib6_experiment_design.tsv
lib6_variant_identity.tsv
```

The corresponding row in `DiMSum_library_parameters.tsv` links these files to the appropriate wild-type sequence, trimming sequences, pool, and DiMSum project name.

## Use in the pipeline

These metadata files are used together with the prepared paired-end FASTQ files by the DiMSum run script:

```text
scripts/run_all_dimsum.sh
```

The archived DiMSum result datasets generated during the original analysis are provided separately and are used as the starting point for the downstream fitness analyses.

