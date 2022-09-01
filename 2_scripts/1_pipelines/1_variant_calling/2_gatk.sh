#!/bin/bash
#SBATCH -c 8
#SBATCH -t 10:00:00
#SBATCH --mem=30G
#SBATCH --error=gatkbp.err
#SBATCH --output=gatkbp.out
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mail-type=fail
#SBATCH --mail-user=miriam.ferreirop@gmail.com

# Loading modules
module load cesga/2020 gatk picard/2.25.5

# Loading variables from variables.txt file
mapfile -t a < variables.txt
declare "${a[@]}"

# Creating dict file
#module load samtools
#samtools dict ${VEP_REF} -o ${DICT_FILE}

# Creating fai file
#samtools faidx ${VEP_REF}

# Creating new known sites
#cd ${REF_FILES_PATH}
#bcftools annotate --rename-chrs chrchange.txt file_known_sites.vcf.gz -O z -o file_known_sites_chrchange.vcf.gz

# Creating tbi index for VCF
#module load tabix
#tabix -p vcf ${REF_FILES_PATH}

while IFS= read -r sample; do
   echo "Processing $sample"
   
   #mkdir ${GATK_PATH}/$sample
   cd ${GATK_PATH}/$sample

   # STEP 1. Remove duplicates in bam file(MarkDuplicatesSpark).
   java -jar $EBROOTPICARD/picard.jar SetNmMdAndUqTags I=${BAM_PATH}/$sample".bam" R=${VEP_REF} O=$sample".settags.bam"

   gatk MarkDuplicatesSpark --remove-all-duplicates -I $sample".settags.bam" -O "nodup_"$sample".bam" --conf 'spark.executor.cores=8' -M "marked_dup_metrics_"$sample".txt" -R ${VEP_REF}

   # STEP 2. Base quality scores recalibration (BQSR): BaseRecalibrator (builds model) and ApplyBQSR (adjust scores)
   gatk BaseRecalibrator -R ${VEP_REF}  -I "nodup_"$sample".bam" --known-sites ${REF_FILES_PATH}/file_known_sites.vcf.gz -O $sample"_recalibration.table"

   gatk ApplyBQSR -R ${VEP_REF} -I "nodup_"$sample".bam" --bqsr-recal-file $sample"_recalibration.table" -O "nodup_rec_"$sample".bam"
   
   echo "Done for $sample"

done < sample.txt

sbatch ./3_variant_calling.sh
