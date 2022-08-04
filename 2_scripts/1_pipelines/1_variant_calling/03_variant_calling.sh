#!/bin/bash
#SBATCH -c 8
#SBATCH -p thin-shared
#SBATCH -t 05:00:00
#SBATCH --mem=30G
#SBATCH --error=variant_calling.err
#SBATCH --output=variant_calling.out
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mail-user=miriam.ferreirop@gmail.com

# Repeat for each file
samples=(MDA_072
MDA_1
BL_40
BL_49
BL_56
BL_53
BL_88A
BL_103)

REF=/mnt/lustre/scratch/home/usc/mg/mfp/03_reference_genomes/GRCh37_canon.fa

module load gatk vcftools

for id in ${samples[@]}
do
  
  mkdir /mnt/lustre/scratch/home/usc/mg/mfp/02_vcf/02_new_vcf/$id
  cd /mnt/lustre/scratch/home/usc/mg/mfp/02_vcf/02_new_vcf/$id

  gatk Mutect2 -R ${REF}  -I /mnt/lustre/scratch/home/usc/mg/mfp/04_gatk_results/$id_nochr.bam -O $id_somatic.vcf

  gatk FilterMutectCalls -R ${REF} -V $id_somatic.vcf -O $id_somatic_filtered.vcf

  # Pick variants which PASS all filters
  vcftools --vcf $id_somatic_filtered.vcf --remove-filtered-all --recode-INFO-all --recode --out $id_somatic_filtered_vcftools	

done

cd $HOME
sbatch ./04_annotation.sh
