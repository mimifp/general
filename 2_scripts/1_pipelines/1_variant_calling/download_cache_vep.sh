#!/bin/bash
#SBATCH -c 8
#SBATCH -p thin-shared
#SBATCH -t 01:00:00
#SBATCH --mem=40G
#SBATCH --error=down_cache_vep.err
#SBATCH --output=down_cache_vep.out
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mail-type=fail
#SBATCH --mail-user=miriam.ferreirop@gmail.com

cd $TRANSLATIONAL_ONCOLOGY/1_tools/.vep/homo_sapiens
curl -O http://ftp.ensembl.org/pub/release-105/variation/vep/homo_sapiens_vep_105_GRCh37.tar.gz
tar xzfv homo_sapiens_vep_105_GRCh37.tar.gz
