#install.packages("igraph")
library(igraph)
library(dplyr)
library(magrittr)

network_data <- read.csv("data.csv", header = TRUE)
colnames(network_data)=c("circRNA","miRNA","mRNA")

# 创建空的网络对象
g <- graph.empty(n =length(c(unique(network_data$miRNA),unique(network_data$circRNA),unique(network_data$mRNA))), directed = TRUE)

# 添加节点
g <- g %>%
  set_vertex_attr("name", value = c(unique(network_data$circRNA), unique(network_data$miRNA), unique(network_data$mRNA))) %>%
  set_vertex_attr("type", value = c(rep("circRNA", length(unique(network_data$circRNA))), 
                                    rep("miRNA", length(unique(network_data$miRNA))), 
                                    rep("mRNA", length(unique(network_data$mRNA)))))
g <- set_vertex_attr(g,"color", value = ifelse(V(g)$type == "circRNA", "#fb8072", ifelse(V(g)$type == "miRNA", "yellow3", "#80b1d3")))

# 添加边与边长
afedge <- c()
aflength <- c()
for(i in 1:nrow(network_data)) {
  circRNA_node <- which(V(g)$name == network_data[i,1])
  miRNA_node <- which(V(g)$name == network_data[i,2])
  mRNA_node <- which(V(g)$name == network_data[i,3])
  aflength <- c(aflength,20,10)
  afedge <- c(afedge,circRNA_node,miRNA_node,miRNA_node,mRNA_node)
  
}
g <- g %>% add_edges(afedge) %>% set_edge_attr("edge.length", value = aflength)

# 添加节点大小
circRNA.size=as.vector(scale(as.vector(table(network_data$circRNA)),center = F))+15
miRNA.size=as.vector(scale(as.vector(table(network_data$miRNA)),center = F))+8
mRNA.size=as.vector(scale(as.vector(table(network_data$mRNA)),center = F))+3
V(g)$size=c(circRNA.size,miRNA.size,mRNA.size)
#igraph包中提供了多种布局算法，可以帮助我们将节点和边布局在平面上。以下是一些常见的布局算法：
#layout.circle：在圆形上均匀分布所有节点。
#layout.fruchterman.reingold：使用Fruchterman-Reingold算法，根据节点之间的力学模型，计算节点的位置。该算法可以确保相邻节点之间的距离尽量相等，并且可以避免节点之间的重叠。
#layout.graphopt：使用Graphopt算法，通过将节点移动到合适的位置以最小化边的长度来优化图的布局。
#layout.kamada.kawai：使用Kamada-Kawai算法，通过最小化图的能量来计算节点的位置。该算法可以确保相邻节点之间的距离尽量相等，并且可以保持图形的对称性。
#layout.lgl：使用Large Graph Layout算法，对于大型图形而言，布局更加高效。
# 使用Graphopt算进行布局
pdf(file="ceRNA.net.pdf",height=10,width=10)
plot(g, 
     layout=layout.graphopt(g),  
     vertex.label=V(g)$name,
     vertex.label.family="sans",
     vertex.label.cex=ifelse(V(g)$type == "circRNA", 0.8, ifelse(V(g)$type == "miRNA", 0.5, 0.2)),
     vertex.size=V(g)$size, 
     vertex.color=V(g)$color,
     vertex.label.color="black", 
     edge.arrow.size=0.5, 
     edge.width=1
     )
dev.off()