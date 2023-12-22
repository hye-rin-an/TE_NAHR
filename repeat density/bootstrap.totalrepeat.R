#!/bin/R

setwd("~/work/Metazoa_holocentrism/repeatmasker/result")

file="~/work/Metazoa_holocentrism/repeatmasker/result/totalrepeat.tsv"
outputdir="~/work/Metazoa_holocentrism/repeatmasker/result"

v=read.table(file,h=T,sep='\t')
colnames(v)
B=1000
w=100000
res=data.frame()

usp=unique(v$assembly)
for (j in usp)
{ vs=subset(v,assembly==j)
cat (j,"\n")
#colnames(v)=c()
uchromo=unique(vs$chromosome)
#print(uchromo)

for (i in uchromo)
{
        cat(i,"\n")
        vss=subset(vs,chromosome==i)
	tot=with(vss,sum(X)/sum(vss$total))
        
        bts=rep(NA,B)

        for (b in 1:B)
        {bts[b]=with(vss[sample(c(1:nrow(vss)),replace=T),],sum(X)/sum(vss$total))

}



        l.ci=sort(bts)[0.025*B]
        u.ci=sort(bts)[0.975*B]
        size=sum(vss$total)
        
	newres=data.frame(species=j,i,totalrepeat_density=tot,l.ci,u.ci,size)
        res<-rbind(res,newres)
	print(newres)
}}

write.table(res,paste(outputdir,"bts.totalrepeat.tsv",sep="/"),quote=F, sep='\t',row.names=F)

