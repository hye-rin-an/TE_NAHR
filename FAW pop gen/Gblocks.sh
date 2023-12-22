#!/bin/bash


module load bioinfo/Gblocks_0.91b 

for file in $(find  ~/work/Metazoa_holocentrism/FAW_BAW/fasta/orthologs/ -type f -name "*NT.fa")
do
	Gblocks "$file" -t=d
done

