library(ggalluvial) #
data(vaccinations)
group_final <- c("未通过筛选(成药性原则)","未通过筛选(脂溶性)", "未通过筛选(脂溶性)", 
  "抗癫痫候选活性化合物", "未通过筛选(临床治疗药物相似性)", "未通过筛选(脂溶性)","未通过筛选(脂溶性)", 
  "未通过筛选(临床治疗药物相似性)","抗癫痫候选活性化合物", "未通过筛选(脂溶性)")
cluster_logp$group_final <- group_final
vaccinations <- transform(vaccinations,
                          response = factor(response, rev(levels(response))))
ggplot(vaccinations,
       aes(x = survey, stratum = response,alluvium = subject,
           y = freq,
           fill = response, label = response)) +
    scale_x_discrete(expand = c(.1, .1)) +
    geom_flow() +
    geom_stratum(alpha = .5) +
    geom_text(stat = "stratum", size = 8) +
    theme(panel.grid = element_blank(), 
         panel.background = element_blank(),
         axis.ticks = element_blank(), 
         axis.text = element_blank(), 
         axis.title = element_blank()) +
    ggtitle("vaccination survey responses at three points in time")


pdf("sankey.pdf", width=15, height=10)
ggplot(data = cluster_logp,
       aes(axis1 = group, axis2 = group_final, y =  c(2,rep(1,9)) ,fill = group_final)) +
    geom_alluvium(aes(fill = group_final)) +
    geom_stratum(aes(fill = group_final),alpha=0,size=1)+
    #geom_text(stat = "stratum",
    #          aes(label = after_stat(stratum)),size=10,family = "simsun") +
    scale_x_discrete(limits = c("group", "variable"),
                     expand = c(0.15, 0.05)) +
    theme_void()+
    theme(text = element_text(family = "simsun"),
          legend.position = "top",
          legend.text = element_text(size= 30),
          legend.title= element_text(size= 30))+
    labs(fill="筛选情况")+
    scale_fill_manual(values = c("#7FC97F","#EF6548","#D7301F","#990000"))+
    guides(fill=guide_legend(ncol=2))
  
dev.off()


#另一种
# Libraries
library(tidyverse)
library(viridis)
library(patchwork)
library(hrbrthemes)
library(circlize)
library(networkD3)

# Load dataset from github
data <- read.table("https://raw.githubusercontent.com/holtzy/data_to_viz/master/Example_dataset/13_AdjacencyDirectedWeighted.csv", header=TRUE)


data_long <- cluster_logp[,c(1,6)] %>%
  mutate(value=cluster_logp[,1])

colnames(data_long) <- c( "value","source", "target")
data_long$target <- paste(data_long$target, " ", sep="")

# From these flows we need to create a node data frame: it lists every entities involved in the flow
nodes <- data.frame(name=c(as.character(data_long$source), as.character(data_long$target)) %>% 
                      unique())

# With networkD3, connection must be provided using id, not using real name like in the links dataframe.. So we need to reformat it.
data_long$IDsource=match(data_long$source, nodes$name)-1 
data_long$IDtarget=match(data_long$target, nodes$name)-1

# prepare colour scale
ColourScal ='d3.scaleOrdinal() .range(["#EF6548","#D7301F","#7FC97F","#990000", "#80B1D3","#FFFFB3","#BEBADA","#74C476" , "#8DD3C7", "#FDB462"])'


data_long$value <- rep(1,nrow(data_long))
pdf("sankey.png", width=8, height=6)
# Make the Network,
sankeyNetwork(Links = data_long, Nodes = nodes,
              Source = "IDsource", Target = "IDtarget",
              Value = "value", NodeID = "name", colourScale=ColourScal, 
              nodeWidth=40, fontSize=35, nodePadding=20,
              fontFamily = "simsun", sinksRight = TRUE)
dev.off()
