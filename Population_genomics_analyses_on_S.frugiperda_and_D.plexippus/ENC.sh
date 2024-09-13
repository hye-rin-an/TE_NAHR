#!/bin/bash

. /local/env/envpython-3.9.5.sh		
. /local/env/envconda.sh
conda activate ~/my_env

codonw /scratch/hran/sfrugi/data/frugi.cds_from_genomic.fna /scratch/hran/sfrugi/result/enc -enc -nomenu

