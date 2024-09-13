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

directory='/home/knam/work/Metazoa_holocentrism/genomes/ncbi-genomes-2023-01-17'
outputdir='/home/knam/work/Metazoa_holocentrism/repeatmasker/result'

window=100000
df = pd.DataFrame(columns=["assembly","chromosome","CDSdensity"])

for root, dirs, files in os.walk(directory):
  for filename in files:
   # print(filename)
    if fnmatch.fnmatch(filename, '*.gtf'):
      file1=open(os.path.join(root, filename), "r")
      print(os.path.join(root, filename))
      chrom=''
      count = 0      
      start=dict()
      end=dict()
      CDS=dict()
      codingnt=dict()
      while True:
        count += 1
        line = file1.readline()
      #  print(line)

        if not line:
          break

        line=re.sub("^\s+|\s+$","", line)
        if re.search("GC\w_\d+.\d",line):
          assembly=re.search("GC\w_\d+.\d",line)
          assembly=assembly.group()

        if re.search("^[^#]",line):
          line=re.sub("\s{2,}","\t",line)
      
          line1=re.split('\t+',line.rstrip('\t'))
 #         print(line1)
          pos=int(int(line1[3])/window)
          if chrom != line1[0] :
            if chrom != '':
              for key in CDS:
                CDS[key]=list(set(CDS[key]))
                length=len(CDS[key])
                density=length/window
                newline=[assembly,chrom,density]
                df.loc[len(df)] = newline
                print(df)
              start=dict()
              end=dict()
              CDS=dict()
          if re.search("CDS",line1[2]):
            start[pos]=int(line1[3])
            end[pos]=int(line1[4])
            for i in range(start[pos],end[pos]):
              CDS=AddValueToDict(pos,CDS,i,list())
            start=dict()
            end=dict() 
          chrom=line1[0]
      file1.close()

      for key in CDS:
        CDS[key]=list(set(CDS[key]))
        length=len(CDS[key])
        density=length/window
        newline=[assembly,chrom,density]
        print(df)
      print (df)
df.to_csv(outputdir+"/CDSdensity.tsv", sep = "\t")

