#!/bin/bash
#SBATCH -c 8
#SBATCH -t 11:30:00
#SBATCH --mem=30G
#SBATCH --error=variant_calling.err
#SBATCH --output=variant_calling.out
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mail-type=fail
#SBATCH --mail-user=miriam.ferreirop@gmail.com

# Loading modules
module load gatk vcftools

# Loading variables from variables.txt file
mapfile -t a < variables.txt
declare "${a[@]}"

while IFS= read -r sample; do
    echo "Text read from file: $sample"

    #mkdir ${VCF_PATH}/$sample
    cd ${VCF_PATH}/$sample

    gatk Mutect2 -R ${VEP_REF}  -I ${GATK_PATH}/$sample/"nodup_rec_"$sample".bam" -O $sample"_somatic.vcf"

    gatk FilterMutectCalls -R ${VEP_REF} -V $sample"_somatic.vcf" -O $sample"_somatic_filtered.vcf"

    # Pick variants which PASS all filters
    vcftools --vcf $sample"_somatic_filtered.vcf" --remove-filtered-all --recode-INFO-all --recode --out $sample"_somatic_filtered_vcftools"	
    
    echo "Done for $sample"
done < samples.txt

sbatch ./4_annotation.sh
