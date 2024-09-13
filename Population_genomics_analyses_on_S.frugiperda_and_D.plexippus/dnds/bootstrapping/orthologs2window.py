#!/bin/python

import re
import os
import shutil

def parse_protein_data(file_path):
    protein_dict = {}

    with open(file_path, 'r') as file:
        for line in file:
            # Use regex to extract the protein_id and location fields
            protein_id_match = re.search(r'protein_id=([\w.]+)', line)
            location_match = re.search(r'location=[a-zA-Z(]*[^\d]*([\d]+)', line)

            if protein_id_match and location_match:
                protein_id = protein_id_match.group(1)
                start_position = int(location_match.group(1))

                # Calculate the window
                window = start_position // 100000

                # Store the protein_id and window in the dictionary
                protein_dict[protein_id] = window

    return protein_dict

def move_alignment_files(protein_dict, input_folder):
    for root, dirs, files in os.walk(input_folder):
        for file in files:
            if file.endswith("NT.fa"):  # Adjust the extension as needed
                file_path = os.path.join(root, file)

                with open(file_path, 'r') as f:
                    content = f.read()
                    match = re.search(r'>frugi\s+(CM[\w.]+)\s+([\w.]+)', content)

                    if match:
                        protein_id = match.group(2)
                        chromosome=match.group(1)
                        if protein_id in protein_dict:
                            window = protein_dict[protein_id]
                            output_folder = os.path.join(root,chromosome,str(window))
                            os.makedirs(output_folder, exist_ok=True)
                            shutil.move(file_path, os.path.join(output_folder, file))
                            print(f"Moved {file} to {output_folder}")
                        else:
                            print(file)
input_folder = '/home/han/work/Metazoa_holocentrism/FAW_BAW/result/orthologs_by_window/'
protein_data_file = '/home/han/work/Metazoa_holocentrism/FAW_BAW/fasta/cds/frugi.cds_from_genomic.fna'
protein_data = parse_protein_data(protein_data_file)
move_alignment_files(protein_data, input_folder)

