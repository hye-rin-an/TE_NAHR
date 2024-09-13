#!/bin/R

setwd("~/work/Metazoa_holocentrism/repeatmasker/result")

dir="~/work/Metazoa_holocentrism/repeatmasker/result/lepidoptera"
outputdir="~/work/Metazoa_holocentrism/repeatmasker/result/lepidoptera"
files=list.files(path=dir,pattern="GC*")

res=data.frame()

for (file in files)
        {v=read.table(paste(dir,file,sep="/"),h=T,sep='\t')
B=1000
w=100000
print(file)
                ufamily=unique(v$family)

                for (i in ufamily)
{               vs=subset(v,family==i)
                freq=sum(vs$frequence)

                species=vs$assembly[1]
                cat=vs[,4][1]

                newres=data.frame(sp=species,type=cat,i,freq)
                res<-rbind(res,newres)
                print (res)
}}
write.table(res,paste(outputdir,"LINESINEfam.by.species.tsv",sep="/"),quote=F, sep='\t',row.names=F)

