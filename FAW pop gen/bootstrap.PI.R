#!/bin/R

setwd("~/work/Metazoa_holocentrism/vcftools/result")
dir="~/work/Metazoa_holocentrism/vcftools/result/frugi.vcf.out.windowed.pi"
outputdir="~/work/Metazoa_holocentrism/vcftools/result"

res=data.frame()

v=read.table(dir,h=T,sep='\t')

B=1000

w=100000

colnames(v)=c('CHROM','BIN_START','BIN_END','N_VARIANTS','Pi')

        uchromo=unique(v$CHROM)

        for (i in uchromo)

                {cat (i,"\n")

                vs=subset(v,CHROM==i)



                PI=with(vs,(sum(Pi*N_VARIANTS))/(nrow(vs)*w))

                bts=rep(NA,B)

                for (b in 1:B)

                        {bts[b]=with(vs[sample(c(1:nrow(vs)),replace=T),],(sum(Pi*N_VARIANTS))/(nrow(vs)*w))

}



                l.ci=sort(bts)[0.025*B]

                u.ci=sort(bts)[0.975*B]



                newres=data.frame(chromosome=i,PI,l.ci,u.ci,size=nrow(vs))

                res<-rbind(res,newres)

                print(res)

}

write.table(res,paste(outputdir,"bts.frugi.PI.tsv",sep="/"),quote=F, sep='\t',row.names=F)

