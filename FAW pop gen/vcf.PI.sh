#!/bin/bash

module load bioinfo/tabix-0.2.5
module load bioinfo/vcftools-0.1.16
cd ~/work/Metazoa_holocentrism/vcftools/result

vcftools --gzvcf ~/work/SNP.filtered.vcf.gz  --window-pi 100000 --out frugi.vcf.out


