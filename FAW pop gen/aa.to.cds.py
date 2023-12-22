#!/bin/python
import os
import pandas as pd
import sys, re
from os.path import exists

directory='/home/knam/work/Metazoa_holocentrism/FAW_BAW/fasta/cds'
mydict=dict()
ch=dict()
for filename in os.listdir(directory):
	if re.search(".fna",filename):
		file1=open(os.path.join(directory, filename), "r")
		print(os.path.join(directory, filename))
		count = 0
		l=0
		fasta=""
		title=""
		while True:
			count += 1
			line = file1.readline()
      #  print(line)
			if not line:
				break
			if re.search(">",line):		
				if fasta != "":
					mydict[title]=fasta
					ch[title]=chrom
				line=re.sub("^\s+|\s+$","", line)
				line=re.sub("\s+","\t",line)
				line1=re.split('\t+',line.rstrip('\t'))
				for x in range(len(line1)):
					if re.search("protein_id",line1[x]):
						title=re.search("\w+\d+.\d",line1[x])
						title=title.group()
				chrom=re.search("\w{2}\d+.\d",line1[0])
				chrom=chrom.group()
				fasta=""
			else :
				fasta=fasta+line
		file1.close()
		if fasta != "":
			mydict[title]=fasta
			ch[title]=chrom
orthologs='/home/knam/work/Metazoa_holocentrism/FAW_BAW/fasta/protein/OrthoFinder/Results_Apr28/Single_Copy_Orthologue_Sequences'
for filename in os.listdir(orthologs):
	if re.search(".fa",filename):
		file1=open(os.path.join(orthologs, filename), "r")
		print(os.path.join(orthologs, filename))
		count = 0
		l=0
		fasta=""
		title=""
		while True:
			count += 1
			line = file1.readline()
      #  print(line)
			if not line:
				break
			if re.search(">",line):
				title=re.search("\w+\d+.\d",line)
				title=title.group()
				line=re.sub(">","",line)
				if fasta=="":
					fasta=fasta+">exigua "+ch[title]+" "+line+mydict[title]
				else: 
					fasta=fasta+">frugi "+ch[title]+" "+line+mydict[title]
		file1.close()
		print(fasta)
		with open("/home/knam/work/Metazoa_holocentrism/FAW_BAW/fasta/orthologs/"+filename,"w")as tfile:
			tfile.write(''.join(fasta))
		tfile.close()

					
				
