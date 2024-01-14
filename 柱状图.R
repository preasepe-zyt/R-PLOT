test_design<-read.csv("test_design.csv",row.names = 1)
#设置分组，这里设置6个分组，作为配色方案
test_design$Treatment<-c(rep("EP",4),rep("CP",4),rep("WP",4),rep("PC",4),rep("WPC",4),rep("WC",4))
df2<-test_design[,c(2,3)]
#统计平均值，以Treatment为基础统计，分别为6个分组
mean_df<-aggregate(df2[,2],by=list(df2[,1]),FUN=mean)
rownames(mean_df)<-mean_df[,1]
#统计标准差，以Treatment为基础统计，分别为6个分组
sd_df<-aggregate(df2[,2],by=list(df2[,1]),FUN=sd)
rownames(sd_df)<-sd_df[,1]
sd_df<-sd_df[,-1]
#计算标准误，样品数量为4，因此标准差为除以2，获得se值。
sd_df<-sd_df/2
se<-as.data.frame(sd_df)
#合并数据框，以及标准误。
df1<-cbind(mean_df,se)
colnames(df1)<-c("group","mean","se")
colnames(df2)<-c("group","Gene_Abundance")
#添加facet,年间作为facet,这里避免重复，不重复放代码
#Date<-data.frame(c(rep("2010",6)))
Date<-data.frame(c(rep("2011",6)))
colnames(Date)<-"Date"
df1<-cbind(df1,Date)
my_comparisons <- list( c("Ctl", "F"), c("Ctl", "Prednisolone"), c("F", "Prednisolone") )
#绘图，geom_bar添加平均值柱子，geom_jitter用df2数据框加散点，geom_errorbar添加标准误误差棒
ggplot(data=final2,mapping=aes(x=variable,y=value))+
  geom_bar(data=final2,mapping=aes(x=variable,y=value,fill=variable,color=variable),size = 1.2,alpha=0.7,
                  position="dodge", stat="identity",width = 0.85,inherit.aes=FALSE)+  
    scale_fill_manual(values=c("#56B4E9","#F2C661","#CC78A6")) +
    scale_color_manual(values=c("#56B4E9","#F2C661","#CC78A6")) +
    stat_compare_means(method = "t.test",comparisons = my_comparisons)+
    geom_signif(annotations = c("***", "###","###","#","#","#")
                ,y_position = c(1, 1.5, 2, 2.5,3,3.5)
                ,xmin = c(1, 2, 2, 2,2,2)
                ,xmax = c(2, 3, 4, 5,6,7)
                #,tip_length = c(0.05,0.4,0.05,0.2,0.05,0.01)
                ,color="black")+
  geom_text(data=df1,mapping=aes(x=group,y=mean,label=mean,vjust = -0.5,color = group), show.legend = TRUE,size=8)
