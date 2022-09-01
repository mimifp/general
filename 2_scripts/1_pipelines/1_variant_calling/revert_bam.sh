#!/bin/bash
#SBATCH -c 8
#SBATCH -p thin-shared
#SBATCH -t 00:30:00
#SBATCH --mem=20G
#SBATCH --error=revert_bam.err
#SBATCH --output=revert_bam.out
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mail-user=miriam.ferreirop@gmail.com

#Repeat for each file
module load cesga/2020 picard/2.25.5

java -jar $EBROOTPICARD/picard.jar RevertSam I=/mnt/lustre/scratch/home/usc/mg/mfp/01_bam/MDA_72_DNA.bam O=/mnt/lustre/scratch/home/usc/mg/mfp/01_bam/MDA_72_DNA_u.bam SANITIZE=true MAX_DISCARD_FRACTION=0.005 ATTRIBUTE_TO_CLEAR=XT ATTRIBUTE_TO_CLEAR=XN ATTRIBUTE_TO_CLEAR=AS ATTRIBUTE_TO_CLEAR=OC ATTRIBUTE_TO_CLEAR=OP SORT_ORDER=queryname RESTORE_ORIGINAL_QUALITIES=true REMOVE_DUPLICATE_INFORMATION=true REMOVE_ALIGNMENT_INFORMATION=true

