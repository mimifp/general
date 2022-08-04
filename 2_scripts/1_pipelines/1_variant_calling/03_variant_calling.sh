# Variant calling with Mutect2 tool. Filter calls with FilterMutectCalls function and pick variants which PASS all filters with vcftools.

#!/bin/bash
#SBATCH -c 8
#SBATCH -t 05:00:00
#SBATCH --mem=30G
#SBATCH --error=variant_calling.err
#SBATCH --output=variant_calling.out
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mail-type=fail
#SBATCH --mail-user=your_mail@gmail.com

# Repeat for each file
samples=(one
sample
name
one
row)

REF=/path/to/reference/genome/GRCh37_canon.fa

module load gatk vcftools

for id in ${samples[@]}
do
  
  mkdir /path/to/new_vcf/directory/$id
  cd /path/to/new_vcf/directory/$id

  gatk Mutect2 -R ${REF}  -I /path/to/directory/gatk_results/$id_nochr.bam -O $id_somatic.vcf

  gatk FilterMutectCalls -R ${REF} -V $id_somatic.vcf -O $id_somatic_filtered.vcf

  # Pick variants which PASS all filters
  vcftools --vcf $id_somatic_filtered.vcf --remove-filtered-all --recode-INFO-all --recode --out $id_somatic_filtered_vcftools	

done

cd $HOME
sbatch ./04_annotation.sh
