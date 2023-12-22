#!/bin/python

import sys, re
import os
import fnmatch
import pandas as pd
import gzip

window=100000
df = pd.DataFrame(columns=["chromosome","singleton","total_SNP"])
chrsize=pd.DataFrame(columns=["chromosome","size"])
with gzip.open('/home/knam/work/Metazoa_holocentrism/FAW_pnps/vcf/SNP.annotated.filtered.vcf.gz', "rt") as file1:
	chrom=''
	count = 0
	fpos=0
	single=0
	SNP=0
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
			if chrom!=line1[0]:
				if chrom!="":
					newline=[chrom,single,SNP]
					df.loc[len(df)] = newline
					single=0
					SNP=0
					new=[chrom,fpos*window]
					chrsize.loc[len(chrsize)]=new
					fpos=0
					print (df)
			if fpos!=pos:
				newline=[chrom,single,SNP]
				df.loc[len(df)] = newline
				single=0	
				SNP=0
				print(df)
			if re.search("synonymous",line):
				if not re.search ("missense",line): 
					SNP=SNP+1
					if re.search("^\w{1}$",line1[4]):	
						if len([*re.finditer("0/1", line)])==1 or len([*re.finditer("1/0", line)])==1 :
							single=single+1	
			chrom=line1[0]
			fpos=int(int(line1[1])/window)
file1.close()
newline=[chrom,single,SNP]
df.loc[len(df)] = newline
new=[chrom,fpos*window]
chrsize.loc[len(chrsize)]=new

final=df.merge(chrsize,on="chromosome")

final.to_csv("/home/knam/work/Metazoa_holocentrism/FAW_pnps/result/syn.singleton.tsv", sep = "\t")





