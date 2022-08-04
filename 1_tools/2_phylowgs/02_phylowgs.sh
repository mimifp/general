#!/bin/bash

samples=(MDA_72_DNA
MDA_1_DNA
BL_40_DNA
BL_49_DNA
BL_56_DNA
BL_53_DNA
BL_88A_DNA
BL_103_DNA)

mkdir ~/projects/endometrial/vcf/evolve_results
cd ~/projects/endometrial/vcf/evolve_results

for id in ${samples[@]}
do
  mkdir $id
  cd $id
  python2 evolve.py ../../"ssm_"$id".txt" ../../"cnv_"$id".txt"
  cd ..
done


