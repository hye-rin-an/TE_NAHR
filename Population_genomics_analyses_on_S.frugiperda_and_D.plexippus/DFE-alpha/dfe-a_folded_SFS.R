#!/bin/R

library(tidyr)
library(dplyr)

dnds=read.table('/scratch/hran/sfrugi/result/FAW_BAW.dnds.tsv',header = T,sep='\t')
sfs=read.table('/scratch/hran/sfrugi/result/SFS.tsv', header = T,sep='\t')
chr=read.table("/scratch/hran/sfrugi/frugi.chr.size.csv",header=T,sep='\t')

ugroup=unique(sfs$chromosome)
for (i in ugroup)
{       cat(i,"\n")
        sfss=subset(sfs,chromosome==i)
 	ch=chr$chrname[chr$chrcode==i]
	dndss=subset(dnds,chromosome==ch)
	totals=0
	totalns=0
        sfssyn=subset(sfss,sfss$type=="Syn")
        sfsnonsyn=subset(sfss,sfss$type=="NonSyn")
        syn=c()
        nonsyn=c()
	dfsyn=c()
	dfnonsyn=c()
        for (k in 1:64)
{       	if ( any(sfssyn$allele_frequency==k))
{			s=sfssyn$count[sfssyn$allele_frequency==k]
			print(s)
			s=sum(as.numeric(s))
			syn<- c(syn,s)
			totals=totals+sum(as.numeric(sfssyn$count[sfssyn$allele_frequency==k]))}
                else    
{                       syn<-c(syn, 0)}
                if ( any(sfsnonsyn$allele_frequency==k))
{               	ns=sfsnonsyn$count[sfsnonsyn$allele_frequency==k]
			ns=sum(as.numeric(ns))
			nonsyn<-c(nonsyn,ns)
			totalns=totalns+sum(as.numeric(sfsnonsyn$count[sfsnonsyn$allele_frequency==k]))}
                else
{                       nonsyn<-c(nonsyn, 0)}}
	if (nrow(dndss)!=0) 
                {x=dndss$S-totals
		print(syn)
                syn <- c(as.integer(x),syn)
                x=dndss$N-totalns
                nonsyn<- c(as.integer(x),nonsyn)
		print(syn)
#fold SFS 	
		for (k in 1:65)
{			if (k<33)
{
				x=as.numeric(syn[k])+as.numeric(syn[66-k])
			
				dfsyn<-c(dfsyn,x)
				x=as.numeric(nonsyn[k])+as.numeric(nonsyn[66-k])
				dfnonsyn<-c(dfnonsyn,x)}
			if (k==33)
{
				dfsyn <- c(dfsyn,syn[33])	
				dfnonsyn<-c(dfnonsyn,nonsyn[33])}
			if (k>33)
{				dfsyn<-c(dfsyn,0)
				dfnonsyn<-c(dfnonsyn,0)}}      
		totalns=0
		totals=0
	        txt=paste("1\n64\n",paste(dfnonsyn,collapse=" "),"\n",paste(dfsyn,collapse=" "),sep="")
		#print(txt)
        	output<-file(paste("/scratch/hran/sfrugi/result/SFS_for_DFE-a/folded_SFS_",i,".tsv",sep=""),open="w")
      	 	writeLines(txt, output)
        	close(output)}}

