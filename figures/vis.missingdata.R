library("ggplot2")

v=read.table("/home/knam/work/missing/hetero_FAW.txt",h=T)

p=ggplot(v,aes(x=size/10,y=m))+geom_point(size=.8)+theme_bw()+xlab("chromosome size (Mb)")+ylab("#01 / (#00 + #01 + #11)")+xlim(0,16)+ylim(0,max(v$u))+geom_errorbar(aes(ymin=l, ymax=u), width=.2,col="grey50",alpha=.8)

pdf("/home/knam/work/missing/FAW.pi_chrsize_nomissing.pdf",height=4,width=4)
p
dev.off()



