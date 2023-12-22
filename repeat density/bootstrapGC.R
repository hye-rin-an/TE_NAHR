#!/bin/R

setwd("~/work/Metazoa_holocentrism/repeatmasker/result")

file="~/work/Metazoa_holocentrism/repeatmasker/result/GC_content.tsv"
outputdir="~/work/Metazoa_holocentrism/repeatmasker/result"

v=read.table(file,h=T,sep='\t')

B=1000
w=100000

#colnames(v)=c()
uassembly=unique(v$assembly)
#print(uchromo)
res=data.frame()

for (i in uassembly)
{
        cat(i,"\n")
        vs=subset(v,assembly==i)
	
	uchromo=unique(vs$chromosome)
	for (j in uchromo)
		{cat (j,"\n")
		vss=subset(vs,chromosome==j)
        	GC=with(vss,sum(GCcount)/(sum(non_GCcount)))

        	bts_GC=rep(NA,B)
  
       		for (b in 1:B)
      			{bts_GC[b]=with(vss[sample(c(1:nrow(vss)),replace=T),],sum(GCcount)/(sum(non_GCcount)))
}

        	l.ci_GC=sort(bts_GC)[0.025*B]
        	u.ci_GC=sort(bts_GC)[0.975*B]
     
        	species=vss$assembly[1]
        	size=nrow(vss)

        	newres=data.frame(sp=species,j,GC,l.ci_GC,u.ci_GC,size)
        	res<-rbind(res,newres)
        	print(res)
}}

write.table(res,paste(outputdir,"btsGC.tsv",sep="/"),quote=F, sep='\t',row.names=F)

