#!/bin/python3

import os
import random

# Define the window size
WINDOW_SIZE = 100000

# Input TSV file
TSV_FILE = "/home/han/work/Metazoa_holocentrism/FAW_BAW/v6_chrsize.txt"

# Output directory
OUTPUT_DIR = "/home/han/work/Metazoa_holocentrism/FAW_BAW/result/orthologs_by_window"

# Read the TSV file
with open(TSV_FILE, 'r') as file:
    # Skip the header
    next(file)
    for line in file:
        # Parse chromosome and size
        chromosome, size = line.strip().split('\t')
        size = int(size)

        # Calculate the number of windows
        num_windows = size // WINDOW_SIZE

        # Generate and save 1000 random samples with replacement
        output_file = os.path.join(OUTPUT_DIR, f"{chromosome}_bootstrap_window.txt")
        with open(output_file, 'w') as outfile:
            for i in range(1000):
            # Choose random numbers corresponding to window indices
                random_numbers = [random.randint(0, num_windows) for _ in range(num_windows)]

                outfile.write("".join(str(random_numbers))+"\n")
