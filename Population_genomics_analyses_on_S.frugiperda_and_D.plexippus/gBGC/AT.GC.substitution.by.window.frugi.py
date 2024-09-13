#!/bin/python

import gzip
import re

file1 = gzip.open("/home/han/work/Metazoa_holocentrism/gene_conversion/data/vcf/allfrugi.SNP.vcf.gz", "rt")

current_scaffold = None
datgc = 0
dgcat = 0
datat=0
dgcgc=0
dtotal = 0
patgc=0
pgcat=0
patat=0
pgcgc=0
ptotal=0
fpos=0
window=100000
# Open the output file to write the results
with open("/home/han/work/Metazoa_holocentrism/gene_conversion/gbgc.by.window.frugi.txt", "w") as result_file:
    result_file.write("chromosome\tdatgc\tdgcat\tdatat\tdgcgc\tdtotal\tdgc/at\tpatgc\tpgcat\tpatat\tpgcgc\tptotal\tpgc/pat\tw\n")

    while True:
        line = file1.readline()
        if not line:
            # Write the last scaffold's data
            if current_scaffold is not None:
                gc_at_ratio = datgc / dgcat if dgcat != 0 else 'undefined'
                pgc_pat_ratio = patgc / pgcat if pgcat != 0 else 'undefined'
                result_file.write(f"{current_scaffold}\t{datgc}\t{dgcat}\t{datat}\t{dgcgc}\t{dtotal}\t{gc_at_ratio}\t{patgc}\t{pgcat}\t{patat}\t{pgcgc}\t{ptotal}\t{pgc_pat_ratio}\t{fpos}\n")
                
            break

        # Skip lines that are not Scaffold lines
        if not line.startswith("Scaffold"):
            continue

        # Split the line into columns
        columns = line.strip().split('\t')
        scaffold = columns[0]
        pos= int(int(columns[1])/window)
        # Check if we have moved to a new scaffold
        if current_scaffold is not None and scaffold != current_scaffold:
            # Write the results for the current scaffold
            gc_at_ratio = datgc / dgcat if dgcat != 0 else '0'
            pgc_pat_ratio = patgc / pgcat if pgcat != 0 else 'undefined'
            result_file.write(f"{current_scaffold}\t{datgc}\t{dgcat}\t{datat}\t{dgcgc}\t{dtotal}\t{gc_at_ratio}\t{patgc}\t{pgcat}\t{patat}\t{pgcgc}\t{ptotal}\t{pgc_pat_ratio}\t{fpos}\n")

            datgc = 0
            dgcat = 0
            datat=0
            dgcgc=0
            dtotal = 0
            patgc=0
            pgcat=0
            patat=0
            pgcgc=0
            ptotal=0
            fpos=0
        if fpos !=0 and fpos != pos:
            gc_at_ratio = datgc / dgcat if dgcat != 0 else '0'
            pgc_pat_ratio = patgc / pgcat if pgcat != 0 else 'undefined'
            result_file.write(f"{current_scaffold}\t{datgc}\t{dgcat}\t{datat}\t{dgcgc}\t{dtotal}\t{gc_at_ratio}\t{patgc}\t{pgcat}\t{patat}\t{pgcgc}\t{ptotal}\t{pgc_pat_ratio}\t{fpos}\n")
            datgc = 0
            dgcat = 0
            datat=0
            dgcgc=0
            dtotal = 0
            patgc=0
            pgcat=0
            patat=0
            pgcgc=0
            ptotal=0
            fpos=0
        current_scaffold = scaffold
        fpos=pos
        ref_allele = columns[3]
        alt_allele = columns[4]

#if only one alternative allele:

        if len(alt_allele.split(","))== 1:
        # Extract the first and second allele numbers for frugi, exigua, and litura individuals
            frugi_alleles = [col.split(':')[0] for col in columns[14:46]]
            exigua_alleles = [col.split(':')[0] for col in columns[9:11]]
            litura_alleles = [col.split(':')[0] for col in columns[11:14]]
#        print(exigua_alleles)

        # Check if all first alleles are identical in each group
            frugi=(([re.findall(r'\d+',a) for a in frugi_alleles ]))
            exigua=(([re.findall(r'\d+',a) for a in exigua_alleles ]))
            litura=(([re.findall(r'\d+',a) for a in litura_alleles ]))
            frugi=''.join([item for sublist in frugi for item in sublist])
            exigua=''.join([item for sublist in exigua for item in sublist])
            litura=''.join([item for sublist in litura for item in sublist])
            if len(set(frugi)) == 1 and len(set(exigua)) == 1 and len(set(litura)) == 1:
                if set(exigua) == {'0'} and  set(litura) =={'0'} and set(frugi)=={'1'}:
                    print(frugi)
                    if (ref_allele=="A" or ref_allele=="T") and (alt_allele=="G" or alt_allele=="C"):
                        datgc += 1
                    if (ref_allele=="G" or ref_allele=="C") and (alt_allele=="A" or alt_allele=="T"):
                        dgcat += 1
                    if (ref_allele=="G" or ref_allele=="C") and (alt_allele=="G" or alt_allele=="C"):
                        dgcgc += 1
                    if (ref_allele=="A" or ref_allele=="T") and (alt_allele=="A" or alt_allele=="T"):
                        datat += 1
                    dtotal += 1
                if set(exigua) == {'1'} and  set(litura) =={'1'} and set(frugi)=={'0'}:
                    print(frugi)
                    if (ref_allele=="A" or ref_allele=="T") and (alt_allele=="G" or alt_allele=="C"):
                        dgcat += 1
                    if (ref_allele=="G" or ref_allele=="C") and (alt_allele=="A" or alt_allele=="T"):
                        datgc += 1

                    dtotal += 1
            if len(set(frugi)) == 0 and len(set(exigua)) == 1 and len(set(litura)) == 1:
                if set(exigua) == {'1'} and  set(litura) =={'1'} :
                    if (ref_allele=="A" or ref_allele=="T") and (alt_allele=="G" or alt_allele=="C"):
                        dgcat += 1
                    if (ref_allele=="G" or ref_allele=="C") and (alt_allele=="A" or alt_allele=="T"):
                        datgc += 1
                    if (ref_allele=="A" or ref_allele=="T") and (alt_allele=="A" or alt_allele=="T"):
                        datat+=1
                    if (ref_allele=="C" or ref_allele=="G") and (alt_allele=="G" or alt_allele=="C"):
                        dgcgc+=1
                    dtotal+=1
#polymorphisms
            if len(set(frugi)) != 1 and len(set(frugi))!=0 and len(set(exigua)) == 1 and len(set(litura)) == 1:
                if set(exigua)=={'1'} and set(litura)=={'1'}:
                    if (ref_allele=="A" or ref_allele=="T") and (alt_allele=="G" or alt_allele=="C"):
                        pgcat += 1
                    if (ref_allele=="G" or ref_allele=="C") and (alt_allele=="A" or alt_allele=="T"):
                        patgc += 1
                    if (ref_allele=="A" or ref_allele=="T") and (alt_allele=="T" or alt_allele=="A"):
                        patat+=1
                    if (ref_allele=="G" or ref_allele=="C") and (alt_allele=="G" or alt_allele=="C"):
                        pgcgc+=1
                    ptotal += 1
                    
                if set(exigua)=={'0'} and set(litura)=={'0'}:
                    if (ref_allele=="A" or ref_allele=="T") and (alt_allele=="G" or alt_allele=="C"):
                        patgc += 1
                    if (ref_allele=="G" or ref_allele=="C") and (alt_allele=="A" or alt_allele=="T"):
                        pgcat += 1
                    if (ref_allele=="A" or ref_allele=="T") and (alt_allele=="T" or alt_allele=="A"):
                        patat+=1
                    if (ref_allele=="G" or ref_allele=="C") and (alt_allele=="G" or alt_allele=="C"):
                        pgcgc+=1
                    
                    ptotal += 1
# Close the input file
file1.close()
