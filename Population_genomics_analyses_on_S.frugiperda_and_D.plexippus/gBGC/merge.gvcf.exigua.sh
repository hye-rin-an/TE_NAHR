#!/bin/bash
#SBATCH --mem=40G
#SBATCH -p unlimitq
module load bioinfo/VCFtools/0.1.16                                  

cd /home/han/work/Metazoa_holocentrism/gene_conversion/data/mergedgvcf/
/home/knam/save/programs/gatk-4.1.2.0/gatk CombineGVCFs -R /home/han/work/Metazoa_holocentrism/ref/sfC.ver6.fa -O merged.exigua.g.vcf.gz --variant ../gvcf/ERR4094925.g.vcf.gz --variant ../gvcf/ERR4094926.g.vcf.gz 

/home/knam/save/programs/gatk-4.1.2.0/gatk GenotypeGVCFs -R /home/han/work/Metazoa_holocentrism/ref/sfC.ver6.fa --variant merged.exigua.g.vcf.gz -O ../vcf/merged.exigua.vcf.gz -all-sites

cd ../vcf

/home/knam/save/programs/gatk-4.1.2.0/gatk SelectVariants -select-type SNP -R /home/han/work/Metazoa_holocentrism/ref/sfC.ver6.fa -V merged.exigua.vcf.gz -O merged.exigua.SNP.vcf.gz

vcftools --gzvcf merged.exigua.SNP.vcf.gz --max-missing 0.33 --recode --stdout | gzip -c > filtered.exigua.SNP.vcf.gz

