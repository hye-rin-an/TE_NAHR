#!/bin/python
import os
import pandas as pd
import sys, re
from os.path import exists
from Bio import SeqIO
import io


orthologs=[]
directory='/home/knam/work/Metazoa_holocentrism/FAW_BAW/fasta/orthologs/'
for subdir, dirs, files in os.walk(directory):
	for filename in files:
		if re.search(".fa-gb$",filename):
			orthologs.append(filename)
			print(os.path.join(subdir, filename))
			file1=open(os.path.join(subdir, filename), "r")
			frugi=""
			exigua=""
			lines = file1.readlines()
			for line in lines:
				if re.search("exigua",line):
					x="exigua"
				if re.search("frugi",line):
					x="frugi"
				if not re.search(">",line):
					if x=="exigua":
						line=re.sub("\s+|\n","",line)
						exigua=exigua+line
						
					if x=="frugi":
						line=re.sub("\s","",line)
						frugi=frugi+line
							
			file1.close()
			if len(exigua)%3!=0:
				x=len(exigua)%3
				exigua=exigua[0:len(exigua)-x]
			if len(frugi)%3!=0:
				x=len(frugi)%3
				frugi=frugi[0:len(frugi)-x]			
			
			baw=[exigua[i:i+3] for i in range(0, len(exigua), 3)]
			faw=[frugi[i:i+3] for i in range(0, len(frugi), 3)]


			if len(frugi)<len(exigua):
				exigua=exigua[0:len(frugi)-1]
			if len(exigua)<len(frugi):
				frugi=frugi[0:len(exigua)-1]	
	
			fasta=">exigua\n"+exigua+"\n"+">frugi\n"+frugi
			with open(os.path.join(subdir, filename)+".filtered","w")as tfile:
				tfile.write(''.join(fasta))
			tfile.close()
			



