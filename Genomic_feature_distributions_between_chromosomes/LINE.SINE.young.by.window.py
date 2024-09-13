#!/bin/python

import sys, re
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

directory='/scratch/hran/lepidoptera/data/RMoutput'
outputdir='/scratch/hran/lepidoptera/result/'
window=100000
df = pd.DataFrame(columns=["species","chromosome","%div","type","frequence","window"])
for root, dirs, files in os.walk(directory):
  for filename in files:
   # print(filename)
    if fnmatch.fnmatch(filename, '*.out'):
      file1=open(os.path.join(root, filename), "r")
      print(os.path.join(root, filename))
      count=0
      chrom='' 
      LINE=dict()
      SINE=dict()
      fpos=0
      while True:
        count += 1
        line = file1.readline()
        
        if not line:
          break
        assembly=re.search("GC\w_\d+.\d|sfC",filename)
        assembly=assembly.group()
        line=re.sub("^\s+|\s+$","", line)
        line=re.sub("\s+","\t",line)
        line1=re.split('\t+',line.rstrip('\t'))
 
        if line1[0].isnumeric():
          pos=int(int(line1[5])/window)
          if chrom != line1[4]: 
            if chrom != '':
              for key in LINE:
                l=len(LINE[key])
                newline=[assembly,chrom,key/10,"LINE",l,fpos]               
                df.loc[len(df)] = newline
              print(df)
              LINE=dict()
              for key in SINE:
                s=len(SINE[key])
                newline=[assembly,chrom,key/10,"SINE",s,fpos]               
                df.loc[len(df)] = newline
              print (df)
              SINE=dict()
              fpos=0
          if fpos!=pos:
            for key in LINE:
              l=len(LINE[key])
              newline=[assembly,chrom,key/10,"LINE",l,fpos]               
              df.loc[len(df)] = newline
            print(df)
            LINE=dict()
            for key in SINE:
              s=len(SINE[key])
              newline=[assembly,chrom,key/10,"SINE",s,fpos]               
              df.loc[len(df)] = newline
            print (df)
            SINE=dict()

          if re.search("LINE",line):
            LINE=AddValueToDict(int(int(float(line1[1]))*10),LINE,1,list())
          if re.search("SINE",line):
            SINE=AddValueToDict(int(int(float(line1[1]))*10),SINE,1,list())
           

          chrom=line1[4]   
          fpos=int(int(line1[5])/window)      
      file1.close()
      for key in LINE:
        LINE[key]=list(set(LINE[key]))
        l=len(LINE[key])
        newline=[assembly,chrom,key/10,"LINE",l,fpos]
        print (newline)
        df.loc[len(df)] = newline
      print(df)
      for key in SINE:
        SINE[key]=list(set(SINE[key]))
        s=len(SINE[key])
        newline=[assembly,chrom,key/10,"SINE",s,fpos]
        df.loc[len(df)] = newline
      print (df)

df.to_csv(outputdir+"/LINESINE%div.bywindow.tsv", sep = "\t")
