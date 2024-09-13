#!/bin/python

import gzip
import re

# Open the gzipped VCF file
file1 = gzip.open("/home/han/work/Metazoa_holocentrism/gene_conversion/data/vcf/alldanaus.SNP.vcf.gz", "rt")

# Initialize counters and variables
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
with open("/home/han/work/Metazoa_holocentrism/gene_conversion/gbgc.by.window.danaus.txt", "w") as result_file:
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

        if not line.startswith("NC"):
            continue

        columns = line.strip().split('\t')
        scaffold = columns[0]
        pos=int(int(columns[1])/window)
        if current_scaffold is not None and scaffold != current_scaffold:
            gc_at_ratio = datgc / dgcat if dgcat != 0 else '0'
            pgc_pat_ratio = pgcat / pgcat if pgcat != 0 else 'undefined'
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


        if len(alt_allele.split(","))== 1:
            plexippus_alleles = [col.split(':')[0] for col in columns[14:88]]
            eresimus_alleles = [col.split(':')[0] for col in columns[9:11]]
            gilippus_alleles = [col.split(':')[0] for col in columns[11:14]]
#        print(eresimus_alleles)
            #print(plexippus_alleles)
            plexippus=(([re.findall(r'\d+',a) for a in plexippus_alleles ]))
            eresimus=(([re.findall(r'\d+',a) for a in eresimus_alleles ]))
            gilippus=(([re.findall(r'\d+',a) for a in gilippus_alleles ]))
            plexippus=''.join([item for sublist in plexippus for item in sublist])
            eresimus=''.join([item for sublist in eresimus for item in sublist])
            gilippus=''.join([item for sublist in gilippus for item in sublist])
            if len(set(plexippus)) == 0 and len(set(eresimus)) == 1 and len(set(gilippus)) == 1:
                if set(eresimus) == {'1'} and  set(gilippus) =={'1'} :
                    if (ref_allele=="A" or ref_allele=="T") and (alt_allele=="G" or alt_allele=="C"):
                        dgcat += 1
                    if (ref_allele=="G" or ref_allele=="C") and (alt_allele=="A" or alt_allele=="T"):
                        datgc += 1
                    if (ref_allele=="A" or ref_allele=="T") and (alt_allele=="A" or alt_allele=="T"):
                        datat+=1
                    if (ref_allele=="C" or ref_allele=="G") and (alt_allele=="G" or alt_allele=="C"):
                        dgcgc+=1
                    dtotal+=1
 
                    print(set(plexippus),set(eresimus),set(gilippus))

#same with polymorphisms
            if len(set(plexippus)) != 1 and len(set(plexippus)) !=0  and len(set(eresimus)) == 1 and len(set(gilippus)) == 1:
                if set(eresimus)=={'1'} and set(gilippus)=={'1'}:
                    if (ref_allele=="A" or ref_allele=="T") and (alt_allele=="G" or alt_allele=="C"):
                        pgcat += 1
                    if (ref_allele=="G" or ref_allele=="C") and (alt_allele=="A" or alt_allele=="T"):
                        patgc += 1
                    if (ref_allele=="A" or ref_allele=="T") and (alt_allele=="T" or alt_allele=="A"):
                        patat+=1
                    if (ref_allele=="G" or ref_allele=="C") and (alt_allele=="G" or alt_allele=="C"):
                        pgcgc+=1
                    ptotal += 1
                if set(eresimus)=={'0'} and set(gilippus)=={'0'}:
                    if (ref_allele=="A" or ref_allele=="T") and (alt_allele=="G" or alt_allele=="C"):
                        pgc += 1
                    if (ref_allele=="G" or ref_allele=="C") and (alt_allele=="A" or alt_allele=="T"):
                        pat += 1
                    if (ref_allele=="A" or ref_allele=="T") and (alt_allele=="T" or alt_allele=="A"):
                        patat+=1
                    if (ref_allele=="G" or ref_allele=="C") and (alt_allele=="G" or alt_allele=="C"):
                        pgcgc+=1

                    ptotal += 1


# Close the input file
file1.close()
