#Correlation between pN/pS and chromosome length 

w=100000
dfpnps=read.table("result/bts.PNPS.tsv",sep = "\t", header = TRUE)
colnames(dfpnps)=c("chrcode","PNPS","l.ci_PNPS","u.ci_PNPS","size")
dfpnps=filter(dfpnps, size>15*w,size<200*w)
dfpnps$size=dfpnps$size/1000000

plot<- dfpnps %>%  
  ggplot(aes(size,PNPS)) +       
  geom_point() +
  geom_errorbar(aes(ymin = l.ci_PNPS, ymax = u.ci_PNPS)) + stat_cor(method = "spearman")  + 
theme( panel.background = element_rect(fill = "white", colour = "grey50"),strip.text = element_text(size = 11,face = "italic"),axis.text.x = element_text(size=12),axis.text.y = element_text(size=12),axis.title.x = element_text(size=15),axis.title.y = element_text(size=15)) +labs(y= "pN/pS", x = "chromosome size (Mb)",size = 20)+ expand_limits(x = 0, y = 0)
ggsave("analysis/article/pNpS.frugi.pdf", width=6, height=5)

#Correlation between nucleotide diversity and chromosome length 

dffrugi.PI=read.table("result/bts.frugi.PI.tsv",sep = "\t", header = TRUE)
colnames(dffrugi.PI)=c("chrcode","PI","l.ci_PI","u.ci_PI","size")
dffrugi.PI=filter(dffrugi.PI,15<size &size<200 )
dffrugi.PI$size=dffrugi.PI$size/10

plot1<- dffrugi.PI %>%  
  ggplot(aes(size,PI)) +       
  geom_point() +
  geom_errorbar(aes(ymin = l.ci_PI, ymax = u.ci_PI))     + stat_cor(method = "spearman")+
  scale_x_continuous(trans="log10")  +theme( panel.background = element_rect(fill = "white", colour = "grey50"),strip.text = element_text(size = 11,face = "italic"),axis.text.x = element_text(size=12),axis.text.y = element_text(size=12),axis.title.x = element_text(size=15),axis.title.y = element_text(size=15)) +labs(y= "nucleotide diversity", x = "chromosome size (Mb)",size = 20)+ expand_limits(x = 0, y = 0)+scale_x_continuous(limits = c(0,NA))

#Correlation between substitution rate and chromosome length 

dfsub=read.table("result/bilan.sub.rate.txt",sep = "\t",header = TRUE)
dfsub=dfsub[,-1]
dfsub$size=dfsub$size/1000000
dfsub=filter(dfsub,size>1)
dfsub=filter(dfsub,chromosome!="CM033257.1")
plot1<- dfsub%>%  
  ggplot(aes(size, p.distance)) +       
  geom_point() +
  geom_errorbar(aes(ymin = l.ci_pd, ymax = u.ci_pd))  + stat_cor(method = "spearman",label.y=0.1,size=3) +
  scale_x_continuous(trans="log10")+theme( panel.background = element_rect(fill = "white", colour = "grey50"),strip.text = element_text(size = 11,face = "italic"),axis.text.x = element_text(size=12),axis.text.y = element_text(size=12),axis.title.x = element_text(size=20),axis.title.y = element_text(size=20)) +labs(y= "substitution rate", x = "chromosome size (Mb)",size = 20)+ expand_limits(x = 0, y = 0)+scale_x_continuous(limits = c(0,NA))

#Correlation between dN (/alpha) and chromosome length 

dnds=read.table("test.bts.dnds.tsv",sep="\t",header=TRUE)
pnps=read.table("bts.PNPS.tsv",sep="\t",header=TRUE)
dnds=arrange(dnds,dnds$size)
pnps=arrange(pnps,pnps$size)
dnds$i=c(1:nrow(dnds))
pnps$i=c(1:nrow(pnps))
total= merge(dnds,pnps,by=c("i"="i","size"="size"))
total$alpha=1-total$PNPS*(total$S*total$dS)/(total$N*total$dN)

plot<-total%>%
  ggplot(aes(size/1000000,alpha )) +       
  geom_point(size=2) +
   stat_cor(method = "spearman",label.y=0.01,size=7,cor.coef.name ="rho")  +scale_x_continuous(trans="log10")  +theme(plot.title = element_text(size = 30, face = "bold"), panel.background = element_rect(fill = "white", colour = "grey50"),strip.text = element_text(size = 20,face = "italic"),axis.text.x = element_text(size=15),axis.text.y = element_text(size=15),axis.title.x = element_text(size=25),axis.title.y = element_text(size=25)) +labs(y= "alpha", x = "chromosome size (Mb)",size = 20)+ expand_limits(x = 0, y = 0)+scale_x_continuous(limits = c(0,NA))+  geom_errorbar(aes(ymin = a_inf, ymax = a_sup))
plot
pdf("alpha.pdf", width=10,height=7)      
print(plot)
dev.off()

plot2<-total%>% 
  ggplot(aes(size/1000000,dN )) +       
  geom_point(size=2) +
   stat_cor(method = "spearman",label.y=0.01,size=7,cor.coef.name ="rho")  +scale_x_continuous(trans="log10")  +theme(plot.title = element_text(size = 30, face = "bold"), panel.background = element_rect(fill = "white", colour = "grey50"),strip.text = element_text(size = 20,face = "italic"),axis.text.x = element_text(size=15),axis.text.y = element_text(size=15),axis.title.x = element_text(size=25),axis.title.y = element_text(size=25)) +labs(y= "dN", x = "chromosome size (Mb)",size = 20)+ expand_limits(x = 0, y = 0)+scale_x_continuous(limits = c(0,NA))+  geom_errorbar(aes(ymin = dN_inf, ymax = dN_sup))
plot2
pdf("dN.pdf", width=10,height=7)      
print(plot2)
dev.off()


