#!/bin/R

setwd("~/work/Metazoa_holocentrism/repeatmasker/result")

file="~/work/Metazoa_holocentrism/repeatmasker/result/CDSdensity.tsv"
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
                CDS=with(vss,sum(CDSdensity)/nrow(vss))

                bts_CDS=rep(NA,B)

                for (b in 1:B)
                        {bts_CDS[b]=with(vss[sample(c(1:nrow(vss)),replace=T),],sum(CDSdensity)/nrow(vss))
}

                l.ci_CDS=sort(bts_CDS)[0.025*B]
                u.ci_CDS=sort(bts_CDS)[0.975*B]

                species=vss$assembly[1]
                size=nrow(vss)

                newres=data.frame(species=species,chrnb=j,CDS,l.ci_CDS,u.ci_CDS,size)
                res<-rbind(res,newres)
                print(res)
}}

write.table(res,paste(outputdir,"btsCDS.tsv",sep="/"),quote=F, sep='\t',row.names=F)

