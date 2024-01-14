library(ggplot2)
library(grafify)
library(tidyverse)
lib
ggplot(a, mapping = aes(x=group, y=b,shape=group2,group=group2,linetype=group2)) +
  geom_point(size=3)+
  theme_classic()+
  geom_line(size=0.8)+
  labs(x = "负性生活事件", y = "基本心理需求",shape="无聊倾向性",linetype="无聊倾向性",family="SimSun",size=5)+
  theme(axis.text.x =element_text(size=11,
                                  family = "SimSun",
                                  face = "bold",
                                  color = "black"))-> f1
f1
ggplot(b, mapping = aes(x=group, y=b,shape=group2,group=group2,linetype=group2)) +
  geom_point(size=3)+
  theme_classic()+
  geom_line(size=0.8)+
  labs(x = "负性生活事件", y = "焦虑",shape="无聊倾向性",linetype="无聊倾向性",family="SimSun",size=5)+
  ylim(0,10)+
  theme(axis.text.x =element_text(size=11,
                                  family = "SimSun",
                                  face = "bold",
                                  color = "black"))-> f2
f2
ggplot(c, mapping = aes(x=group, y=b,shape=group2,group=group2,linetype=group2)) +
  geom_point(size=3)+
  theme_classic()+
  geom_line(size=0.8)+
  labs(x = "负性生活事件", y = "网络游戏成瘾",shape="无聊倾向性",linetype="无聊倾向性",family="SimSun",size=5)+
  ylim(0,10)+
  theme(axis.text.x =element_text(size=11,
                                  family = "SimSun",
                                  face = "bold",
                                  color = "black"))-> f3
f3

b %>%
  group_by(group, group2) %>%
  plot_befafter_colors(group,b, group2)
