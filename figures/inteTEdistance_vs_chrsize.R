{\rtf1\ansi\ansicpg1252\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fnil\fcharset0 HelveticaNeue;}
{\colortbl;\red255\green255\blue255;\red255\green255\blue255;}
{\*\expandedcolortbl;;\cssrgb\c100000\c100000\c100000;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs20 \cf0 \cb2 \expnd0\expndtw0\kerning0
info=read.table("../info.txt",header=TRUE, sep = "\\t")\cb1 \
\cb2 files <- list.files(path="../", pattern="GC.*TEdist_div5_10_CI.txt", \cb1 \
\cb2 full.names=TRUE, recursive=FALSE)\cb1 \
\cb2 TEdist=data.frame()\cb1 \
\cb2 for (file in files) \{\cb1 \
\cb2 \'a0\'a0\'a0\'a0 t <- read.table(file, header=TRUE) # load file\cb1 \
\cb2 colnames(t)=c("chrN","length","Avg_Dist.5div","Avg_Dist.10div","CI95_5div_lower","CI95_5div_upper","CI95_10div_lower","CI95_10div_upper","ratio","CI95_ratio_lower","CI95_ratio_upper")\cb1 \
\cb2 \'a0\'a0\'a0\'a0 t$ncbi=stringr::str_extract(string = paste(file), pattern = \cb1 \
\cb2 "GC._[0-9]+.[0-9]")\cb1 \
\cb2 \'a0\'a0\'a0\'a0 TEdist=rbind(TEdist,t)\}\cb1 \
\cb2 TEdist_sfc$ncbi="GCA_019297735.1"\cb1 \
\cb2 TEdist=rbind(TEdist,TEdist_sfc)\cb1 \
\cb2 TEdist=merge(TEdist,info,by = "ncbi")\cb1 \
\cb2 TEdist=filter(TEdist,chrN!="Scaffold_66")\cb1 \
\cb2 TEdist=filter(TEdist,length>3000000)\cb1 \
\cb2 TEdist=filter(TEdist,chrN!="NC_056428.1")\cb1 \
\cb2 TEdist=filter(TEdist,chrN!="NC_045836.1")\cb1 \
\cb2 TEdist=filter(TEdist,chrN!="OW152813.1")\cb1 \
\cb2 TEdist=filter(TEdist,chrN!="NC_062998.1")\cb1 \
\cb2 TEdist=filter(TEdist,chrN!="NC_065433.1")\cb1 \
\cb2 TEdist=filter(TEdist,chrN!="NC_064012.1")\cb1 \
\cb2 TEdist=filter(TEdist,chrN!="OU963894.1")\cb1 \
\cb2 TEdist=filter(TEdist,chrN!="OU963895.1")\cb1 \
\
\cb2 p1<-\'a0 ggplot(TEdist,aes(length/1000000,Avg_Dist.5div)) +\cb1 \
\cb2 \'a0\'a0 geom_point()\'a0 +geom_errorbar(aes(ymin = CI95_5div_lower, ymax = \cb1 \
\cb2 CI95_5div_upper))\'a0\'a0\'a0\'a0 +theme( panel.background = element_rect(fill = \cb1 \
\cb2 "white", colour = "grey50"),strip.text = element_text(size = 11,face = \cb1 \
\cb2 "italic"),axis.text.x = element_text(size=12),axis.text.y = \cb1 \
\cb2 element_text(size=12),axis.title.x = element_text(size=15),axis.title.y \cb1 \
\cb2 = element_text(size=15)) +labs(y= "distance between TEs",x="",size = \cb1 \
\cb2 20)+ expand_limits(x = 0, y = 0)+scale_x_continuous(limits = c(0,NA)) + \cb1 \
\cb2 facet_wrap(~species,scales = "free", ncol = 5)+ggtitle("Young TEs (<5% \cb1 \
\cb2 divergence)")\cb1 \
\cb2 \'a0\'a0 #+ stat_cor(method = "spearman",cor.coef.name ="rho",label.y=0.001)\cb1 \
\cb2 print(p1)\cb1 \
\cb2 \'a0\'a0\'a0 p2<-ggplot(TEdist,aes(length/1000000,Avg_Dist.10div)) +\cb1 \
\cb2 \'a0\'a0 geom_point()\'a0 +geom_errorbar(aes(ymin = CI95_10div_lower, ymax = \cb1 \
\cb2 CI95_10div_upper))\'a0\'a0\'a0\'a0 +theme( panel.background = element_rect(fill = \cb1 \
\cb2 "white", colour = "grey50"),strip.text = element_text(size = 11,face = \cb1 \
\cb2 "italic"),axis.text.x = element_text(size=12),axis.text.y = \cb1 \
\cb2 element_text(size=12),axis.title.x = element_text(size=15),axis.title.y \cb1 \
\cb2 = element_text(size=15)) +labs(y= "distance between TEs",x="",size = \cb1 \
\cb2 20)+ expand_limits(x = 0, y = 0)+scale_x_continuous(limits = \cb1 \
\cb2 c(0,NA))+facet_wrap(~species,scales = "free", ncol = 5)+ggtitle("Old TEs \cb1 \
\cb2 (5-10% divergence)")\cb1 \
\cb2 print(p2)\cb1 \
\
\cb2 \'a0\'a0 p3<- ggplot(TEdist,aes(length/1000000,Avg_Dist.5div/Avg_Dist.10div)) +\cb1 \
\cb2 \'a0\'a0 geom_point() +geom_errorbar(aes(ymin = CI95_ratio_lower, ymax = \cb1 \
\cb2 CI95_ratio_upper))\'a0\'a0\'a0\'a0 +theme( panel.background = element_rect(fill = \cb1 \
\cb2 "white", colour = "grey50"),strip.text = element_text(size = 11,face = \cb1 \
\cb2 "italic"),axis.text.x = element_text(size=12),axis.text.y = \cb1 \
\cb2 element_text(size=12),axis.title.x = element_text(size=15),axis.title.y \cb1 \
\cb2 = element_text(size=15)) +labs(y= "distance between young TEs/old TEs", \cb1 \
\cb2 x = "chromosome size (Mb)",size = 20)+ expand_limits(x = 0, y = \cb1 \
\cb2 0)+scale_x_continuous(limits = c(0,NA))+facet_wrap(~species,scales = \cb1 \
\cb2 "free", ncol = 5)\cb1 \
\cb2 p3}