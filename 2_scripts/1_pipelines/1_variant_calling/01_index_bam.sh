#!/bin/bash
#SBATCH -c 8
#SBATCH -p thin-shared
#SBATCH -t 04:00:00
#BATCH --mem=30G
#SBATCH --error=index_bam.err
#SBATCH --output=index_bam.out
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mail-user=miriam.ferreirop@gmail.com

#Repeat for each file
module load samtools

cd /mnt/lustre/scratch/home/usc/mg/mfp/01_bam/01_originals

# Change header of bam
for file in *.bam
do
  filename=`echo $file | cut -d "." -f 1`
  samtools view -H $file | \
        sed -e 's/SN:chr1/SN:1/' | sed -e 's/SN:chr2/SN:2/' | \
        sed -e 's/SN:chr3/SN:3/' | sed -e 's/SN:chr4/SN:4/' | \
        sed -e 's/SN:chr5/SN:5/' | sed -e 's/SN:chr6/SN:6/' | \
        sed -e 's/SN:chr7/SN:7/' | sed -e 's/SN:chr8/SN:8/' | \
        sed -e 's/SN:chr9/SN:9/' | sed -e 's/SN:chr10/SN:10/' | \
        sed -e 's/SN:chr11/SN:11/' | sed -e 's/SN:chr12/SN:12/' | \
        sed -e 's/SN:chr13/SN:13/' | sed -e 's/SN:chr14/SN:14/' | \
        sed -e 's/SN:chr15/SN:15/' | sed -e 's/SN:chr16/SN:16/' | \
        sed -e 's/SN:chr17/SN:17/' | sed -e 's/SN:chr18/SN:18/' | \
        sed -e 's/SN:chr19/SN:19/' | sed -e 's/SN:chr20/SN:20/' | \
        sed -e 's/SN:chr21/SN:21/' | sed -e 's/SN:chr22/SN:22/' | \
        sed -e 's/SN:chrX/SN:X/' | sed -e 's/SN:chrY/SN:Y/' | \
        sed -e 's/SN:chrM/SN:MT/' | samtools reheader - $file > ${filename}_nochr.bam

	mv ${filename}_nochr.bam /mnt/lustre/scratch/home/usc/mg/mfp/01_bam/02_nochr
done 

cd /mnt/lustre/scratch/home/usc/mg/mfp/01_bam/02_nochr

# Index new bam file
for file in *.bam
do
   filename=`echo $file`
   samtools index -b $file ${filename}.bai -@ 8
done

cd $HOME
sbatch ./02_gatkbp.sh
