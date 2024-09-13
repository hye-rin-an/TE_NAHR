#!/bin/R

setwd("~/work/Metazoa_holocentrism/repeatmasker/result/lepidoptera")

dir="~/work/Metazoa_holocentrism/repeatmasker/result/lepidoptera/topLINESINE.tsv"
outputdir="~/work/Metazoa_holocentrism/repeatmasker/result/lepidoptera"

res=data.frame()

v=read.table(dir,h=T,sep='\t')
B=1000
w=100000
uspecies=unique(v$assembly)
for (k in uspecies)
	{cat (k,"\n")
	vs=subset(v,assembly==k)
	uchromo=unique(vs$chromosome)
	for (i in uchromo)
                {cat (i,"\n")
                vss=subset(vs,chromosome==i)
                ufamily=unique(vss$family)

		for (j in ufamily)
{		vsss=subset(vss,family==j)
		if (vsss$size > 10*w) 
{ 
                freq=with(vsss,sum(frequence)/vsss$size[1])
  
                bts=rep(NA,B)

                for (b in 1:B)
                        {bts[b]=with(vsss[sample(c(1:nrow(vsss)),replace=T),],sum(frequence)/vsss$size[1])}

                l.ci=sort(bts)[0.025*B]
                u.ci=sort(bts)[0.975*B]

                species=vsss$assembly[1]
                cat=vsss$type[1]
                newres=data.frame(sp=species,i,type=cat,j,freq,l.ci,u.ci,length=vsss$size[1])
                res<-rbind(res,newres)
                print(res)
}}
}
}

write.table(res,paste(outputdir,"bts_topLINESINE.tsv",sep="/"),quote=F, sep='\t',row.names=F)

