#!/bin/bash

. /local/env/envpython-3.9.5.sh
. /local/env/envconda.sh
conda activate ~/my_env
#conda install gblocks

for file in  $(find /scratch/hran/danaus/danaus_vanessa/result/orthologs/ -type f -name "*paths.txt")
do
	echo $file
        Gblocks "$file" -t=c -a=y 
done
conda deactivate
