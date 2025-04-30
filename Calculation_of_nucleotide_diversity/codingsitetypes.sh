#!/bin/bash

module load devel/python/Python-3.11.1
module load bioinfo/bgzip/1.18
module load bioinfo/tabix/1.18
module load bioinfo/Bcftools/1.17

python3 /home/han/save/programs/genomics_general/codingSiteTypes.py -a ../data/OGS6.1.gff3 -f gff3 -r ../data/sfC.ver6.fa -v ../data/FAW.allsites.0.8.filtered.recode.vcf.gz --ignoreConflicts | bgzip > ../result/sfC.coding_site_types.tsv.gz

python3 /home/han/save/programs/genomics_general/codingSiteTypes.py -a ../data/ref/GCA_009731565.1_Dplex_v4_genomic.gff -f gff3 -r ../data/ref/GCA_009731565.1_Dplex_v4_genomic.fna -v ../data/Danaus.allsites.0.8.filtered.recode.vcf.gz --ignoreConflicts | bgzip > ../result/Dplex.coding_site_types.tsv.gz

#bed files
gunzip -c ../result/Dplex.coding_site_types.tsv.gz | awk 'BEGIN {OFS="\t"}; $5=="4" {print($1,$2-1,$2)}' > ../data/Dplex.4Dsites.bed

gunzip -c ../result/sfC.coding_site_types.tsv.gz | awk 'BEGIN {OFS="\t"}; $5=="4" {print($1,$2-1,$2)}' > ../data/sfC.4Dsites.bed

#4D site files
gunzip -c ../result/Dplex.coding_site_types.tsv.gz | awk 'BEGIN {OFS="\t"}; $5=="4" {print($1,$2)}' > ../data/Dplex.4Dsites

gunzip -c ../result/sfC.coding_site_types.tsv.gz | awk 'BEGIN {OFS="\t"}; $5=="4" {print($1,$2)}' > ../data/sfC.4Dsites

#0D site files
gunzip -c ../result/Dplex.coding_site_types.tsv.gz | awk 'BEGIN {OFS="\t"}; $5=="0" {print($1,$2)}' > ../data/Dplex.0Dsites

gunzip -c ../result/sfC.coding_site_types.tsv.gz | awk 'BEGIN {OFS="\t"}; $5=="0" {print($1,$2)}' > ../data/sfC.0Dsites

#bed files
gunzip -c ../result/Dplex.coding_site_types.tsv.gz | awk 'BEGIN {OFS="\t"}; $5=="0" {print($1,$2-1,$2)}' > ../data/Dplex.0Dsites.bed

gunzip -c ../result/sfC.coding_site_types.tsv.gz | awk 'BEGIN {OFS="\t"}; $5=="0" {print($1,$2-1,$2)}' > ../data/sfC.0Dsites.bed

