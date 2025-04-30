#!/bin/bash

cd /scratch/knam/Metazoa_holocentrism/Danaus_plexippus/SNV/ref

/home/genouest/inra_umr1333/knam/programs/samtools-1.19.2/samtools faidx GCA_009731565.1_Dplex_v4_genomic.fna

/scratch/knam/programs/bowtie2-2.3.4.1-linux-x86_64/bowtie2-build GCA_009731565.1_Dplex_v4_genomic.fna Dplex_v4


