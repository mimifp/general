# Use of GATK tool to preprocess bam files before variant calling. Steps are remove duplicates (Picard tool and MarkDuplicatesSpark function), base quality scores recalibration (BaseRecalibrator, to builds model, and ApplyBQSR, to adjust scores, functions).

#!/bin/bash
#SBATCH -c 8
#SBATCH -t 05:00:00
#SBATCH --mem=30G
#SBATCH --error=gatkbp.err
#SBATCH --output=gatkbp.out
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
KNOWN_SITES=/path/to/known/variants/known_variants_grch37.vcf.gz

module load gatk cesga/2020 picard/2.25.5

for id in ${samples[@]}
do

  mkdir /path/to/directory/gatk_results/$id
  cd /path/to/directory/gatk_results/$id

  # STEP 1. Remove duplicates in bam file(MarkDuplicatesSpark).
  java -jar $EBROOTPICARD/picard.jar SetNmMdAndUqTags I=/path/to/bam/files/$id_nochr.bam R=${REF}  O=$id.settags.bam

  gatk MarkDuplicatesSpark --remove-all-duplicates -I $id.settags.bam -O nodup_$id.bam --conf 'spark.executor.cores=8' -M marked_dup_metrics$id.txt -R ${REF}

  # STEP 2. Base quality scores recalibration (BQSR): BaseRecalibrator (builds model) and ApplyBQSR (adjust scores)
  gatk BaseRecalibrator -R ${REF}  -I nodup_$id.bam --known-sites ${KNOWN_SITES} -O $id_recalibration.table

  gatk ApplyBQSR -R ${REF} -I nodup_$id.bam --bqsr-recal-file $id_recalibration.table -O nodup_rec_$id.bam

done

cd $HOME
sbatch ./03_variant_calling.sh
