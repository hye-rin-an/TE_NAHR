#!/bin/python
import os
import pandas as pd
import sys, re
from os.path import exists
from Bio import SeqIO
import io
from difflib import SequenceMatcher
import math

size=dict()
chrsize=open("/home/knam/work/Metazoa_holocentrism/FAW_BAW/v6_chrsize.txt","r")
count=0
while True:
	count += 1
	line = chrsize.readline()
	if re.search("CM\d+.\d",line):
		ch=re.search("CM\d+.\d",line)
		ch=ch.group()
		x=re.search("\t\d+",line)
		x=x.group()
		x=x.replace("\t","")
		size[ch]=x
	if not line:
		break

directory='/home/knam/work/Metazoa_holocentrism/FAW_BAW/fasta/orthologs/'
df=pd.DataFrame(columns = ["chromosome", "p-distance","l.ci_pd","u.ci_pd","jukes-cantor","l.ci_jukes","u.ci_jukes","mean_Ts","mean_Tv","size"])

for filename in os.listdir(directory):
	if re.search("seqboot",filename):
		file1=open(os.path.join(directory, filename), "r")
		count = 0
		j=0
		rate=list()
		TV=list()
		TS=list()
		baw=""
		faw=""		
		while True:
			count += 1
			line = file1.readline()
			#line=re.sub("\n\n", "",line)
			if re.search("2",line):
				if faw !="":
					difference=0
					tv=0
					ts=0
					same=0
					for i in range(len(faw)): 
						if faw[i]!=baw[i]:
							difference+=1
							#print(faw[i])
							#print(baw[i])
							if (faw[i] in ["A","G"] or baw[i] in ["A","G"]) and (baw[i] in ["T","C"] or faw[i] in ["T","C"]):
								tv+=1
							if ((faw[i]=="C" or baw[i] =="C" ) and (faw[i]=="T" or baw[i] =="T" )) or ((faw[i]=="A" or baw[i] =="A" ) and (faw[i]=="G" or baw[i] =="G" )): 		
								ts+=1
						else:
							same+=1
					r=difference/len(faw)
					TV.append(tv)
					TS.append(ts)
					rate.append(r)
					print(len(faw))
					print(same)
					print(difference)	
					faw=""
					baw=""

			else: 
				if line !='\n':
					line=re.sub("\s+","", line)
					if re.search("exigua",line):
						line=line.replace("exigua","")
						baw=baw+line
						
					if re.search("sfrugi",line):
						line=line.replace("sfrugi","")
						faw=faw+line
						
					if not (re.search("exigua",line) or re.search("sfrugi",line)):
						if j==0:
							faw=faw+line
							j=1
						else:
							baw=baw+line
							j=0

			if not line:
				break
		file1.close()
		ch=re.search("CM\d+.\d",filename)
		ch=ch.group()
		mean=sum(rate)/1000
		lci= sorted(rate)[49]
		uci= sorted(rate)[949]
		J=list()
		for value in rate:
			jukes=float(value)
			jukes=(-3/4)*math.log(1-(4/3)*jukes)
			J.append(jukes)
		m_jukes=sum(J)/1000
		lci_jukes= sorted(J)[49]
		uci_jukes= sorted(J)[949]

		m_tv=sum(TV)/1000
		m_ts=sum(TS)/1000	

		new=[ch,mean,lci,uci,m_jukes,lci_jukes,uci_jukes,m_ts,m_tv,size[ch]]
		df.loc[len(df)] = new
		print(df)

df.to_csv("~/work/Metazoa_holocentrism/FAW_BAW/result/bilan.sub.rate.txt",sep='\t')
	
