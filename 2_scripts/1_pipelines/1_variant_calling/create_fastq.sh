#!/bin/bash
#SBATCH -c 8
#SBATCH -p thin-shared
#SBATCH -t 00:30:00
#SBATCH --mem=20G
#SBATCH --error=create_fastq.err
#SBATCH --output=create_fastq.out
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mail-user=miriam.ferreirop@gmail.com

#Repeat for each file
module load picard/2.25.5
java -jar $EBROOTPICARD/picard.jar SamToFastq I=/mnt/lustre/scratch/home/usc/mg/mfp/01_bam/MDA_72_DNA_u.bam F=/mnt/lustre/scratch/home/usc/mg/mfp/04_fasta/MDA_72_DNA.fq 

