#!/bin/python
import os
import pandas as pd
import sys, re
from os.path import exists
from pathlib import Path

directory='/home/knam/work/Metazoa_holocentrism/FAW_BAW/fasta/orthologs/'

for filename in os.listdir(directory):
	if re.search("\d+.fa",filename):
		file1=open(os.path.join(directory, filename), "r")
		print(os.path.join(directory, filename))
		count = 0
		while True:
			count += 1
			line = file1.readline()
			if re.search(">frugi",line):
				if re.search("CM\d+.\d",line):
					ch=re.search("CM\d+.\d",line)
					ch=ch.group()
					isExist = os.path.exists(directory+ch)
					if isExist==False:
						os.mkdir(directory+ch)
					Path(directory+filename).rename(directory+ch+"/"+filename)
				break
		file1.close()
					

