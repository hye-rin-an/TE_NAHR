#!/bin/bash
#SBATCH --mem=40G
#SBATCH -p unlimitq
module load bioinfo/VCFtools/0.1.16                      

cd /home/han/work/Metazoa_holocentrism/gene_conversion/data/mergedgvcf/
#/home/knam/save/programs/gatk-4.1.2.0/gatk CombineGVCFs -R /home/han/work/Metazoa_holocentrism/ref/GCF_009731565.1_Dplex_v4_genomic.fna -O merged.eresimus.g.vcf.gz --variant ../gvcf/SRR1552522.g.vcf.gz --variant ../gvcf/SRR1552523.g.vcf.gz 

#/home/knam/save/programs/gatk-4.1.2.0/gatk GenotypeGVCFs -R /home/han/work/Metazoa_holocentrism/ref/GCF_009731565.1_Dplex_v4_genomic.fna --variant merged.eresimus.g.vcf.gz -O ../vcf/merged.eresimus.vcf.gz -all-sites

cd ../vcf

#/home/knam/save/programs/gatk-4.1.2.0/gatk SelectVariants -select-type SNP -R /home/han/work/Metazoa_holocentrism/ref/GCF_009731565.1_Dplex_v4_genomic.fna -V merged.eresimus.vcf.gz -O merged.eresimus.SNP.vcf.gz

vcftools --gzvcf merged.eresimus.SNP.vcf.gz --max-missing 0.5 --recode --stdout | gzip -c > filtered.eresimus.SNP.vcf.gz

