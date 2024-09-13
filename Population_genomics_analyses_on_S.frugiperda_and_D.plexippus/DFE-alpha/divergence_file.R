#!/bin/R

library(tidyr)
library(dplyr)

df=read.table('/scratch/hran/sfrugi/result/FAW_BAW.dnds.tsv', header = T,sep='\t')
chr=read.table("/scratch/hran/sfrugi/frugi.chr.size.csv",header=T,sep='\t')
ugroup=unique(df$chromosome)
for (i in ugroup)
{       cat(i,"\n")
	ch=chr$chrcode[chr$chrname==i]
        sdf=subset(df,chromosome==i)	
	dn=sdf$N*sdf$dN
	ds=sdf$S*sdf$dS	
	txt=paste("1",as.integer(sdf$N), as.integer(dn),"\n0",as.integer(sdf$S),as.integer(ds) ,sep=" ")
output<-file(paste("/scratch/hran/sfrugi/data/divergence/divergence_file_",ch,sep=""),open="w")

writeLines(txt, output)
close(output)}
