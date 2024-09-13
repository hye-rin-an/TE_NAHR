Scripts for Fall Armyworm (FAW) and Monarch butterfly population genomics analyses

- Variant calling for Monarch buttefly
1) Download fastq files: "jm.fetch.pl"
2) Make reference dictionary and index the reference genome: "gatk_dictionary.sh" and ref.index.sh
3) Identify and remove adapters: "adapter_guess.sh"
4) Mapping: "jm.mapping.pl" 
Input: filtered fastq files and reference genome
Output: bam files
5) Haplotype calling: "jm.gvcf.pl"
Input: bam files
Output: GVCF files
6) Merge GVCF files: "merge.gvcf.sh"
7) Variant calling: "variant.calling.sh"
Input: merged GVCF
Output: VCF 
8) Filter VCF file: "vcf.filtering.sh"
9) snpEff: "vcf_annotation.sh"
Annotate vcf file

- Calculate π by 1000kb window using VCFtools: "vcf.PI.sh"
Input: VCF files

- Heterozygosity: 
1) Variant calling: "variant.calling.sh" 
Input: GVCF files
Run variant calling to for all sites including non-variable sites
2) Calculate heterozygosity by 100kb window
Input: VCF files from all sites + filtered VCF files with only variable sites
Count 0/0 from non variable sites in unfiltered VCF files: "unfiltered.vcf.count.pl"
count 0/1 and 1/1 from variable sites in filtered VCF files: "filtered.vcf.count.pl"
merge info to calculate heterozygosity = #01/(#00+#01+#11) : "merge.R"

- Calculate pN/pS by 100kb window: "PNPS.py"
Input: annotated VCF files

- Calculate pairwise dN/dS ratios:
Input files: amino acid sequences (*.faa) from NCBI
1) OrthoFinder: 'orthofinder.sh'
Find single-copy orthologs between fall armyworm and beetarmyworm, and between monarch butterfly and painted lady butterfly.
2) From OrthoFinder's output, transform amino acid sequences to coding sequences using cds sequence file from NCBI: 'aa.to.cds.py'
3) Group orthologs in folders by chromosome: 'group.by.chr.py'
4) MACSE: "MACSE.sh"
Align sequences
5) Gblocks: "Gblocks.sh"
Eliminate poorly aligned positions and divergent regions and concatenate aligned sequences by chromosome
6) For bootstrapping, single-copy orthologs identified from BUSCO were grouped by 100kb window: "orthologs2window.py"
1000 bootstrapping samples were generated on 100kb windows: "bootstrap_window.py"
Gblocks for concatenating orthologs in chosen windows by sample: "concat_by_sample.py"
7) Convert concatenated sequence file to a Phylip format: 'fasta2phylip.py'
8) PAML
Run CodeML: "runcodeml.py"
Input: Phylip files + "codeml.ctl" + "tree" 
9) Retrieve dN/dS by chromosome: "dnds.py" and "bootstrap.dnds.py"

- Calculate substitution rates on four-fold degenerative sites
1) Extract four-fold degenerative sites: "extraction.py" using https://github.com/mscharmann/tools/blob/master/extract_4fold_degenerate_sites.py
Input: ortholog alignment concatenated by chromosome
2) 1000 bootstrap samples generated with Seqboot
3) Calculate sequence divergence by counting #substitution in 100kb window: "sub.rate.py"
Compute different substitution rates (p-distance, p-distance with jukes-cantor's correction and mean number of transition and transversion sites)

- Calculate DFE 
1) Calculate SFS from synonymous and non synonymous SNPs: "SFS.py"
Input: Annotated VCF files
2) Fold SFS: "dfe-a_folded_SFS.R"
Input: SFS files + dN/dS from PAML
3) Divergence data from beet armyworm/painted lady butterfly: "divergence_file.R"
Input: dN/dS from PAML
4) Estimate DFE with DFE-alpha, by chromosome: "DFE-a_parallel.sh"
Input: "chr_list.txt" + "config-file.est_dfe_class2.txt" + folded SFS files
5) Estimate omega from DFE: "DFE-a_parallel.sh"
Input: "config-file.est_alpha_omega.txt" + output from DFE estimation + divergence data files
6) For bootstrapping, the same pipeline was used to generate folded SFS and divergence files, and to estimate Es and omega on the bootstrap samples for dN/dS calculation.
"SFS_bts.R", "divergence_file.by.sample.R"
7) Retrieve Es and omega: "omega.py" and "Es.py"

- gBGC
1) Resequencing data from outgroups (Spodoptera frugiperda and Spodoptera exigua, and Danaus eresimus and Danaus gilippus) using the same pipeline as D. plexippus. 
fastq download, fastq filtering, mapping, and haplotype calling againt the reference genome of S. frugiperda or D. plexippus
2) Merging GVCF, variant calling, filtering by species: "merge.gvcf.eresimus.sh", "merge.gvcf.gilippus.sh", "merge.gvcf.exigua.sh" and ""merge.gvcf.litura.sh"   
3) Merge VCF by genus (Spodoptera or Danaus): "merge.vcf.danaus.sh" and "merge.vcf.spodoptera.sh"
4) Count ATtoGC, GCtoAT, ATtoAT, and GCtoGC substitutions and polymorphisms by 100kb window: "AT.GC.substitution.by.window.danaus.py" and "AT.GC.substitution.by.window.frugi.py"
5) Calculate ATtoGC/GCtoAT substitution or polymorphism ratios
6) Retrieve 95% confidence intervals by 1000 bootstrap sampling: "bts.gbgc.danaus.R" and "bts.gbgc.frugi.R"


- Estimating codon usage bias: ENC.sh
INPUT: CDS fasta files
