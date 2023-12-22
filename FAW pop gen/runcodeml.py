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
        if re.search("filtered.phylip$",filename):
            x=re.search("CM\d+.\d",subdir)
            x=x.group()
            if x  != ch:
                os.mkdir("/home/work/han/Metazoa_holocentrism/FAW_BAW/dnds/result/folder")
                os.rename("/home/work/han/Metazoa_holocentrism/FAW_BAW/dnds/result/folder","/home/work/han/Metazoa_holocentrism/FAW_BAW/dnds/result/"+x)
            shutil.copyfile(os.path.join(subdir, filename), directory+"inputfile" )
            os.mkdir("/home/work/han/Metazoa_holocentrism/FAW_BAW/dnds/result/"+x+"/subfolder")
            script="module load bioinfo/PAML/4.10.6 && cd /home/work/han/Metazoa_holocentrism/FAW_BAW/dnds/result/"+x+"/subfolder && codeml /home/work/han/Metazoa_holocentrism/FAW_BAW/dnds/script/codeml.ctl"
            os.system(script)
            OG=re.search(".*NT",filename)
            OG=OG.group()
            os.rename('/home/work/han/Metazoa_holocentrism/FAW_BAW/dnds/result/' +x+ "/subfolder/outputfile","/home/work/han/Metazoa_holocentrism/FAW_BAW/dnds/result/"+x +"/subfolder/"+OG)
            os.rename("/home/work/han/Metazoa_holocentrism/FAW_BAW/dnds/result/"+x+ "/subfolder","/home/work/han/Metazoa_holocentrism/FAW_BAW/dnds/result/"+x+"/"+OG)
            os.remove(directory+"inputfile" )
            ch=x
