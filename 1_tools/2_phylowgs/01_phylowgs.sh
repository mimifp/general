#!/bin/bash

cd ~/projects/endometrial/vcf

for file in *.vcf
do 
  filename=`echo $file | cut -d "." -f 1`
  create_phylowgs_inputs.py sample1=${filename}.vcf --vcf-type sample1=mutect_smchet --regions all --output-variants ssm_${filename}.txt --output-cnvs cnv_${filename}.txt --output-params params_${filename}.json

done



