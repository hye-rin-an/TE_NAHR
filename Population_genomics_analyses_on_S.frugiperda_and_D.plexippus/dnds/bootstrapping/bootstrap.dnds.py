#!/bin/python
import os
import pandas as pd
import sys, re
from os.path import exists
import io
from decimal import *
pnps = pd.read_csv("/home/han/work/Metazoa_holocentrism/FAW_pnps/result/bts.PNPS.tsv",sep="\t", header=0)
p = dict(zip(pnps["size"], pnps["PNPS"]))
chrsize=pd.read_csv("/home/han/work/Metazoa_holocentrism/FAW_BAW/v6_chrsize.txt",sep="\t", header=0)
size=dict(zip(chrsize["chromosome"], chrsize["size"]))
print(chrsize)
print(size)

#size=dict()
#trans=pd.merge(pnps, chrsize,on="size")

#chrsize=open("/home/han/work/Metazoa_holocentrism/FAW_BAW/v6_chrsize.txt","r")
#count=0
#while True:
 #   count += 1
  #  line = chrsize.readline()
   # if re.search("CM\d+.\d",line):
    #    ch=re.search("CM\d+.\d",line)
     #   ch=ch.group()
      #  x=re.search("\t\d+",line)
       # x=x.group()
        #x=x.replace("\t","")
         #size[ch]=x
#    if not line:
 #       break

df = pd.DataFrame(columns=["chromosome","w_inf","w_sup","k_inf","k_sup","N_inf","S_sup","S_inf","S_sup","dN_inf","dN_sup","dS_inf","dS_sup","a_inf","a_sup","size"])

directory='/home/han/work/Metazoa_holocentrism/FAW_BAW/dnds/bts_resampling/'
for subdir, dirs, files in os.walk(directory):
    for filename in files:
        if re.search("CM",filename):
            print(os.path.join(subdir, filename))
            file1=open(os.path.join(subdir, filename), "r")
            x=re.search("CM\d+.\d",filename)
            x=x.group()
            kappa=[]
            omega=[]
            N=[]
            S=[]
            dN=[]
            dS=[]
            A=[]
            count = 0
            while True:
                count += 1
                line = file1.readline()
                if re.search("kappa",line):
                    k=re.search("\d+.\d+", line)
                    k=k.group()
                    kappa.append(k)
                if re.search("omega",line):
                    w=re.search("\d+.\d+", line)
                    w=w.group()
                    omega.append(w)
                if re.search("3\.\.1",line):
                    if re.search("\d+\.\d+",line):
                        line=line.replace("\s+","\s")
                        y=line.split()
                        n=y[2]
                        N.append(n)
                        s=y[3]
                        S.append(s)
                if re.search("tree length for dN",line):
                    dn=re.search("\d+.\d+", line)
                    dn=dn.group()
                    print(dn)
                    dN.append(dn)
                if re.search("tree length for dS",line):
                    ds=re.search("\d+.\d+", line)
                    ds=ds.group()
                    dS.append(ds)
                if re.search("Time used", line):
                    print(Decimal(n))
                    print(Decimal(dn))
                    a=1-(Decimal(p[size[x]])*((Decimal(s)*Decimal(ds))/(Decimal(n)*Decimal(dn))))
                    A.append(a)
                if not line:
                    break
            file1.close()
            kappa = sorted(kappa, reverse=True)
            omega = sorted(omega, reverse=True)
            N = sorted(N, reverse=True)
            S = sorted(S, reverse=True)
            dS = sorted(dS, reverse=True)
            dN = sorted(dN, reverse=True)
            A = sorted(A,reverse=True)
            newline=[x,omega[974],omega[24],kappa[974],kappa[24],N[974],N[24],S[974],S[24],dN[974],dN[24],dS[974],dS[24],A[974],A[24],size[x]]
            df.loc[len(df)] = newline

mean = pd.read_csv("/home/han/work/Metazoa_holocentrism/FAW_BAW/dnds/result/dnds.tsv",sep="\t", header=0)
final=pd.merge(mean, df, on='chromosome')

final.to_csv("/home/han/work/Metazoa_holocentrism/FAW_BAW/dnds/result/test.bts.dnds.tsv", sep = "\t",index=False)
