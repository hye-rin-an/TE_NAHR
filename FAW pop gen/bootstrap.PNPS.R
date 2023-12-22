#!/bin/R

setwd("~/work/Metazoa_holocentrism/FAW_pnps/result")

file="~/work/Metazoa_holocentrism/FAW_pnps/result/PNPS.tsv"
outputdir="~/work/Metazoa_holocentrism/FAW_pnps/result"

v=read.table(file,h=T,sep='\t')

B=1000
w=100000

uchromo=unique(v$chromosome)
res=data.frame()
for (i in uchromo)
{
        cat(i,"\n")
        vs=subset(v,chromosome==i)
	if (vs$size[1]>0)
{
	pnps=with(vs,sum(PN)/sum(PS))
	bts=rep(NA,B)
        for (b in 1:B)
{bts[b]=with(vs[sample(c(1:nrow(vs)),replace=T),],sum(PN)/sum(PS))
}
	l.ci=sort(bts)[0.025*B]
	u.ci=sort(bts)[0.975*B]
	size=vs$size[1]
	newres=data.frame(chromosome=i,PNPS=pnps,l.ci,u.ci,size)
	res<-rbind(res,newres)
	print(res)
}}

write.table(res,paste(outputdir,"bts.PNPS.tsv",sep="/"),quote=F, sep='\t',row.names=F)

