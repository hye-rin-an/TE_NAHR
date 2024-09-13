#!/bin/python

import os
import re

def filter_alignment(sequence):
    # Replace '!' with '-'
    sequence = sequence.replace("!", "-")
    # Make length  a multiple of 3
    sequence_len = len(sequence)
    sequence = sequence[:sequence_len - (sequence_len % 3)]
    return sequence


def fasta_to_phylip(fasta_file, phylip_file):
    # Read the FASTA file
    with open(fasta_file, "r") as ffasta, open(phylip_file, "w") as fphylip:
        sequences = ffasta.read().strip().split(">")
        
        # Initialize variables to store sequences
        danaus_sequence = ""
        vanessa_sequence = ""
        # Parse sequences
        for seq in sequences:
            lines = seq.split("\n")
            header = lines[0]
            sequence = "".join(lines[1:])
            
            # Assign sequence to corresponding variable based on header
            if header.startswith("danaus"):
                danaus_sequence = sequence
            elif header.startswith("vanessa"):
                vanessa_sequence = sequence
        danaus_sequence=danaus_sequence.replace(" ","")
        vanessa_sequence=vanessa_sequence.replace(" ","")
        danaus_sequence=filter_alignment(danaus_sequence)
        vanessa_sequence=filter_alignment(vanessa_sequence)
        print(len(danaus_sequence))
        print(len(vanessa_sequence))
        # Write PHYLIP format
        fphylip.write("2 {}\n".format(len(danaus_sequence)))
        fphylip.write("danaus    {}".format(danaus_sequence))
        fphylip.write("\nvanessa   {}".format(vanessa_sequence))
        
        print("PHYLIP file generated successfully.")


            
def main():
    orthologs_dir = '/scratch/hran/danaus/danaus_vanessa/result/orthologs_by_window/'
    for entry in os.listdir(orthologs_dir):
        if entry.endswith(".1.fa"):
            entry_path = os.path.join(orthologs_dir, entry)

            # Convert FASTA file to PHYLIP format
            phylip_file = os.path.join(orthologs_dir, f"{entry}.phylip")
            print(phylip_file)
            fasta_to_phylip(os.path.join(entry_path), phylip_file)

if __name__ == "__main__":
    main()

