#!/bin/bash

# Define the directory containing ortholog alignment files
directory="/scratch/hran/danaus/danaus_vanessa/result/orthologs/"

# Loop through each directory
for dir in "$directory"/*/; do
    # Extract directory name
    dir_name=$(basename "$dir")
    
    # Define output file
    output_file="$directory${dir_name}_paths.txt"
    
    # Write full paths of alignment files to the output file
    find "$dir" -type f -name "*NT.fa" > "$output_file"
    
    echo "File paths written to $output_file"
done

