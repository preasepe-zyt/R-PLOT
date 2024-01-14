library(ggraph)
library(igraph)
library(tidyverse)
library(RColorBrewer) 
set.seed(1)

d11=data.frame(from="origin", to=paste("group", seq(1,10), sep=""))
d21=data.frame(from=sort(sample(rep(d11$to, each=100),100,replace=FALSE)), 
               to=sample(paste("subgroup", seq(1,100), sep="_"),100,replace=FALSE))
edges<-rbind(d11[,1:2], d21[,1:2])

vertices_name<-unique(c(as.character(edges$from), as.character(edges$to)))
vertices<-data.frame(name = vertices_name, value =runif(length(vertices_name)))
rownames(vertices)<-vertices_name

d2<-d21 %>% 
  mutate(order2=as.numeric(factor(from,
                                  levels=unique(from)[sort(summary (as.factor(from)),index.return=TRUE,decreasing = T)$ix],
                                  order=TRUE)))%>% 
  arrange(order2)

d2<-d2%>% 
  left_join(vertices ,by = c("to" = "name")) %>% 
  arrange(order2,desc(value))

edges<-rbind(d11[,1:2], d2[,1:2])

list_unique<-unique(c(as.character(edges$from), as.character(edges$to)))
vertices = data.frame(
  name = list_unique, 
  value = vertices[list_unique,'value']
) 

vertices$group<-edges$from[match(vertices$name, edges$to)]
vertices$id<-NA
myleaves<-which(is.na( match(vertices$name, edges$from) ))
nleaves<-length(myleaves)
vertices$id<-nleaves/360*90
vertices$id[ myleaves]<-seq(1:nleaves)
vertices$angle<-90 - 360 * vertices$id / nleaves
vertices$angle<-ifelse(vertices$angle < -90, vertices$angle+180, vertices$angle)


mygraph <- graph_from_data_frame( edges, vertices = vertices, directed = TRUE )

ggraph(mygraph, layout = 'dendrogram', circular = TRUE) + 
  geom_edge_diagonal() +
  scale_edge_colour_distiller(palette = "RdPu") +
  geom_node_text(aes(x = x*1.25, y=y*1.25,  angle = angle,  label=name),
                 size=3, alpha=1) +
  geom_node_point(aes( x = x, y=y, fill=group), 
                  shape=21,stroke=0.1,alpha=0.2, size=20) +
  scale_colour_manual(values= rep( brewer.pal(9,"Paired") , 30)) +
  scale_fill_manual(values= rep( brewer.pal(9,"Paired") , 30)) +
  scale_size_continuous( range = c(0.1,7) ) +
  expand_limits(x = c(-1.3, 1.3), y = c(-1.3, 1.3))+
  theme_void() +
  theme(
    legend.position="none",
    plot.margin=unit(c(0,0,0,0),"cm")
  )
