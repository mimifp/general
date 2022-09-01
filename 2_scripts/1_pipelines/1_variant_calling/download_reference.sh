#!/bin/bash
#SBATCH -c 8
#SBATCH -p thin-shared
#SBATCH -t 01:00:00
#SBATCH --mem=30G
#SBATCH --error=down_ref.err
#SBATCH --output=down_ref.out
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mail-user=miriam.ferreirop@gmail.com

module load samtools

cd $LUSTRE/03_reference_genomes
wget hgdownload.soe.ucsc.edu/goldenPath/hg19/bigZips/hg19.fa.gz
gzip -dk hg19.fa.gz
samtools faidx hg19.fa
