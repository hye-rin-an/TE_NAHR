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
