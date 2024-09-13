#!/bin/bash
#SBATCH --mem=120G

. /local/env/envconda3.sh
. genouest_conda_activate "python-3.8.5"
. /local/env/envjava-1.8.0.sh

cd /scratch/knam/Metazoa_holocentrism/Danaus_plexippus/SNV/gvcf

/scratch/knam/programs/gatk-4.1.2.0/gatk GenotypeGVCFs -R ../ref/GCA_009731565.1_Dplex_v4_genomic.fna --variant merged.Danaus_plexippus.g.vcf.gz -O ../vcf/Danaus_plexippus.raw.vcf.gz

cd ../vcf

/scratch/knam/programs/gatk-4.1.2.0/gatk SelectVariants -select-type SNP -R ../ref/GCA_009731565.1_Dplex_v4_genomic.fna -V Danaus_plexippus.raw.vcf.gz -O Danaus_plexippus.raw.SNP.vcf.gz 


