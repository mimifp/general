#!/bin/bash
#SBATCH -c 12
#SBATCH -p thin-shared
#SBATCH -t 02:00:00
#SBATCH --mem=30G
#SBATCH --error=chrchange.err
#SBATCH --output=chrchange.out
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mail-user=miriam.ferreirop@gmail.com

# Creating new known sites

module load bcftools

cd /mnt/lustre/scratch/home/usc/mg/mfp/03_reference_genomes
bcftools annotate --rename-chrs chrchange.txt 00-All.vcf.gz -O z -o 00-All-chrchange.vcf.gz --threads 12
