Scripts for Fall Armyworm (FAW) population genomics analyses

1) Computing pN/pS: PNPS.py

2) Computing π using vcftools: 1kb windowed π: vcf.PI.sh

3) Calculating FAW Substitution rate:
Input files: aa sequences (*.faa) of FAW and Beet Armyworm (BAW) from NCBI
- Find orthologs using OrthoFinder: 'orthofinder.sh'
- From OrthoFinder's output, transform aa sequence to cds sequence using cds sequence file from NCBI: 'aa.to.cds.py'
- group orthologs in folders by chromosome: 'group.by.chr.py'
- align sequences using MACSE: 'MACSE.sh'
- eliminate poorly aligned positions and divergent regions of an alignment using Gblocks: 'Gblocks.sh'
- Filtering aligned sequences to make them have the same length (assure length=multiple of 3) and replace "!" with "N": 'filtering.py'
- Concatenate all filtered alignment into one sequence by chromosome: 'concat.py'
- Convert concatenated sequence file to a Phylip format: 'phylip.py'
- Extract 4fold degenerative sites: 'extract_4fold_degenerate_sites.py' #https://github.com/mscharmann/tools/blob/master/extract_4fold_degenerate_sites.py
- Bootstrapping using Seqboot software: sample size=1000
- Compute different substitution rates (p-distance, p-distance with jukes-cantor's correction and mean number of transition and transversion sites): 'sub.rate.py'

4) Computing Ω, N, dN, S, dS using PAML-codeml
- run codeml: "runcodeml.py" with "codeml.ctl" as control file and "tree" as tree file
- perform bootstrap resampling (1000): "bootstrapsampling.py" with "codeml.ctl.for.bootstrapsampling" 
- run codeml on bootstrapped samples: "runcodeml.for.bootstrapsamples.py" with "codeml.ctl.for.bootstrapsamples" and "tree.for.bootstrapsamples"
- retrieve calculated rates: "dnds.py"

5) Bootstrap confidence intervals: bootstrap.*
