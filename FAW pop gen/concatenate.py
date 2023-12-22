#!/bin/python
import os
import pandas as pd
import sys, re
from os.path import exists
import io

seqexigua=""
seqfrugi=""
ch=""
directory='/home/han/work/Metazoa_holocentrism/FAW_BAW/fasta/orthologs/'
for subdir, dirs, files in os.walk(directory):
    for filename in files:
        if re.search(".filtered.phylip$",filename):
            print(os.path.join(subdir, filename))
            file1=open(os.path.join(subdir, filename), "r")
            x=re.search("CM\d+.\d",subdir)
            x=x.group()
            if ch  != "":
                if x != ch:
                    fasta="      2   "+str(len(seqfrugi))+"\n\n"+"exigua    "+seqexigua+"\n"+"sfrugi     "+seqfrugi
                    with open(directory+ch+".phylip2","w")as tfile:
                        tfile.write(''.join(fasta))
                    tfile.close()

                    seqexigua=""
                    seqfrugi=""

            count = 0
            frugi=""
            exigua=""
            while True:
                count += 1
                line = file1.readline()
                print(line)
                if re.search("sfrugi",line):
                    line=re.sub("\s+","", line)
                    frugi=line.replace("sfrugi","")
                    print(frugi)
                if re.search("exigua",line):
                    line=re.sub("\s+","", line)
                    exigua=line.replace("exigua","")
                if not line:
                    break
            file1.close()
            seqfrugi = seqfrugi+frugi
            seqexigua = seqexigua+exigua
            ch=x
            fasta="      2   "+str(len(seqfrugi))+"\n\n"+"exigua    "+seqexigua+"\n"+"sfrugi     "+seqfrugi
            with open(directory+ch+".phylip2","w")as tfile:
                tfile.write(''.join(fasta))
            tfile.close()

            print (len(seqfrugi))
            print(len(seqexigua))
