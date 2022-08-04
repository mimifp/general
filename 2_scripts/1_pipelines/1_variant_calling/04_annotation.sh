# Annotation of vcfs with VEP tool. 

#!/bin/bash
#SBATCH -c 24
#SBATCH -t 07:30:00
#SBATCH --mem=30G
#SBATCH --error=annotation.err
#SBATCH --output=annotation.out
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mail-type=fail
#SBATCH --mail-user=your_mail@gmail.com

module load cesga/2020 vep/104.3

# Repeat for each file
samples=(one
sample
name
one
row)

for id in ${samples[@]}
do
  cd /path/to/new_vcf/directory/$id
  # With SNPs
  vep -i $id_somatic_filtered_vcftools.recode.vcf -o $id_somatic_annotate_snps.vcf  --cache --dir $LUSTRE/.vep --port 3337 --check_existing --filter_common --check_frequency --freq_pop 1KG_EUR --pick_allele_gene --sift b --polyphen b --af --af_1kg --allele_number --minimal --regulatory --vcf --force_overwrite --fork 24

  # Without SNPs
  vep -i  $id_somatic_filtered_vcftools.recode.vcf -o $id_somatic_annotate.vcf  --cache --dir $LUSTRE/.vep --port 3337 --check_existing --filter_common --check_frequency --freq_pop 1KG_EUR --freq_freq 0.01 --freq_gt_lt lt --freq_filter include --pick_allele_gene --sift b --polyphen b --af --af_1kg --allele_number --minimal --regulatory --vcf --force_overwrite --fork 24

  # --dir: Specify the base cache/plugin directory to use. Default = "$HOME/.vep/"
done
