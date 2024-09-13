#!/bin/R



setwd("~/work/Metazoa_holocentrism/gene_conversion/")



dir="~/work/Metazoa_holocentrism/gene_conversion/gbgc.by.window.danaus.txt"

outputdir="~/work/Metazoa_holocentrism/gene_conversion"


res=data.frame()



v=read.table(dir,h=T,sep='\t')

B=1000

w=100000

colnames(v)=c('CHROM','dgc','dat','dtotal','dgcat', 'pgc','pat','ptotal','pgcat','w')
v$dgcat=as.numeric(v$dgcat)
v$pgcat=as.numeric(v$pgcat)

        uchromo=unique(v$CHROM)

        for (i in uchromo)

                {if (nrow(v)>1)
			    
		{cat (i,"\n")

                vs=subset(v,CHROM==i)



                dgbgc=with(vs,(sum(dgc)/sum(dat)))
		pgbgc=with(vs,(sum(pgc)/sum(pat)))

                bts_d=rep(NA,B)
		bts_p=rep(NA,B)

                for (b in 1:B)

                        {bts_d[b]=with(vs[sample(c(1:nrow(vs)),replace=T),],(sum(dgc)/sum(dat)))
			bts_p[b]=with(vs[sample(c(1:nrow(vs)),replace=T),],(sum(pgc)/sum(pat)))

}



                l.ci_d=sort(bts_d)[0.025*B]
               u.ci_d=sort(bts_d)[0.975*B]
                l.ci_p=sort(bts_p)[0.025*B]
               u.ci_p=sort(bts_p)[0.975*B]





                newres=data.frame(chromosome=i,"dgc/dat"=dgbgc,l.ci_d,u.ci_d,"pgc/pat"=pgbgc,l.ci_p,u.ci_p)

                res<-rbind(res,newres)

                print(res)

}}



write.table(res,paste(outputdir,"bts.danaus.gbgc.tsv",sep="/"),quote=F, sep='\t',row.names=F)

