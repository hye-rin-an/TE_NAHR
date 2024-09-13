#!/bin/bash
#SBATCH --mem=40G
#SBATCH -p unlimitq

module load bioinfo/VCFtools/0.1.16                                  
cd /home/han/work/Metazoa_holocentrism/gene_conversion/data/mergedgvcf/
#/home/knam/save/programs/gatk-4.1.2.0/gatk CombineGVCFs -R /home/han/work/Metazoa_holocentrism/ref/GCF_009731565.1_Dplex_v4_genomic.fna -O merged.gilippus.g.vcf.gz --variant ../gvcf/SRR1552524.g.vcf.gz --variant ../gvcf/SRR1552525.g.vcf.gz --variant ../gvcf/SRR1980588.g.vcf.gz 

#/home/knam/save/programs/gatk-4.1.2.0/gatk GenotypeGVCFs -R /home/han/work/Metazoa_holocentrism/ref/GCF_009731565.1_Dplex_v4_genomic.fna --variant merged.gilippus.g.vcf.gz -O ../vcf/merged.gilippus.vcf.gz -all-sites

cd ../vcf

#/home/knam/save/programs/gatk-4.1.2.0/gatk SelectVariants -select-type SNP -R /home/han/work/Metazoa_holocentrism/ref/GCF_009731565.1_Dplex_v4_genomic.fna -V merged.gilippus.vcf.gz -O merged.gilippus.SNP.vcf.gz

vcftools --gzvcf merged.gilippus.SNP.vcf.gz --max-missing 0.33 --recode --stdout | gzip -c > filtered.gilippus.SNP.vcf.gz
