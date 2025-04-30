#!/bin/bash

cd /scratch/knam/Metazoa_holocentrism/Danaus_plexippus/SNV/adaptor

zcat /scratch/knam/Metazoa_holocentrism/Danaus_plexippus/SNV/rawfq/SRR1549524_1.fastq.gz | head -n 14896580 > R1.fq
zcat /scratch/knam/Metazoa_holocentrism/Danaus_plexippus/SNV/rawfq/SRR1549524_2.fastq.gz | head -n 14896580 > R2.fq

/scratch/knam/programs/adapterremoval-2.1.7/build/AdapterRemoval --file1 R1.fq --file2 R2.fq  --identify-adapters &> adapterinfo

rm R1.fq
rm R2.fq


