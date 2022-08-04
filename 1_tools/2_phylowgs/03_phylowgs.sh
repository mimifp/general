#!/bin/bash

samples=(MDA_72_DNA
MDA_1_DNA
BL_40_DNA
BL_49_DNA
BL_56_DNA
BL_53_DNA
BL_88A_DNA
BL_103_DNA)

for id in ${samples[@]}
do
  cd ~/projects/endometrial/vcf/evolve_results/$id
  python2 /home/yoel/miniconda3/envs/python2/bin/write_results.py $id trees.zip $id".summ.json.gz" $id".muts.json.gz" $id".mutass.zip"

done


