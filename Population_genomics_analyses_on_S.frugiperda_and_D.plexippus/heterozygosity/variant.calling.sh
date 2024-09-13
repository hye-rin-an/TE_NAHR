#!/bin/bash
#SBATCH --mem=150G

module load devel/python/Python-3.11.1 devel/java/1.8.0_391

cd /home/knam/work/missing/FAW/ref

/home/knam/save/programs/gatk-4.1.2.0/gatk GenotypeGVCFs -R sfC.ver6.nc.fa  --variant ../../sfC.ver6.g.vcf.gz -O ../../sfC.ver6.unfiltered.allsites.vcf.gz --all-sites


