#!/bin/python
import os
import pandas as pd
import sys, re
from os.path import exists
import io
import shutil
import subprocess


# Function to run Gblocks on a given file
def run_gblocks(file):
    script="cd " + out+ "  &&  module load bioinfo/Gblocks/0.91b && for file in "+ file +"; do Gblocks $file -t=c -a=y; done"
    print(script)
    os.system(script)
    print(f"Gblocks ran successfully on {file}")

directory='/home/han/work/Metazoa_holocentrism/FAW_BAW/result/orthologs_by_window/'
ch=""
for subdir, dirs, files in os.walk(directory):
    for filename in files:
        if re.search("bootstrap_window.txt",filename):
            x=re.search("CM\d+.\d",filename).group()
            i=0
            with open(os.path.join(directory,filename),"r") as f:
                for line in f:
                # Extract the numbers from the line and strip any surrounding whitespace
                    cleaned_line = line.strip().strip('[]')
                    numbers = [num.strip() for num in cleaned_line.split(',')]
                
        # Create a list of file paths based on the numbers
                    files = []
                    for number in numbers:
                        file_path = directory+x+"/"+number+"/"+number+".paths.txt"
                        if os.path.isfile(file_path):
                            files.append(file_path)
                        else:
                            print(f"File not found: {file_path}")
                    out="/home/han/work/Metazoa_holocentrism/FAW_BAW/dnds/bts_resampling/pathfiles/"+x
                    if not os.path.exists(out):
                        os.makedirs(out)
                    output=out+"/"+str(i)+".paths.txt"
                    with open(output, 'w') as outfile:
                        for fname in files:
                            with open(fname) as infile:
                                outfile.write(infile.read())
        # Run the Gblocks command for each file
                    run_gblocks(output)
                    i=i+1
                    print("mv " + directory+ x+"/*/*.paths.txt-gb.seq " + out)
                    script="mv " + directory+ x+"/*/*.paths.txt-gb.seq " + out
                    os.system(script)
