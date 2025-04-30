#!/bin/bash
#SBATCH --mem=200G
#SBATCH -p unlimitq

module load bioinfo/VCFtools/0.1.16
module load bioinfo/bgzip/1.18

cd /home/han/work/FAW_TE/data

#recode 0D sites only

vcftools --gzvcf Danaus.allsites.vcf.gz --bed Dplex.0Dsites.bed --recode-INFO-all --recode --stdout | bgzip -c > Danaus.allsites.0D.vcf.gz

#recode 0D sites only

vcftools --gzvcf Danaus.allsites.vcf.gz --bed Dplex.4Dsites.bed --recode-INFO-all --recode --stdout | bgzip -c > Danaus.allsites.4D.vcf.gz



