#!/bin/python

import sys, re
import os
import fnmatch
import pandas as pd
import gzip

df = pd.DataFrame(columns=["chromosome","type","group","frequency","count","window"])
with open('/home/knam/work/Metazoa_holocentrism/FAW_pnps/result/AFS.tsv', "rt") as file1:
	count=0
	while True:          
		count += 1
		line = file1.readline()
		if not line:
			break

		if re.search("Scaffold_\d+",line):
			line=re.sub("^\s+|\s+$","", line)
			line=re.sub("\s+","\t",line)
			line1=re.split('\t+',line.rstrip('\t'))
			#print(line1)
			x=range(0,33)
			y=range(33,65)
			if int(line1[4]) in x:
				df.loc[len(df)]=[line1[1],line1[2],line1[3],line1[4],line1[5],line1[6]]
				print(df)
			if int(line1[4]) in y:
				newline=[line1[1],line1[2],line1[3],int(line1[4])-(int(line1[4])-32)*2,line1[5],line1[6]]
				df.loc[len(df)]=newline
				print(df)
file1.close()

df.to_csv("/home/knam/work/Metazoa_holocentrism/FAW_pnps/result/foldedAFS.tsv", sep = "\t")





