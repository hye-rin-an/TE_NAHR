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
        if re.search(".phylip2",filename):
            x=re.search("CM\d+.\d",filename)
            x=x.group()
            shutil.copyfile(os.path.join(subdir, filename), directory+"inputfile" )
            script="module load bioinfo/PAML/4.10.6 && cd /home/work/han/Metazoa_holocentrism/FAW_BAW/dnds/result/"+x+" && codeml /home/work/han/Metazoa_holocentrism/FAW_BAW/dnds/script/codeml.ctl"
            os.system(script)
            os.rename('/home/work/han/Metazoa_holocentrism/FAW_BAW/dnds/result/' +x+ "/outputfile","/home/work/han/Metazoa_holocentrism/FAW_BAW/dnds/result/"+x +"/"+x)
            os.remove(directory+"inputfile" )
