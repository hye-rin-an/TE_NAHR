#!/bin/bash
#SBATCH --mem=40G
#SBATCH -p unlimitq
module load bioinfo/VCFtools/0.1.16                                  
module load bioinfo/bgzip/1.18
module load bioinfo/tabix/1.18
module load bioinfo/Bcftools/1.17 

cd /home/han/work/Metazoa_holocentrism/gene_conversion/data/vcf/

#mv filtered.eresimus.SNP.vcf.gz plain.vcf
#bcftools view -Oz -o compressed.eresimus.vcf.gz plain.vcf
#bcftools index compressed.eresimus.vcf.gz

#mv filtered.gilippus.SNP.vcf.gz plain.vcf
#bcftools view -Oz -o compressed.gilippus.vcf.gz plain.vcf
#bcftools index compressed.gilippus.vcf.gz

#rm plain.vcf

#bcftools merge compressed.eresimus.vcf.gz compressed.gilippus.vcf.gz /home/han/work/Metazoa_holocentrism/danaus/compressed.Danaus_RefSeq_ch.vcf.gz | bgzip > alldanaus.SNP.vcf.gz
#tabix -p vcf alldanaus.SNP.vcf.gz


