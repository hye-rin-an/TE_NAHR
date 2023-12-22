Scripts for FAW population genomics analyses

Input file: gz compressed vcf file for FAW

1) Computing pN/pS: PNPS.py
2) Computing π using vcftools: 1kb windowed π: vcf.PI.sh
3) Bootstrapping confidence intervals: bootstrap.*.R
Calculating FAW Substitution rate: Input files: .faa aa sequences of FAW and BAW from NCBI

OrthoFinder: find orthologs 'orthofinder.sh'
From OrthoFinder's output, transform aa sequence to cds sequence using cds sequence file from NCBI: 'aa.to.cds.py'
group orthologs in folders by chromosome: 'group.by.chr.py'
MACSE: align sequences 'MACSE.sh'
Gblocks: eliminate poorly aligned positions and divergent regions of an alignment 'Gblocks.sh'
Filtering aligned sequences to make them have the same length and a length of a multiple of 3: 'filtering.py'
Concatenate all filtered alignment into one sequence by chromosome: 'concat.py'
Convert concatenated sequence file to a Phylip format: 'phylip.py'
Extract 4fold degenerative sites: 'extract_4fold_degenerate_sites.py' #https://github.com/mscharmann/tools/blob/master/extract_4fold_degenerate_sites.py
Bootstrapping using Seqboot software: sample size=1000
Substitution rate calculation by p-distance, p-distance with jukes-cantor's and mean number of transition and transversion sites 'sub.rate.py'
