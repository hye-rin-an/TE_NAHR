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

#Correlation between E(s) and chromosome length

es=read.table("../sfrugi/Es.tsv",sep = "\t", header = TRUE)
dffrugi.PI=read.table("../Metazoa_holocentrism/vcftools/result/bts.frugi.PI.tsv",sep = "\t", header = TRUE)
btses=read.table("../sfrugi/bts_Es.tsv",sep = "\t", header = TRUE)
es=merge(dffrugi.PI,es,by="chromosome")
es=merge(es,btses,by="chromosome")
es=filter(es,size<200& size >10)
frugiesplot<- es %>%
  ggplot(aes(size/10,Es)) +
  geom_point()+
  scale_x_continuous(trans="log10")  +theme( panel.background = element_rect(fill = "white", colour = "grey50"),strip.text = element_text(size = 11,face = "italic"),axis.text.x = element_text(size=12),axis.text.y = element_text(size=12),axis.title.x = element_text(size=15),axis.title.y = element_text(size=15)) +labs(y= "E(s)", x = "chromosome size (Mb)",size = 20)+ expand_limits(x = 0, y = 0)+scale_x_continuous(limits = c(0,NA))+ stat_cor(method = "spearman",cor.coef.name ="rho",digits=3) +ggtitle("Fall armyworm")+geom_errorbar(aes(ymin = l_ci, ymax = u_ci))
