#初筛
library(ggplot2)
library()
readxl::read_excel("初筛.xlsx") -> a
abs(a$227.6)->mean1
dplyr::select(a,c("PTZ vs. VPA", "227.6","Yes","**" )) -> al
colnames(al) <- c("group","mean","sig","ns")
abs(al$mean) -> al$mean
library(ggplot2)
#制作旋转标记-----------
label_data <- al
number_of_bar=nrow(label_data)
angle <-  90 - 360 * (label_data$id - 0.5) /number_of_bar     # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
label_data$hjust<-ifelse( angle < -90, 1, 0)
label_data$angle<-ifelse(angle < -90, 
                         angle+180, angle)
#----------------------------------加入空值

to_add <- matrix(NA, empty_bar, ncol(al))
colnames(to_add) <- colnames(al)
al <- rbind(al, to_add)
al$id <- seq(1, nrow(al))



#-------------------
ggplot()+
  geom_bar(data=al,mapping=aes(x=id,y=mean,fill=sig),inherit.aes=FALSE, stat="identity", alpha=0.5)+
  coord_polar()+
  theme(panel.grid = element_blank(), 
        panel.background = element_blank(),
        axis.ticks = element_blank(), 
        axis.text = element_blank(), 
        axis.title = element_blank(),
        legend.position =  c(0.5, 0.5),
        legend.key.size = unit(5, 'mm')
        )+
  geom_text(data = label_data,
            aes(x = id, y = 750,
                label = group, hjust=hjust),
            color = "black", fontface="bold",
            alpha = 0.6, size = 3,
            angle = label_data$angle,
            inherit.aes = FALSE)+
  ylim(-200,900)+
  annotate("text", x = rep(50,7), y = c(100, 200, 300, 400,500,600,700), label = c("100", "200", "300", "400", "500", "600", "700") , color="black", size=3 , angle= 30, fontface="bold",hjust= 1.5,vjust=3)

  
  #geom_text(data=label_data, aes(x=group, y=5, label=group, hjust=hjust), color="black", fontface="bold",alpha=0.6, size=2.5, angle= label_data$angle, inherit.aes = FALSE ) 
