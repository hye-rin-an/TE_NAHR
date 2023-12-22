#!/bin/R

setwd("~/work/Metazoa_holocentrism/repeatmasker/result")

file="~/work/Metazoa_holocentrism/repeatmasker/result/repeat_byclass.wlib.tsv"
outputdir="~/work/Metazoa_holocentrism/repeatmasker/result"

v=read.table(file,h=T,sep='\t')

B=1000
w=100000

#colnames(v)=c()
uchromo=unique(v$chromosome)
#print(uchromo)
res=data.frame()

for (i in uchromo)
{
        cat(i,"\n")
        vs=subset(v,chromosome==i)
#	print(nrow(vs))
        sr=with(vs,sum(simple_repeat)/(w*nrow(vs)))
	lc=with(vs,sum(low_complex)/(w*nrow(vs)))
	line=with(vs,sum(LINE)/(w*nrow(vs)))
	sine=with(vs,sum(SINE)/(w*nrow(vs)))
	ltr=with(vs,sum(LTR)/(w*nrow(vs)))
	dna=with(vs,sum(DNAtrans)/(w*nrow(vs)))
	rc=with(vs,sum(rollingcircle)/(w*nrow(vs)))
	st=with(vs,sum(satellites)/(w*nrow(vs)))
#        repeat_density=with(vs,sum(sr+lc+line+sine+ltr+dna+rc+st))  
        

        bts_sr=rep(NA,B)
        bts_lc=rep(NA,B)
        bts_line=rep(NA,B)
        bts_sine=rep(NA,B)
        bts_ltr=rep(NA,B)
        bts_dna=rep(NA,B)
        bts_rc=rep(NA,B)
        bts_st=rep(NA,B)

        for (b in 1:B)
        {bts_sr[b]=with(vs[sample(c(1:nrow(vs)),replace=T),],sum(simple_repeat)/(w*nrow(vs)))
        bts_lc[b]=with(vs[sample(c(1:nrow(vs)),replace=T),],sum(low_complex)/(w*nrow(vs)))
        bts_line[b]=with(vs[sample(c(1:nrow(vs)),replace=T),],sum(LINE)/(w*nrow(vs)))
        bts_sine[b]=with(vs[sample(c(1:nrow(vs)),replace=T),],sum(SINE)/(w*nrow(vs)))
        bts_ltr[b]=with(vs[sample(c(1:nrow(vs)),replace=T),],sum(LTR)/(w*nrow(vs)))
        bts_dna[b]=with(vs[sample(c(1:nrow(vs)),replace=T),],sum(DNAtrans)/(w*nrow(vs)))
        bts_rc[b]=with(vs[sample(c(1:nrow(vs)),replace=T),],sum(rollingcircle)/(w*nrow(vs)))
        bts_st[b]=with(vs[sample(c(1:nrow(vs)),replace=T),],sum(satellites)/(w*nrow(vs)))
#        bts_repeatdensity[b]=with(vs[sample(c(1:nrow(vs)),replace=T),], sum(sr+lc+line+sine+ltr+dna+rc+st))

}



        l.ci_sr=sort(bts_sr)[0.025*B]
        u.ci_sr=sort(bts_sr)[0.975*B]
        l.ci_lc=sort(bts_lc)[0.025*B]
        u.ci_lc=sort(bts_lc)[0.975*B]
        l.ci_line=sort(bts_line)[0.025*B]
        u.ci_line=sort(bts_line)[0.975*B]
        l.ci_sine=sort(bts_sine)[0.025*B]
        u.ci_sine=sort(bts_sine)[0.975*B]
        l.ci_ltr=sort(bts_ltr)[0.025*B]
        u.ci_ltr=sort(bts_ltr)[0.975*B]
        l.ci_dna=sort(bts_dna)[0.025*B]
        u.ci_dna=sort(bts_dna)[0.975*B]
        l.ci_rc=sort(bts_rc)[0.025*B]
        u.ci_rc=sort(bts_rc)[0.975*B]
        l.ci_st=sort(bts_st)[0.025*B]
        u.ci_st=sort(bts_st)[0.975*B]
        species=vs$assembly[1]
        size=nrow(vs)
        
	newres=data.frame(sp=species,i,sr,l.ci_sr,u.ci_sr,lc,l.ci_lc,u.ci_lc,line,l.ci_line,u.ci_line,sine,l.ci_sine,u.ci_sine,ltr,l.ci_ltr,u.ci_ltr,dna,l.ci_dna,u.ci_dna,rc,l.ci_rc,u.ci_rc,st,l.ci_st,u.ci_st,size)
        res<-rbind(res,newres)
	print(newres)
}

write.table(res,paste(outputdir,"bts_byclass.wlib.tsv",sep="/"),quote=F, sep='\t',row.names=F)

