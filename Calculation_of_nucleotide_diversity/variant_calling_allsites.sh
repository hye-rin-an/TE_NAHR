#!/bin/bash

. /local/env/envconda.sh
#conda install gatk4=4.1.2.0


#tabix /scratch/knam/Hyerin/Danaus_plexippus/merged.Danaus_plexippus.g.vcf.gz

#GATK

gatk GenotypeGVCFs  -R /scratch/knam/Hyerin/Danaus_plexippus/GCA_009731565.1_Dplex_v4_genomic.fna -V /scratch/knam/Hyerin/Danaus_plexippus/merged.Danaus_plexippus.g.vcf.gz  -all-sites -O /scratch/hran/FAW_TE/data/Danaus.allsites.vcf.gz

vcftools --gzvcf Danaus.allsites.vcf.gz --max-missing 0.2 --out Danaus.allsites.0.2.filtered --recode #Perform filtering

#conda activate ~/my_env
bgzip -f Danaus.allsites.0.2.filtered.recode.vcf #compress the new vcf file
tabix -f -p vcf Danaus.allsites.0.2.filtered.recode.vcf.gz #index the vcf file

gatk VariantFiltration -R /scratch/hran/FAW_TE/data/ref/GCA_009731565.1_Dplex_v4_genomic.fna -V /scratch/hran/FAW_TE/data/Danaus.allsites.0.2.filtered.recode.vcf.gz --filter-expression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0" --filter-name "my_snp_filter" -O /scratch/hran/FAW_TE/data/Danaus.allsites.annotated.vcf.gz

zgrep -v "^#" Danaus.allsites.annotated.vcf.gz | awk '$7 == "my_snp_filter" {print $1"\t"$2-1"\t"$2}' > danaus.filtered_snps.bed

vcftools --gzvcf Danaus.allsites.annotated.vcf.gz --exclude-bed danaus.filtered_snps.bed --recode-INFO-all --recode --stdout | bgzip -c > Danaus.allsites.annotated.filtered.vcf.gz
tabix -p vcf -f Danaus.allsites.annotated.filtered.vcf.gz

