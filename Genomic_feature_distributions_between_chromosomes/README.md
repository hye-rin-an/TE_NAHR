These scripts are used to calculate different densities (CDS, GC and repeat)

- RepeatModeler
Input: fasta files from NCBI
Generate TE master sequence libraries per species: "jm.RepeatModeler.pl"

- RepeatMasker
Identify repeats using libraries from RepeatModeler: "jm.RepeatMasker.py"
Input: fasta files + RepeatModeler libraries
Output: *.tbl, *.masked and *.out

- Calculate repeat/GC/CDS densities in 100kb window:
1) Calculate total repeat density: "totalrepeat.py"
Input: *.masked files
2) Calculate repeat density by type of repeats: "repeatbyclass.py"
Input: *.out files
3) Calculate divergence from master sequence distribution of LINE and SINE: "age.distribution.py"
Input: *.out files
Considered as "young LINE/SINE" when divergence < 5%, calculate their density by window: "LINE.SINE.young.by.window.py" 
4) Calculate frequency of different LINE and SINE sub-families by window: "LINSINE.subfamily.distribution.bywindow.py"
Input: *.out files
Then sum up to find the most abundunt families per species: "family.distribution.byspecies.R"
Calculate their repeat density: "top.LINESINE.py"
5) Calculate GC content: "GCcontent.py"
Input: fasta files
6) Calculate CDS density: "CDSdensity.py"

- bootstrapping on window for confidence intervals: "bootstrap.*.R"

- Calculate inter-TE distances: TE_distance.pl
Input: *.out files
