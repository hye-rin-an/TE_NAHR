#!/bin/bash

. /local/env/envconda3.sh
. genouest_conda_activate "python-3.8.5"
. /local/env/envjava-1.8.0.sh

cd /scratch/knam/Metazoa_holocentrism/Danaus_plexippus/SNV/ref

/scratch/knam/programs/gatk-4.1.2.0/gatk CreateSequenceDictionary -R GCA_009731565.1_Dplex_v4_genomic.fna -O GCA_009731565.1_Dplex_v4_genomic.dict

