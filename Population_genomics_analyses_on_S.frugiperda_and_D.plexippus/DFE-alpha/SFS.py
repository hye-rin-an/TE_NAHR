#!/bin/python

import sys, re
import os
import fnmatch
import gzip
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

df = pd.DataFrame(columns=["chromosome","type","allele_frequency","count","fpos"])
NS=dict()
S=dict()
window=100000
with gzip.open('/scratch/hran/sfrugi/data/SNP.annotated.filtered.vcf.gz', "rt") as file1:
	chrom=''
	count = 0
	fpos=0
	while True:          
		count += 1
		line = file1.readline()
		if not line:
			break

		if re.search("^Scaffold_\d+",line):
			line=re.sub("^\s+|\s+$","", line)
			line=re.sub("\s+","\t",line)
			line1=re.split('\t+',line.rstrip('\t'))
			#print(line1)
			pos=int(int(line1[1])/window)
			print(pos)
			print(fpos)
			print("\n")
			if chrom!=line1[0]:
				if chrom!="":
					for key in NS:
						newline=[chrom,"NonSyn",key,len(NS[key]),fpos]
						df.loc[len(df)] = newline
					for key in S:
						newline=[chrom,"Syn",key,len(S[key]),fpos]
						df.loc[len(df)] = newline
					NS=dict()
					S=dict()
					fpos=0
					print (df)
			if fpos!=pos:
				for key in NS:
					newline=[chrom,"NonSyn",key,len(NS[key]),fpos]
					df.loc[len(df)] = newline
				for key in S:
					newline=[chrom,"Syn",key,len(S[key]),fpos]
					df.loc[len(df)] = newline
				print(df)
				NS=dict()
				S=dict()
			if re.search("missense",line):
				if re.search("^\w{1}$",line1[4]):	
					n=len([*re.finditer("\t0\/1", line)]) + len([*re.finditer("\t1\/0", line)]) +  len([*re.finditer("\t1\/1", line)])*2
					print(n)
					NS=AddValueToDict(n,NS,1,list())

			if re.search("synonymous",line):
				if not re.search ("missense",line):
					n=len([*re.finditer("\t0\/1", line)]) + len([*re.finditer("\t1\/0", line)]) +  len([*re.finditer("\t1\/1", line)])*2
					print(n)
					S=AddValueToDict(n,S,1,list())

			chrom=line1[0]
			fpos=int(int(line1[1])/window)
file1.close()
for key in NS:
	newline=[chrom,"NonSyn",key,len(NS[key]),fpos]
	df.loc[len(df)] = newline
for key in S:
	newline=[chrom,"Syn",key,len(S[key]),fpos]
	df.loc[len(df)] = newline
df.to_csv("/scratch/hran/sfrugi/result/SFS.tsv", sep = "\t",index=False)

