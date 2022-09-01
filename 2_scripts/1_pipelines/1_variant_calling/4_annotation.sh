#!/bin/bash
#SBATCH -c 24
#SBATCH -t 20:00:00
#SBATCH --mem=50G
#SBATCH --error=annotation.err
#SBATCH --output=annotation.out
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mail-type=fail
#SBATCH --mail-user=miriam.ferreirop@gmail.com

# Loading modules
module load cesga/2020 vep/104.3

# Loading variables from variables.txt file
mapfile -t a < variables.txt
declare "${a[@]}"

# Repeat for each file
while IFS= read -r sample; do
  echo "Processing $sample"

  cd ${VCF_PATH}/$sample
  # With SNPs
  # vep -i $sample"_somatic_filtered_vcftools.recode.vcf" -o $sample"_somatic_annotate_snps.vcf"  --cache --dir ${VEP_PATH} --port 3337 --check_existing --pick_allele_gene --sift b --polyphen b --af --af_1kg --allele_number --minimal --regulatory --vcf --force_overwrite --fork 24

  # Without SNPs
  vep -i $sample"_somatic_filtered_vcftools.recode.vcf" -o $sample"_somatic_annotate.vcf"  --cache --dir ${VEP_PATH} --port 3337 --check_existing --filter_common --check_frequency --freq_pop 1KG_EUR --freq_freq 0.01 --freq_gt_lt lt --freq_filter include --pick_allele_gene --sift b --polyphen b --af --af_1kg --allele_number --minimal --regulatory --vcf --force_overwrite --cache-version 102 --fork 24
  
  echo "Done for $sample"

done < sample.txt

sbatch ./5_vcf2maf.sh
