#!/bin/R

res=data.frame()

v=read.table("/scratch/hran/lepidoptera/result/younglinesine.by.window.tsv",h=T,sep='\t')

B=1000

w=100000
head(v)
colnames(v)=c("species","chromosome","window","type","frequence")

        uspecies=unique(v$species)

        for (i in uspecies)

                {cat (i,"\n")

                vs=subset(v,species==i)
		uchromo=unique(vs$chromosome)
for (j in uchromo) {
		vss=subset(vs,chromosome==j)
		utype=unique(vss$type)
for (k in utype){
		vsss=subset(vss,type==k)
                vsss=na.omit(vsss)
                young=with(vsss,sum(frequence))

                bts=rep(NA,B)

                for (b in 1:B)

                        {bts[b]=with(vsss[sample(c(1:nrow(vsss)),replace=T),],sum(frequence))

}



                l.ci=sort(bts)[0.025*B]

                u.ci=sort(bts)[0.975*B]



                newres=data.frame(species=i,chromosome=j,type=k,young,l.ci,u.ci)

                res<-rbind(res,newres)

                print(res)

}}}



write.table(res,paste("bts.linesineyoung.tsv",sep="/"),quote=F, sep='\t',row.names=F)

