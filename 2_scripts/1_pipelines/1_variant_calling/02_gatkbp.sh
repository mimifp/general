#!/bin/bash
#SBATCH -c 8
#SBATCH -p thin-shared
#SBATCH -t 05:00:00
#SBATCH --mem=30G
#SBATCH --error=gatkbp.err
#SBATCH --output=gatkbp.out
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
KNOWN_SITES=/mnt/lustre/scratch/home/usc/mg/mfp/03_reference_genomes/known_variants_grch37.vcf.gz

module load gatk cesga/2020 picard/2.25.5

for id in ${samples[@]}
do

  mkdir /mnt/lustre/scratch/home/usc/mg/mfp/04_gatk_results/$id
  cd /mnt/lustre/scratch/home/usc/mg/mfp/04_gatk_results/$id

  # STEP 1. Remove duplicates in bam file(MarkDuplicatesSpark).
  java -jar $EBROOTPICARD/picard.jar SetNmMdAndUqTags I=/mnt/lustre/scratch/home/usc/mg/mfp/01_bam/02_nochr/$id_nochr.bam R=${REF}  O=$id.settags.bam

  gatk MarkDuplicatesSpark --remove-all-duplicates -I $id.settags.bam -O nodup_$id.bam --conf 'spark.executor.cores=8' -M marked_dup_metrics$id.txt -R ${REF}

  # STEP 2. Base quality scores recalibration (BQSR): BaseRecalibrator (builds model) and ApplyBQSR (adjust scores)
  gatk BaseRecalibrator -R ${REF}  -I nodup_$id.bam --known-sites ${KNOWN_SITES} -O $id_recalibration.table

  gatk ApplyBQSR -R ${REF} -I nodup_$id.bam --bqsr-recal-file $id_recalibration.table -O nodup_rec_$id.bam

done

cd $HOME
sbatch ./03_variant_calling.sh
