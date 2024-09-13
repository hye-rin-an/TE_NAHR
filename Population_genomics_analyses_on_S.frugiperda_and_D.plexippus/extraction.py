#!/bin/python
import os
import pandas as pd
import sys, re
from os.path import exists

directory='/home/knam/work/Metazoa_holocentrism/FAW_BAW/fasta/orthologs/'
out='/home/knam/work/Metazoa_holocentrism/FAW_BAW/result/'
script='python extract_4fold_degenerate_sites.py INPUT'

for filename in os.listdir(directory):
	if re.search("CM\d+.\d.fa.phylip$",filename):
		print(filename)
		command = script.replace('INPUT', directory+filename)
		os.system("bash -c '%s'" % command)	
