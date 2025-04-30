Scripts for nucleotide diversity calculation

- Variant calling including non variant sites: variant_calling_allsites
Input: gvcf file
1) variant calling
2) filtering based on missing data
3) annotate SNPs based on quality
4) exclude low quality SNPs 
Output: vcf with high quality SNPs + non variant sites

- Subset vcf by 4D and 0D sites
1) annotate each site by their coding site types: codingsitetypes.sh
Input: gff and reference genome fasta
Output: bed files
2) subset vcf: recode_4D.0D_vcf.sh

- Run pixy: pixy.sh
