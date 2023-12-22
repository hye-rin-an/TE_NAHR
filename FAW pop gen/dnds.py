#!/bin/python
import os
import pandas as pd
import sys, re
from os.path import exists
import io
df = pd.DataFrame(columns=["chromosome","w","k","N","S","dN","dS"])

directory='/home/han/work/Metazoa_holocentrism/FAW_BAW/dnds/result/'
for subdir, dirs, files in os.walk(directory):
    for filename in files:
        if re.search("CM",filename):
            print(os.path.join(subdir, filename))
            file1=open(os.path.join(subdir, filename), "r")
            x=re.search("CM\d+.\d",filename)
            x=x.group()

            count = 0
            while True:
                count += 1
                line = file1.readline()
                if re.search("kappa",line):
                    kappa=re.search("\d+.\d+", line)
                    kappa=kappa.group()
                if re.search("omega",line):
                    omega=re.search("\d+.\d+", line)
                    omega=omega.group()
                if re.search("3\.\.1",line):
                    if re.search("\d+\.\d+",line):
                        line=line.replace("\s+","\s")
                        y=line.split()
                        print(line)
                        N=y[2]
                        S=y[3]
                if re.search("tree length for dN",line):
                    dN=re.search("\d+.\d+", line)
                    dN=dN.group()
                if re.search("tree length for dS",line):
                    dS=re.search("\d+.\d+", line)
                    dS=dS.group()
                if not line:
                    break
            file1.close()
            
            newline=[x,omega,kappa,N,S,dN,dS]
            df.loc[len(df)] = newline
df.to_csv("/home/han/work/Metazoa_holocentrism/FAW_BAW/dnds/result/dnds.tsv", sep = "\t",index=False)
