#!/bin/bash
#SBATCH -c 24
#SBATCH -t 20:00:00
#SBATCH --mem=40G
#SBATCH --error=vcf2maf.err
#SBATCH --output=vcf2maf.out
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mail-type=fail
#SBATCH --mail-user=miriam.ferreirop@gmail.com

# Loading modules
module load cesga/2020 vcf2maf/1.6.21

# Loading varaiables from variables.txt file
mapfile -t a < variables.txt
declare "${a[@]}"

while IFS= read -r sample; do
    echo "Processing $sample"

  vcf2maf.pl --input-vcf ${VCF_PATH}/$sample/$sample"_somatic_annotate.vcf" --output-maf ${VCF_PATH}/$sample/$sample"_filter.maf" --ref-fasta ${VEP_REF} --tumor-id $sample  --vep-data ${VEP_PATH} --inhibit-vep --cache-version 102 --vep-forks 24
    
    echo "Done for $sample"

done < sample.txt


