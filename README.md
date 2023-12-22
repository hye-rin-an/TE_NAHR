These scripts were used to generate results in a paper published in PNAS.

Input files: Chromosome sized genome assemblies downloaded from NCBI

1) RepeatModelor: jm.RepeatModeler.pl to generate repeat libraries per species

2) RepeatMasker: 
Grasshopper (Schistocerca americana)'s genome is 9Gb, so chrsplit.GrassHopper.pl to separate the genome by chromosome.
jm.RepeatMasker.py to detect and identify repeats using libraries from RepeatModeler

When you finish running RepeatMasker, the following files will be created: .tbl, .masked and .out

Input files: .masked
	2a) calculating Total repeat density: totalrepeat.py
	2b) calculating GC content: GCcontent.py
Input files: .out
	2c) calculating Repeat density by class of repeats: repeatbyclass.py
	2d) calculating Age of LINE and SINE: age.distribution.py
	2e) calculating frequency of different LINE and SINE families: 
	- by 1kb window: family.distribution.bywindow.py
	- by species: family.distribution.byspecies.R
	- calculating repeat density of top 5 most abundunt families of LINE and SINE for each species: freq.top5.bywindow.py

For each calculation, bootstrapping was performed for the confidence intervals: bootstrap.*.R

Input files: gff files from NCBI
1) calculating CDS density: CDSdensity.py
2) Bootstrapping: bootstrap.CDS.R


Input file: gz compressed vcf file for FAW
1) pN/pS: PNPS.py
2) calculating number of non synonymous/synonymous singletons: NS.singleton.py and syn.singleton.py
3) folded Allele frequency Spectrum (AFS): 
First, you calculate the AFS 'AFS.py', then transform into folded AFS 'foldedAFS.py'
3) vcftools: 
- Tajima's D: Tajima's D was calculated with a large window containing the full length of the chromosome: vcf.tajimaD.bychr.sh
Then, again calculated with a window size of 500kb, in order to obtain bootstrap confidence intervals: vcf.tajimaD.by500kb.sh
- 1kb windowed Pi: vcf.PI.sh
4) Bootstrapping: bootstrap.*.R


Calculating FAW Substitution rate:
Input files: .faa aa sequences of FAW and BAW from NCBI
1) OrthoFinder: find orthologs 'orthofinder.sh'
2) From OrthoFinder's output, transform aa sequence to cds sequence using cds sequence file from NCBI: 'aa.to.cds.py'
3) group orthologs in folders by chromosome: 'group.by.chr.py'
4) MACSE: align sequences 'MACSE.sh'
5) Gblocks: eliminate poorly aligned positions and divergent regions of an alignment 'Gblocks.sh'
6) Filtering aligned sequences to make them have the same length and a length of a multiple of 3: 'filtering.py'
7) Concatenate all filtered alignment into one sequence by chromosome: 'concat.py' 
8) Convert concatenated sequence file to a Phylip format: 'phylip.py'
9) Extract 4fold degenerative sites: 'extract_4fold_degenerate_sites.py' #https://github.com/mscharmann/tools/blob/master/extract_4fold_degenerate_sites.py
10) Bootstrapping using Seqboot software: sample size=1000
11) Substitution rate calculation by  p-distance, p-distance with jukes-cantor's and mean number of transition and transversion sites 'sub.rate.py'
