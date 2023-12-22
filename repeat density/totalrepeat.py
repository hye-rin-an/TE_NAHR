#!/bin/python
import pandas as pd
import sys, re
from pyfaidx import Fasta
import os
import fnmatch

directory='/home/knam/work/Metazoa_holocentrism/repeatmasker/postRMlib'
outputdir='/home/knam/work/Metazoa_holocentrism/repeatmasker/result'

df = pd.DataFrame(columns=["assembly","chromosome","startpoint","X","nonX","total"])
for root, dirs, files in os.walk(directory):
  for filename in files:
   # print(filename) 
    if fnmatch.fnmatch(filename, '*.masked'):
      with open(os.path.join(root, filename), "rt") as file1:
        count=0
        i=0
        window=100000
        X_count=0
        nonX_count=0
        nuc=1
        chrn=''

        while True:
          count += 1
          line = file1.readline()
          if not line:
            break

          if re.search("GC\w_\d+.\d",filename): 
            sp=re.search("GC\w_\d+.\d",filename)
            sp=sp.group()
          if re.search("sfC",filename):
            sp='GCA_019297735.1'
          if re.search("chr",filename):
            sp="GCF_021461395.2"
          line=line.strip()
          i=i+len(line)
          if re.search(">",line):
            line=line.replace(":","") 
            print(line)
            x=re.search("chr\w*.\w*|Scaffold_\d+",line)
            if (x is None):
              x='0'
            else:
              x=x.group()
            print(x)
            if chrn != '0':
              if chrn != x:
                if chrn != '': 
                  tot=X_count+nonX_count 
                  new=[sp,chrn,nuc,X_count,nonX_count,tot]
                  df.loc[len(df)]=new
                 # print(df)
              chrn=x
            nuc=1
            i=0
            X_count=0
            nonX_count=0
          else:
            if chrn != '0':
              if i<window:
                X_count = X_count + line.count('X') 
                nonX_count=nonX_count +(line.count('A')+line.count('a')+line.count('G')+line.count('g')+line.count('T')+line.count('t')+line.count('C')+line.count('c')+line.count('N'))
              else:     
                X_count = X_count + line.count('X')
                nonX_count=nonX_count +(line.count('A')+line.count('a')+line.count('G')+line.count('g')+line.count('T')+line.count('t')+line.count('C')+line.count('c')+line.count('N'))
                tot=X_count+nonX_count
                new=[sp,chrn,nuc,X_count,nonX_count,tot]
                nuc=nuc+i
                df.loc[len(df)]=new
               # print(df)
                X_count=0
                nonX_count=0
                i=0
        print(df)
      file1.close()
      if chrn != '0':
        tot=X_count+nonX_count
        new=[sp,chrn,nuc,X_count,nonX_count,tot]
        df.loc[len(df)]=new

df.to_csv(outputdir+"/totalrepeat.tsv", sep = "\t",index=False)

