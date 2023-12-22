#!/bin/python
import os
import pandas as pd
import sys, re
from os.path import exists
from Bio import SeqIO
import io

sub=""
exigua=""
frugi=""
directory='/home/knam/work/Metazoa_holocentrism/FAW_BAW/fasta/orthologs/'
for subdir, dirs, files in os.walk(directory):
	for filename in files:
		if re.search(".filtered$",filename):
			file1=open(os.path.join(subdir, filename), "r")
			count = 0
			while True:
				count += 1
				line = file1.readline()
				if sub!= subdir:
					if sub!="":
						chrom=re.search("CM\d+.\d",sub)
						chrom=chrom.group()
						fasta=">exigua\n"+exigua+"\n"+">frugi\n"+frugi
						with open(directory+chrom+".fa","w")as tfile:
							tfile.write(''.join(fasta))
						tfile.close()
						exigua=""
						frugi=""
						print(subdir)
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
				sub=subdir
			file1.close()
chrom=re.search("CM\d+.\d",sub)
chrom=chrom.group()
fasta=">exigua\n"+exigua+"\n"+">frugi\n"+frugi
with open(directory+chrom+".fa","w")as tfile:
	tfile.write(''.join(fasta))
tfile.close()
			
