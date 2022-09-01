# Author: Miriam Ferreiro-Pantín
# Date: August 2022

## Important files
Before launch analysis, you have to modify two important files:
-samples.txt: Includes one sample per line. It's important leave a blank line at the end of the file.
-variables.txt: Includes one variable per line. It's important to add the path for all variables in the file.

## Pipeline
This pipeline consist on six main scripts, that allow you to annotate a fasta file:
-1_preprocessing.sh: This script indexes the reference genome and aligns the fastaq files against it. The result is one .bam file per sample along with its index (.bai).
-2_gatk.sh: This script mainly eliminates duplicates and recalibrates the quality scores of the bases according to GATK Best Practices. In addition, it contains commented code to create a .dict file, create a .fai file, adjust the .vcf chromosome nomenclature of known SNPs to the reference used and create a tbi index for .vcf file.
-3_variant_calling.sh: Variant calling with Mutect2 and filter results.
-4_annotation.sh: Annotation of vcf with VEP. Contains annotated code to also annotate SNPs.
-5_vcf2maf.sh: Convert vcf file in maf file.

## Other scripts
-download_cache_vep.sh: Modify the download url to obtain desired reference. Downloading VEP cache to use the desired reference genome is more efficient. However, if you use the default VEP genome online and do not use the cache, you must remove the --cache option from the VEP runs in the 4_annotation.sh script.
-reheader_bam.sh: Change header of BAM if it's neccesary for compatibility with the nomenclature of chromosomes in reference genome.
