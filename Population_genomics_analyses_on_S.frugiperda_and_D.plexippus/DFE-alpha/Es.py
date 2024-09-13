
#!/bin/python

import os
import re
from decimal import *
# Define an empty list to store the data
data = []

directory = '/scratch/hran/danaus/danaus_vanessa/result/DFE-a/'

# Iterate through files in the directory
for subdir, dirs, files in os.walk(directory):
    for filename in files:
        if re.search("est_dfe.out", filename):
            print(os.path.join(subdir, filename))
            file_path = os.path.join(subdir, filename)
            x = re.search("NC_\d+.\d", subdir)
            x = x.group()

            # Initialize variables to store data
            alpha = None

            # Read file line by line
            with open(file_path, "r") as file1:
                for line in file1:
                    
                    if re.search("Es [^\s]+",line):
                        es=re.search("Es [^\s]+",line).group()
                        es=re.sub("Es ", "", es)
                    if not line:
                        break
            data.append([x, es])
output_file = "/scratch/hran/danaus/danaus_vanessa/result/DFE-a/Es.tsv"
with open(output_file, "w") as outfile:
    # Write header
    outfile.write("chromosome\tEs\n")
    # Write data
    for row in data:
        outfile.write("\t".join(str(item) for item in row) + "\n")

print("Data written to", output_file)
print(data)
