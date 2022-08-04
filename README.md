# General scripts and tool tests

In this repository are stored some scripts of interest as well as different tests performed for different tools.

Structure of repository:
- 1_tools: tests and scripts to execute different tools.
  - [1_nextflow](1_tools/1_nextflow)
  - [2_phylowgs](1_tools/2_phylowgs)
- 2_scripts:
  - [1_pipelines](2_scripts/1_pipelines)
    - [1_variant_calling](2_scripts/1_pipelines/1_variant_calling): index bam, preprocess it with GATK best practices, variant calling with Mutect2 and annotation of vcf files with VEP tool.
  - [2_genomics](2_scripts/2_genomics): usefull scripts to process genomic data and files.
