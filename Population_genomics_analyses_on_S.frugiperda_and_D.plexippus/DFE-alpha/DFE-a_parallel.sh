#!/bin/bash	
#SBATCH --cpus-per-task=2
#SBATCH -a 1-31
cd /scratch/hran/sfrugi/result/DFE-a

INFILE=$(awk "NR==${SLURM_ARRAY_TASK_ID}" /scratch/hran/sfrugi/script/DFE-a/chr_list.txt)


#DFE
#mkdir -p /scratch/hran/sfrugi/result/DFE-a/$INFILE
sed "s/sfs.txt/$INFILE/" /scratch/hran/sfrugi/script/DFE-a/config-file.est_dfe_class2.txt | sed "s/OUT/$INFILE/" > /scratch/hran/sfrugi/script/DFE-a/$INFILE.txt
 /scratch/hran/programs/dfe-alpha-release-2.16/est_dfe -c /scratch/hran/sfrugi/script/DFE-a/$INFILE.txt

#alpha
sed "s/IN/$INFILE/g" /scratch/hran/sfrugi/script/DFE-a/config-file.est_alpha_omega.txt  > /scratch/hran/sfrugi/script/DFE-a/$INFILE.txt

/scratch/hran/programs/dfe-alpha-release-2.16/est_alpha_omega -c /scratch/hran/sfrugi/script/DFE-a/$INFILE.txt
rm /scratch/hran/sfrugi/script/DFE-a/$INFILE.txt 
