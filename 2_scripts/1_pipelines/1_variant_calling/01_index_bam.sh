# Generate an index bam files (.bai) with samtools tool

#!/bin/bash
#SBATCH -c 8
#SBATCH -t 00:10:00
#SBATCH --mem=8G
#SBATCH --error=index_bam.err
#SBATCH --output=index_bam.out
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mail-type=fail
#SBATCH --mail-user=your_mail@gmail.com

#Repeat for each file
module load samtools

cd /path/to/bam/files/01_bam

# Index new bam file
for file in *.bam
do
   filename=`echo $file`
   samtools index -b $file ${filename}.bai -@ 8
done

cd $HOME
sbatch ./02_gatkbp.sh