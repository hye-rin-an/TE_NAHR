#!/bin/bash
#SBATCH --mem=40G
#SBATCH -p unlimitq
module load bioinfo/VCFtools/0.1.16                                  

cd /home/han/work/Metazoa_holocentrism/gene_conversion/data/mergedgvcf/
/home/knam/save/programs/gatk-4.1.2.0/gatk CombineGVCFs -R /home/han/work/Metazoa_holocentrism/ref/sfC.ver6.fa -O merged.litura.g.vcf.gz --variant ../gvcf/SRR5132444.g.vcf.gz --variant ../gvcf/SRR5132445.g.vcf.gz --variant ../gvcf/SRR5132446.g.vcf.gz

/home/knam/save/programs/gatk-4.1.2.0/gatk GenotypeGVCFs -R /home/han/work/Metazoa_holocentrism/ref/sfC.ver6.fa --variant merged.litura.g.vcf.gz -O ../vcf/merged.litura.vcf.gz -all-sites

cd ../vcf

/home/knam/save/programs/gatk-4.1.2.0/gatk SelectVariants -select-type SNP -R /home/han/work/Metazoa_holocentrism/ref/sfC.ver6.fa -V merged.litura.vcf.gz -O merged.litura.SNP.vcf.gz

vcftools --gzvcf merged.litura.SNP.vcf.gz --max-missing 0.33 --recode --stdout | gzip -c > \ filtered.litura.SNP.vcf.gz

