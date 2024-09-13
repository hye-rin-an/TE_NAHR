#!/bin/bash     
#SBATCH --cpus-per-task=2
#SBATCH -a 1-10
. /local/env/envbusco-5.4.6.sh	

cd /scratch/hran/lepidoptera/BUSCO/

INFILE=$(awk "NR==${SLURM_ARRAY_TASK_ID}" /scratch/hran/lepidoptera/BUSCO/species_list.txt)

cd /scratch/hran/lepidoptera/BUSCO

busco -i /scratch/hran/lepidoptera/data/genomes/$INFILE -o $INFILE -l lepidoptera_odb10 -m geno -c 4


