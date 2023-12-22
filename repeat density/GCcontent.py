#!/bin/python

import sys, re
from pyfaidx import Fasta
import os
import fnmatch
import pandas as pd

directory='/home/knam/work/Metazoa_holocentrism/repeatmasker/postRMlib'
outputdir='/home/knam/work/Metazoa_holocentrism/repeatmasker/result'

df=pd.DataFrame(columns=["assembly","chromosome","start_position","GC","non_GC","X","total"])

for root, dirs, files in os.walk(directory):
  for filename in files:
    if fnmatch.fnmatch(filename, '*.masked'):
      file1=open(os.path.join(root, filename), "r")
      print(os.path.join(root, filename))

      window=100000
      chromo=[]
      i=0
      GC_count=0
      nonGC_count=0
      X_count=0
      GC=[]
      nonGC=[]
      X=[]
      startpoint = []
      total_count=[]
      species=[]
      nuc=1
      chrn=''
      startpoint.append(1)

      if re.search("GC\w_\d+.\d",filename):
        sp=re.search("GC\w_\d+.\d",filename)
        sp=sp.group()
      if re.search("chr\w+",filename):
        sp=re.search("chr\w+",filename)
        sp=sp.group()

      count = 0
      while True:
        count += 1
        line = file1.readline()
#        print(line)

        if not line:
          GC.append(GC_count)
          nonGC.append(nonGC_count)
          chromo.append(chrn)
          X.append(X_count)
          species.append(sp)
          for x in range (0,len(X)):
            total_count.append (X[x]+nonGC[x]+GC[x])
 
          newdf=pd.DataFrame({"assembly":species,"chromosome":chromo,"Startpoint":startpoint,"GCcount":GC,"non_GCcount":nonGC,"Xcount":X,"total":total_count})

          df=pd.concat([df,newdf])
          print (newdf)
          break
       
        line1=line.strip()
        i=i+len(line1)
        if re.search(">",line1):
          line1=line1.replace(":","")
 #         print(line)
          if chrn != '':
            if chrn != x:
              nuc=1 
              X.append(X_count)
              chromo.append(chrn)
              startpoint.append(nuc)
              species.append(sp)
              GC.append(GC_count)
              nonGC.append(nonGC_count)
          if re.search("chr\w*.\w*",line1):
            x=re.search("chr\w*.\w*",line1)
            x=x.group()
            chrn=x

          i=0
          X_count=0
          nonX_count=0
          GC_count=0
          nonGC_count=0

         # chrn=x
        else:
          if i<window:
            GC_count = GC_count + line1.count('G')+line1.count('g')+line1.count('C')+line1.count('c')
            nonGC_count=nonGC_count +(line1.count('A')+line1.count('a')+line1.count('T')+line1.count('t')+line1.count('N'))
            X_count=X_count+line1.count('X')
          else:
            GC_count = GC_count + line1.count('G')+line1.count('g')+line1.count('C')+line1.count('c')
            nonGC_count=nonGC_count +(line1.count('A')+line1.count('a')+line1.count('T')+line1.count('t')+line1.count('N'))
            X_count=X_count+line1.count('X')
            nuc=nuc+i
            startpoint.append(nuc)
            GC.append(GC_count)
            nonGC.append(nonGC_count)
            chromo.append(chrn)
            species.append(sp)
            X.append(X_count)
            GC_count=0
            nonGC_count=0
            X_count=0
            i=0

      file1.close()
df.to_csv(outputdir+'/GC_content.tsv',sep='\t')


