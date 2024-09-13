#!/bin/bash
#SBATCH --mem=40G
#SBATCH -p unlimitq
module load bioinfo/VCFtools/0.1.16                                  
module load bioinfo/bgzip/1.18
module load bioinfo/tabix/1.18
module load bioinfo/Bcftools/1.17

cd /home/han/work/Metazoa_holocentrism/gene_conversion/data/vcf/

#mv filtered.exigua.SNP.vcf.gz 1plain.vcf
#bcftools view -Oz -o compressed.exigua.vcf.gz 1plain.vcf
#bcftools index compressed.exigua.vcf.gz

#mv filtered.litura.SNP.vcf.gz 1plain.vcf
#bcftools view -Oz -o compressed.litura.vcf.gz 1plain.vcf
#bcftools index compressed.litura.vcf.gz

#bcftools merge compressed.exigua.vcf.gz compressed.litura.vcf.gz /home/han/work/Metazoa_holocentrism/gene_conversion/data/compressed.SNP.filtered.vcf.gz | bgzip > allfrugi.SNP.vcf.gz
#tabix -p vcf allfrugi.SNP.vcf.gz


