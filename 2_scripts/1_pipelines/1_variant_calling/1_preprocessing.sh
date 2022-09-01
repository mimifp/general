#!/bin/bash
#SBATCH -c 8
#SBATCH -t 00:50:00
#SBATCH --mem=80G
#SBATCH --error=mapping.err
#SBATCH --output=mapping.out
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mail-type=fail
#SBATCH --mail-user=miriam.ferreirop@gmail.com

# Loading modules 
module load cesga/2020 gcccore/system bwa-mem2/2.2.1 samtools

# Loading variables form variables.txt file
mapfile -t a < variables.txt
declare "${a[@]}"

while IFS= read -r sample;do
  echo "Processing $sample"
  
  bwa-mem2 faidx ${REF_FILE}
  bwa-mem2 mem -t 8 ${REF_FILE} ${FASTA_FILE}/$(sample).fq > ${SAM_PATH}/$(sample).sam

  samtools view -S -b ${SAM_PATH}/$(sample).sam > ${BAM_PATH}/$(sample).bam
  samtools sort -o ${BAM_PATH}/$(sample).bam ${BAM_PATH}/$(sample).bam
  samtools index -b ${BAM_PATH}/$(sample).bam ${BAM_PATH}/$(sample).bam.bai -@ 8
  
  echo "Done for $sample"

done < samples.txt

sbatch ./2_gatk.sh
