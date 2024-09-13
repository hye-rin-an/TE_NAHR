#!/bin/bash
#SBATCH --mem=60G

. /local/env/envconda3.sh
. genouest_conda_activate "python-3.8.5"
. /local/env/envjava-1.8.0.sh

cd /scratch/knam/Metazoa_holocentrism/Danaus_plexippus/SNV/vcf

/scratch/knam/programs/gatk-4.1.2.0/gatk VariantFiltration -R ../ref/GCA_009731565.1_Dplex_v4_genomic.fna -V Danaus_plexippus.raw.SNP.vcf.gz --filter-expression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0" --filter-name "my_snp_filter" -O Danaus_plexippus.annotated.SNP.vcf.gz

zcat Danaus_plexippus.annotated.SNP.vcf.gz | grep -P '#|PASS' | /home/genouest/inra_umr1333/knam/programs/samtools-1.19.2/htslib-1.19.1/bgzip > Danaus_plexippus.filtered.SNP.vcf.gz


