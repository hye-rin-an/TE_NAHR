#!/bin/python

import sys, re
from pyfaidx import Fasta
import os
import fnmatch
import pandas as pd

directory='/home/knam/work/Metazoa_holocentrism/repeatmasker/postRMlib'
outputdir='/home/knam/work/Metazoa_holocentrism/repeatmasker/result'

window=100000
LINE=dict()
l=0
SINE=dict()
s=0
simple_repeat=dict()
sr=0
low_complex=dict()
lc=0
LTR=dict()
ltr=0
DNAtrans=dict()
dt=0
rollingcircle=dict()
rc=0
satellites=dict()
stl=0
all_df = pd.DataFrame(columns=["assembly","chromosome","simple_repeat","low_complex","LINE","SINE","LTR","DNAtrans","rollingcircle","satellites"])
fpos=0

for root, dirs, files in os.walk(directory):
  for filename in files:
   # print(filename)
    if fnmatch.fnmatch(filename, '*.out'):
      file1=open(os.path.join(root, filename), "r")
      print(os.path.join(root, filename))
      chrom=''
      count = 0
      df=pd.DataFrame(columns=["assembly","chromosome","simple_repeat","low_complex","LINE","SINE","LTR","DNAtrans","rollingcircle","satellites"])
      while True:
        count += 1
        line = file1.readline()
      #  print(line)

        if not line:
          break

        line=re.sub("^\s+|\s+$","", line)

        if re.search("^\d+",line):
          line=re.sub("\s+","\t",line)
         # print(line)
          line1=re.split('\t+',line.rstrip('\t'))
         # print(line1)
          pos=int(int(line1[5])/window)

          if chrom != line1[4] :
            if chrom != '':
              w=list(range(0,fpos))
           # print(fpos)
              for i in w:
                if not i in simple_repeat.keys():
                  simple_repeat[i]=0
                if not i in LINE.keys():
                  LINE[i]=0
                if not i in SINE.keys():
                  SINE[i]=0
                if not i in low_complex.keys():
                  low_complex[i]=0
                if not i in LTR.keys():
                  LTR[i]=0
                if not i in DNAtrans.keys():
                  DNAtrans[i]=0
                if not i in rollingcircle.keys():
                  rollingcircle[i]=0
                if not i in satellites.keys():
                  satellites[i]=0
                newline={"assembly":filename,"chromosome":chrom,"simple_repeat":simple_repeat[i],"low_complex":low_complex[i],"LINE":LINE[i],"SINE":SINE[i],"LTR":LTR[i],"DNAtrans":DNAtrans[i],"rollingcircle":rollingcircle[i],"satellites":satellites[i]}

                df = df.append(newline, ignore_index=True)
              
            fpos=0
            LINE=dict()
            l=0
            SINE=dict()
            s=0
            simple_repeat=dict()
            sr=0
            low_complex=dict()
            lc=0
            LTR=dict()
            ltr=0
            DNAtrans=dict()
            dt=0
            rollingcircle=dict()
            rc=0
            satellites=dict()
            stl=0

          if pos != fpos:
              
            l=0
            s=0
            sr=0
            lc=0
            ltr=0
            dt=0
            rc=0
            stl=0

          if re.search("Simple",line):
            sr=sr + int(line1[6])-int(line1[5])+1
            simple_repeat[pos]=sr
            #print(pos)
          if re.search("Low",line):
            lc=lc+int(line1[6])-int(line1[5])+1
            low_complex[pos]=lc

          if  re.search("LINE",line):
            l=l+int(line1[6])-int(line1[5])+1
            LINE[pos]=l

          if  re.search("SINE",line):
            s=s+int(line1[6])-int(line1[5])+1
            SINE[pos]=s

          if  re.search("LTR",line):
            ltr=ltr+int(line1[6])-int(line1[5])+1
            LTR[pos]=ltr

          if  re.search("DNA",line):
            dt=dt+int(line1[6])-int(line1[5])+1
            DNAtrans[pos]=dt

          if  re.search("Satellite",line):
            stl=stl+int(line1[6])-int(line1[5])+1
            satellites[pos]=stl

          if  re.search("RC/",line):
            rc=rc+int(line1[6])-int(line1[5])+1
            rollingcircle[pos]=rc

          chrom=line1[4]
          fpos=int(int(line1[5])/window)
      file1.close()

      w=list(range(0,fpos))
           # print(fpos)
      for i in w:
        if not i in simple_repeat.keys():
          simple_repeat[i]=0 
        if not i in LINE.keys():
          LINE[i]=0
        if not i in SINE.keys():
          SINE[i]=0
        if not i in low_complex.keys():
          low_complex[i]=0
        if not i in LTR.keys():
          LTR[i]=0
        if not i in DNAtrans.keys():
          DNAtrans[i]=0
        if not i in rollingcircle.keys():
          rollingcircle[i]=0
        if not i in satellites.keys():
          satellites[i]=0
        newline={"assembly":filename,"chromosome":chrom,"simple_repeat":simple_repeat[i],"low_complex":low_complex[i],"LINE":LINE[i],"SINE":SINE[i],"LTR":LTR[i],"DNAtrans":DNAtrans[i],"rollingcircle":rollingcircle[i],"satellites":satellites[i]}

        df = df.append(newline, ignore_index=True)


      all_df=pd.concat([all_df,df])
print (all_df)
all_df.to_csv(outputdir+"/repeat_byclass.wlib.tsv", sep = "\t")

