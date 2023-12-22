repeat_byclass<- read.table("result/final.bts_byclass.wlib.tsv",sep = "\t",head=T)
dfGC=read.table("result/btsGC.tsv",sep = "\t",head=T)
dfcds=read.table("result/final.btsCDS.tsv",sep="\t",head=T)
total=read.tabe("result/bts.totalrepeat.tsv",sep="\t",head=T)

all_df <- merge(dfGC,repeat_byclass, 
        by.x=c("species","chrnb"),by.y=c("species","chrnb"))

all_df <- merge(all_df,dfcds, by=c("chrnb"="chrnb"))
all_df<- merge(all_df,total,by=c("chrnb"=chrnb"))
#only consider chromosome sized assembly by removing scaffolds 
all_df=filter(all_df,size>10)

dflep<- repeat_byclass %>% 
  filter(order=="Lepidoptera") 
dflep <- pivot_longer(dflep, cols=c(simple_repeats,low_complexity, LINE,SINE, LTR, DNAtransposons,rolling_circles,satellites,total), names_to = "type", values_to = "Mean")

stat=data.frame()
uspecies=unique(dflep$species)
for (i in uspecies)
{	
   s_df=subset(dflep,species==i)
   utype=unique(s_df$type)
   for (j in utype)
   {if (j=="total"){sub_df=subset(s_df,type==j)

   test <- lm(sub_df$Mean~qlogis(sub_df$GC)+qlogis(sub_df$CDSdensity)+log(sub_df$size)) 
   print(summary(test))
   slope_GC=summary(test)$coefficients["qlogis(sub_df$GC)", "Estimate"]
   pvalue_GC=summary(test)$coefficients["qlogis(sub_df$GC)", "Pr(>|t|)"]
   slope_CDS=summary(test)$coefficients["qlogis(sub_df$CDSdensity)", "Estimate"]
   pvalue_CDS=summary(test)$coefficients["qlogis(sub_df$CDSdensity)", "Pr(>|t|)"]
   slope_size=summary(test)$coefficients["log(sub_df$size)", "Estimate"]
   pvalue_size=summary(test)$coefficients["log(sub_df$size)", "Pr(>|t|)"]
   DF=summary(test)$fstatistic[3] #for degress of freedom
   R2=summary(test)$adj.r.squared
   pvalue_model=pf(summary(test)$fstatistic[1],summary(test)$fstatistic[2],summary(test)$fstatistic[3],lower.tail=FALSE) #for pvalue
   new=data.frame(species=i, type=j,adjustedR2=R2, degree.freedom=DF, pvalue.model=pvalue_model,slope.GC=slope_GC,pvalue.GC=pvalue_GC,slope.CDS=slope_CDS,pvalue.CDS=pvalue_CDS,slope.size=slope_size,pvalue.size=pvalue_size)
   stat<- rbind(stat,new)
   
}}}
stat %>% 
  arrange(type,species) %>%
  write.table("analysis/final/stat.multiple_regression.by_type.tsv",sep="\t",row.names = F)
