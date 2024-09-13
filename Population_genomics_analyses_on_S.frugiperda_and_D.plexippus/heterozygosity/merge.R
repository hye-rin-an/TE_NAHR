B=1000

v.1=read.table("/home/knam/work/missing/FAW.unfiltered.txt",h=T, fill=TRUE)
v.2=read.table("/home/knam/work/missing/FAW.filtered.txt",h=T, fill=TRUE)

v.1[is.na(v.1)] = 0
v.2[is.na(v.2)] = 0

v.1$T=with(v.1,paste(chro,start,sample))
v.2$T=with(v.2,paste(chro,start,sample))

v=merge(v.1,v.2[c(4,5,6)],by='T')[c(2:7)]

vc=subset(v,sample==0)[c(1)]

vg=subset(aggregate(vc[1],by=list(vc$chro),length),chro>10 & chro < 200)
colnames(vg)=c("chrN","size")

vs=subset(v,chro!="Scaffold_66")

RES=data.frame()
for(chromosome in vg$chrN)
{
	vr=subset(vs,chro==chromosome)

	vrg=aggregate(vr[c(4:6)],by=list(vr$sample),sum)

	mn=with(vrg,mean(n.01/(n.01+n.00+n.11)))

	bt=rep(NA,B)
	for(b in 1:B)
	{
		pos=sample(unique(vr$start),replace=T)
		vb=subset(vr,start==pos)
		vbg=aggregate(vb[c(4:6)],by=list(vb$sample),sum)
		bt[b]=with(vbg,mean(n.01/(n.01+n.00+n.11)))
	}
	ui=sort(bt)[975]
	li=sort(bt)[25]		
	
	RES=rbind(RES,data.frame(chrN=chromosome,size=subset(vg,chrN==chromosome)$size,m=mn,u=ui,l=li))
}

write.table(RES,"/home/knam/work/missing/hetero_FAW.txt",row.names=F,sep="\t",quote=F)

with(RES,cor.test(size,m,method="spearman"))

#S = 268.59, p-value = 1.254e-14
#alternative hypothesis: true rho is not equal to 0
#sample estimates:
#      rho 
#0.9402471 

