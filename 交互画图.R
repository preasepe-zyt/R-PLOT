library(ggplot2)
library(ggpubr)
ggplot() +
  geom_boxplot(anova, mapping = aes(x=心理资本, y=选课态度,color=心理资本),varwidth = TRUE, alpha=0.2)+
  theme_classic()+
  ylim(0,50)+
  scale_color_manual(values=c("#35A585","#006FB0"))+
  theme(
    #legend.position = c(.95, .95),#plot内位置
    legend.justification = c("right", "top"),#固定右上角
    #legend.background = element_blank(),#图例背景色
    #legend.key = element_blank(),#图标背景色element_rect(colour="black")
    #legend.box.background = element_rect(fill=NA,color = "black",linetype = 1) #图例外框和背景色默认填充白色（删除fill=NA）
    #legend.box.just = "right",
    #legend.margin = margin(6, 6, 6, 6)#边框大小调整
  )+
  labs(x = "")-> a
ggboxplot(anova, "心理资本", "选课态度", color = "心理资本")
a
ggplot() +
  geom_boxplot(anova, mapping = aes(x=说服信息, y=选课态度,color=说服信息),varwidth = TRUE, alpha=0.2,na.rm=TRUE)+
  ylim(0,50)+
  theme_classic()+
  scale_color_manual(values=c("#9DCD82","#F8B62D"))+
  theme(
    #legend.position = c(.95, .95),#plot内位置
    legend.justification = c("right", "top"),#固定右上角
    #legend.background = element_blank(),#图例背景色
    #legend.key = element_blank(),#图标背景色element_rect(colour="black")
    #legend.box.background = element_rect(fill=NA,color = "black",linetype = 1) #图例外框和背景色默认填充白色（删除fill=NA）
    #legend.box.just = "right",
    #legend.margin = margin(6, 6, 6, 6)#边框大小调整
  )+
  labs(x = "")-> b
b
ggplot() +
  geom_boxplot(anova, mapping = aes(x=课程难度, y=选课态度,color=课程难度),varwidth = TRUE, alpha=0.2,na.rm=TRUE)+
  ylim(0,50)+
  theme_classic()+
  scale_color_manual(values=c("#CE97B0","#F4A9A8"))+
  theme(
    #legend.position = c(.95, .95),#plot内位置
    legend.justification = c("right", "top"),#固定右上角
    #legend.background = element_blank(),#图例背景色
    #legend.key = element_blank(),#图标背景色element_rect(colour="black")
    #legend.box.background = element_rect(fill=NA,color = "black",linetype = 1) #图例外框和背景色默认填充白色（删除fill=NA）
    #legend.box.just = "right",
    #legend.margin = margin(6, 6, 6, 6)#边框大小调整
  )+
  labs(x = "")-> c
c
library(aplot)
library(patchwork)
a / b / c -> f
f
pdf( "plotname2.pdf",family="GB1")
dev.off()
pdf( "Meta-forest-CHN.pdf",family="GB1",height = 6,width = 12)
#https://mp.weixin.qq.com/s/6asrV2R1jU-3HNdJ788RUw
anova %>% 
  ggplot() +
  aes(x = 心理资本, y = 选课态度,group=说服信息,color=说服信息) +
  stat_summary(fun.y = mean, geom = "point",size=3) +
  stat_summary(fun.y = mean, geom = "line",size=1)+
  theme_classic()+
  ylim(0,40)+
  theme(
    text = element_text(family = 'SimSun'),
    #legend.position = c(.95, .95),#plot内位置
    legend.justification = c("right", "top"),#固定右上角
    #legend.background = element_blank(),#图例背景色
    #legend.key = element_blank(),#图标背景色element_rect(colour="black")
    #legend.box.background = element_rect(fill=NA,color = "black",linetype = 1) #图例外框和背景色默认填充白色（删除fill=NA）
    #legend.box.just = "right",
    #legend.margin = margin(6, 6, 6, 6)#边框大小调整
  )+
  labs(x = "") -> in1
in1
anova %>% 
  ggplot() +
  aes(x = 课程难度, y = 选课态度,group=说服信息,color=说服信息) +
  stat_summary(fun.y = mean, geom = "point",size=3) +
  stat_summary(fun.y = mean, geom = "line",size=1)+
  theme_classic()+
  ylim(0,50)+
  theme(
    #legend.position = c(.95, .95),#plot内位置
    legend.justification = c("right", "top"),#固定右上角
    #legend.background = element_blank(),#图例背景色
    #legend.key = element_blank(),#图标背景色element_rect(colour="black")
    #legend.box.background = element_rect(fill=NA,color = "black",linetype = 1) #图例外框和背景色默认填充白色（删除fill=NA）
    #legend.box.just = "right",
    #legend.margin = margin(6, 6, 6, 6)#边框大小调整
  )+
  labs(x = "") -> in2
in2
anova %>% 
  ggplot() +
  aes(x = 心理资本, y = 选课态度,group=课程难度,color=课程难度) +
  stat_summary(fun.y = mean, geom = "point",size=3) +
  stat_summary(fun.y = mean, geom = "line",size=1)+
  theme_classic()+
  ylim(0,40)+
  theme(
    #legend.position = c(.95, .95),#plot内位置
    legend.justification = c("right", "top"),#固定右上角
    #legend.background = element_blank(),#图例背景色
    #legend.key = element_blank(),#图标背景色element_rect(colour="black")
    #legend.box.background = element_rect(fill=NA,color = "black",linetype = 1) #图例外框和背景色默认填充白色（删除fill=NA）
    #legend.box.just = "right",
    #legend.margin = margin(6, 6, 6, 6)#边框大小调整
  )+
  labs(x = "")-> in3
in3
in1 | in2 | in3
