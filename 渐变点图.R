library(ggplot2)
ggplot()+
  geom_point(f,mapping = aes(x= sd,y= mean,color=mean),inherit.aes = FALSE,size = f$mean/20)+
  xlim(-200,300)+
  geom_text(f,mapping =aes(x= sd-50,y= mean,label=group),size=3,color="black")+
  geom_text(aes(x = 50, y =200 ,label = " Ctl > DMSO > Rasagiline > 京尼平苷酸 > 丁香 > 松脂醇 > 橄榄脂素> 奎宁酸 > 杜仲醇 > MPTP"),size=3)+
  scale_colour_gradient2(low = "white", high = "#CC78A6")+
  geom_text(f,mapping =aes(x= sd+50,y= mean,label=group2),size=3,color="black")
  
#scale_color_gradientn(values = seq(0,1,0.2), colours = c('cyan','blue','green','orange','red','blue','green','orange','red'))
  #geom_text(fish,mapping =aes(x= sd-10,y= mean),size=3,color="black")
    #geom_boxplot(fish,mapping = aes(x,y= mean,color=group),inherit.aes = FALSE)
guides(fill = guide_legend( ncol = 1, byrow = TRUE))#图例作为一列+

#背景渐变色

library(RColorBrewer)
library(grid)
color <- colorRampPalette(brewer.pal(11,"RdBu"))(15)

grid.raster(scales::alpha(color, 0.3), 
            width = unit(1, "npc"), 
            height = unit(1,"npc"),
            interpolate = T)
