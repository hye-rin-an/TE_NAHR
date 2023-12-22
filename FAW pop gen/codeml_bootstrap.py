#!/bin/python
import os
import pandas as pd
import sys, re
from os.path import exists
import io
import shutil
directory='/home/work/han/Metazoa_holocentrism/FAW_BAW/fasta/orthologs/'
ch=""
for subdir, dirs, files in os.walk(directory):
    for filename in files:
        if re.search("phylip2",filename):
            x=re.search("CM\d+.\d",filename)
            x=x.group()
            shutil.copyfile(os.path.join(subdir, filename), "/home/work/han/Metazoa_holocentrism/FAW_BAW/fasta/orthologs/inputfile" )
        
            script="module load bioinfo/PAML/4.10.6 && cd /home/work/han/Metazoa_holocentrism/FAW_BAW/dnds/bts_resampling/"+x+" && codeml /home/work/han/Metazoa_holocentrism/FAW_BAW/dnds/script/bts.codeml.ctl"
            os.system(script)
            os.rename("/home/work/han/Metazoa_holocentrism/FAW_BAW/dnds/bts_resampling/" +x+ "/outputfile","/home/work/han/Metazoa_holocentrism/FAW_BAW/dnds/bts_resampling/"+x+"/"+x)
            os.remove("/home/work/han/Metazoa_holocentrism/FAW_BAW/fasta/orthologs/inputfile" )
