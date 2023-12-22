dfage=read.table("result/LINESINE%div.tsv",sep="\t")
dfage$frequence=as.numeric(dfage$frequence)
dfage$div=as.numeric(dfage$div)
df=subset(dfage,order=="Lepidoptera")

dfline=subset(df,type=="LINE")
uspecies=unique(dfline$species)
line=data.frame()

for (i in uspecies)
{	
   s_df=subset(dfline,species==i)
   uchr=unique(s_df$chromosome)
   for (j in uchr)
   {su_df=subset(s_df,chromosome==j)
   sub_df=subset(su_df,div %in% (0:5))
    young=with(sub_df,sum(frequence))
    sp=sub_df$species[1]
    chr=sub_df$chromosome[1]
    l=sub_df$size[1]*100000
  
    new=data.frame(type="line",species=sp,chromosome=chr,youngrepeat=young/l, size=sub_df$size[1]/10)
    line=rbind(line,new) }
}
  
dfsine=subset(df,type=="SINE")
sine=data.frame()
for (i in uspecies)
{	
   s_df=subset(dfsine,species==i)
   uchr=unique(s_df$chromosome)
   for (j in uchr)
   {su_df=subset(s_df,chromosome==j)
    sub_df=subset(su_df,div %in% (0:5))
    if ((dim(sub_df)[1] == 0))
    {new=data.frame(type="sine",species=su_df$species[1],chromosome=su_df$chromosome[1],youngrepeat=0, size=su_df$size[1])}
    else {young=with(sub_df,sum(frequence))
    sp=sub_df$species[1]
    chr=sub_df$chromosome[1]
    l=sub_df$size[1]*100000
  
    new=data.frame(type="sine",species=sp,chromosome=chr,youngrepeat=young/l, size=sub_df$size[1]/1)}
    sine=rbind(sine,new) }
}

plot1<-  ggplot(line,aes(size, youngrepeat)) +       
  geom_point(size=1.5) +
 scale_x_continuous(trans="log10")  +facet_wrap(~species, scales = "free")+theme( panel.background = element_rect(fill = "white", colour = "grey50"),strip.text = element_text(size = 20,face = "italic"),axis.text.x = element_text(size=15),axis.text.y = element_text(size=15),axis.title.x = element_text(size=30),axis.title.y = element_text(size=30))  + expand_limits(x = 0, y = 0)+scale_x_continuous(limits = c(0,NA)) +labs(y= "proportion of young LINE", x = "chromosome size (Mb)")

plot2<-ggplot(sine,aes(size, youngrepeat)) +       
geom_point(size=1.5) +
 scale_x_continuous(trans="log10")  +facet_wrap(~species, scales = "free")+theme( panel.background = element_rect(fill = "white", colour = "grey50"),strip.text = element_text(size = 20,face = "italic"),axis.text.x = element_text(size=15),axis.text.y = element_text(size=15),axis.title.x = element_text(size=30),axis.title.y = element_text(size=30))  + expand_limits(x = 0, y = 0)+scale_x_continuous(limits = c(0,NA)) +labs(y= "proportion of young SINE", x = "chromosome size (Mb)")

  pdf("analysis/article/youngLINE.pdf", width=18, height=9)
  print(plot1)
  dev.off()
  
  pdf("analysis/article/youngSINE.pdf",width=18, height=9)
  print(plot2)
  dev.off()
