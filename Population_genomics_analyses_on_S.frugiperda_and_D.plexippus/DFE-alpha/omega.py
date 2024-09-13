#!/bin/python

import os
import re
from decimal import *
# Define an empty list to store the data
data = []

#directory = '/scratch/hran/sfrugi/result/DFE-a/'
directory= '/scratch/hran/sfrugi/result/bts_DFE-a/'
# Iterate through files in the directory
for subdir, dirs, files in os.walk(directory):
    for filename in files:
        if re.search("est_alpha_omega.out", filename):
            print(os.path.join(subdir, filename))
            file_path = os.path.join(subdir, filename)
            x = re.search("Scaffold_\d+", subdir)
            x = x.group()

            # Initialize variables to store data
            alpha = None

            # Read file line by line
            with open(file_path, "r") as file1:
                for line in file1:
                    
                    if re.search("alpha [^\s]+",line):
                        alpha=re.search("alpha [^\s]+",line).group()
                        alpha=re.sub("alpha ", "", alpha)
                        omega=re.search("omega_A .+\.\d+",line)
                        if omega:
                           omega=omega.group()
                           omega=re.sub("omega_A ","",omega)
                        else: 
                           omega=0
                        print(omega)
                    if not line:
                        break
            data.append([x, alpha,omega])
output_file = "/scratch/hran/sfrugi/result/bts_DFE-a/alpha_omega.tsv"
with open(output_file, "w") as outfile:
    # Write header
    outfile.write("chromosome\talpha\tomega\n")
    # Write data
    for row in data:
        outfile.write("\t".join(str(item) for item in row) + "\n")

print("Data written to", output_file)
print(data)

			
