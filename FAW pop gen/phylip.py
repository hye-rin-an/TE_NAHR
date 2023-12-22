#!/bin/python
import os
import pandas as pd
import sys, re
from os.path import exists
import io

sub=""
exigua=""
frugi=""
directory='/home/han/work/Metazoa_holocentrism/FAW_BAW/fasta/orthologs/'
for subdir, dirs, files in os.walk(directory):
    for filename in files:
        if re.search(".filtered$",filename):
            print(os.path.join(subdir, filename))
            file1=open(os.path.join(subdir, filename), "r")
            count = 0
            frugi=""
            exigua=""
            while True:
                count += 1
                line = file1.readline()
                line=re.sub("\s+","", line)
                if re.search(">frugi",line):
                    x="frugi"
                if re.search(">exigua",line):
                    x="exigua"
                if not re.search(">", line):
                    if x=="frugi":
                        frugi=frugi+line
                    if x=="exigua":
                        exigua=exigua+line
                if not line:
                    break
            file1.close()
            frugi = frugi.replace("!", "N")
            exigua = exigua.replace("!","N")

            print (len(frugi))
            print(len(exigua))
            fasta="      2   "+str(len(frugi))+"\n\n"+"exigua    "+exigua+"\n"+"sfrugi     "+frugi
            with open(os.path.join(subdir, filename)+".phylip","w")as tfile:
                tfile.write(''.join(fasta))
            tfile.close()
			
