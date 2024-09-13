#!/bin/bash


module load bioinfo/MACSE-v2.05

for file in $(find  ~/work/Metazoa_holocentrism/FAW_BAW/fasta/orthologs/*/ -type f -mmin +2 -print)
do
	java -jar $MACSE/macse.jar -prog alignSequences -seq "$file" 
done

