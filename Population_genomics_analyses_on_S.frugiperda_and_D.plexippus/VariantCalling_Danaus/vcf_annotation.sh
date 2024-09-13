#!/bin/bash



cd /scratch/hran/danaus/data/

/scratch/hran/programs/java-22/bin/java -jar /scratch/hran/programs/snpEff/snpEff.jar -c /scratch/hran/programs/snpEff/snpEff.config -v Dplex_v4 Danaus_RefSeq_ch.vcf.gz | gzip -f > Danaus.SNP.annotated.vcf.gz
