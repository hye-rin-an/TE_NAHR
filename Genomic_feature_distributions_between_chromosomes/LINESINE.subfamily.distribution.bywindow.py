#!/bin/python

import sys, re
from pyfaidx import Fasta
import os
import fnmatch
import pandas as pd

def AddValueToDict(k, d, v, i):
  if k in d:
    i = d[k]
  if   isinstance(i, set):
    i.add(v)
  elif isinstance(i, list):
    i.append(v)
  elif isinstance(i, str):
    i += str(v)
  elif isinstance(i, int):
    i += int(v)
  elif isinstance(i, float):
    i += float(v)
  d[k] = i
  return d

directory='/home/knam/work/Metazoa_holocentrism/repeatmasker/postRMlib'
outputdir='/home/knam/work/Metazoa_holocentrism/repeatmasker/result'

window=100000
df = pd.DataFrame(columns=["assembly","chromosome","LINE/SINE","family","frequence"])
chrsize=pd.DataFrame(columns=["chromosome","size"])
for root, dirs, files in os.walk(directory):
  for filename in files:
   # print(filename)
    if fnmatch.fnmatch(filename, '*.out'):
      if re.search("GCF_905147365.1",filename):
        assembly=re.search("GC\w_\d+.\d",filename)
        assembly=assembly.group()

        file1=open(os.path.join(root, filename), "r")
        print(os.path.join(root, filename))
        chrom=''
        count = 0
        LINE=dict()
        SINE=dict()
        fpos=0
        while True:
          count += 1
          line = file1.readline()
      #  print(line)

          if not line:
            break

          line=re.sub("^\s+|\s+$","", line)
          line=re.sub("\s+","\t",line)
          line1=re.split('\t+',line.rstrip('\t'))
#          print (line1)
          if line1[0].isnumeric():
            pos=int(int(line1[5])/window)
            if chrom != line1[4] :
              if chrom != '':
                for key in LINE:
                  length=len(LINE[key])
                  newline=[assembly,chrom,"LINE",key,length]
                  df.loc[len(df)] = newline
                  print(df)
                LINE=dict()
                for key in SINE:
                  length=len(SINE[key])
                  newline=[assembly,chrom,"SINE",key,length]
                  df.loc[len(df)] = newline
                  print(df)
                new=[chrom,fpos*window]
                chrsize.loc[len(chrsize)]=new
                SINE=dict()
                fpos=0
            if fpos!=pos:
              for key in LINE:
                length=len(LINE[key])
                newline=[assembly,chrom,"LINE",key,length]
                df.loc[len(df)] = newline
                print(df)
              LINE=dict()
              for key in SINE:
                length=len(SINE[key])
                newline=[assembly,chrom,"SINE",key,length]
                df.loc[len(df)] = newline
                print(df)
              SINE=dict()

            if re.search("LINE",line1[10]):
              LINE=AddValueToDict(line1[9],LINE,1,list())
            if re.search ("SINE",line1[10]):
              SINE=AddValueToDict(line1[9],SINE,1,list())

            chrom=line1[4]
            fpos=int(int(line1[5])/window)
        file1.close()
        for key in LINE:
          length=len(LINE[key])
          newline=[assembly,chrom,"LINE",key,length]
          df.loc[len(df)] = newline
          print(df)
        LINE=dict()
        for key in SINE:
          length=len(SINE[key])
          newline=[assembly,chrom,"SINE",key,length]
          df.loc[len(df)] = newline
          print(df)
        SINE=dict()
        new=[chrom,fpos*window]
        chrsize.loc[len(chrsize)]=new

final=df.merge(chrsize,on="chromosome")
print (final)
final.to_csv(outputdir+"/lepidoptera/"+assembly, sep = "\t")

