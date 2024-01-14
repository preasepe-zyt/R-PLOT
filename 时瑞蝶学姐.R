library(tidyverse)
a <- read_excel("C:/Users/79403/Desktop/R/R-script/利血平造模.xlsx")
ctl <- read_excel("C:/Users/79403/Desktop/R/R-script/ctl.xlsx")
X7_ug <- read_excel("C:/Users/79403/Desktop/R/R-script/7-ug.xlsx")
X14_ug <- read_excel("C:/Users/79403/Desktop/R/R-script/14-ug.xlsx")
X28_ug <- read_excel("C:/Users/79403/Desktop/R/R-script/28-ug.xlsx")
X28_ug_alone <- read_excel("C:/Users/79403/Desktop/R/R-script/28-ug-alone.xlsx")apply(a,2,mean,na.rm=T) -> a1
ctl[-c(1585:1658),] -> ctl
mutate(a,time) -> a
mutate(ctl,time) -> ctl
mutate(X7_ug,time) -> X7_ug
mutate(X14_ug,time) -> X14_ug
mutate(X28_ug,time) -> X28_ug
mutate(X28_ug_alone,time) -> X28_ug_alone

mutate(a,sum=(a$inner_totaldistance+a$outer_totaldistance)) -> a
mutate(ctl,sum=(ctl$inner_totaldistance+ctl$outer_totaldistance)) -> ctl
mutate(X7_ug,sum=(X7_ug$inner_totaldistance+X7_ug$outer_total_distancce)) -> X7_ug
mutate(X14_ug,sum=(X14_ug$inner_totaldistance+X14_ug$outer_totaldisance)) -> X14_ug
mutate(X28_ug,sum=(X28_ug$inner_totaldistance+X28_ug$outer_totaldistance)) -> X28_ug
mutate(X28_ug_alone,sum=(X28_ug_alone$inner_totaldistance+X28_ug_alone$outer_totaldistance)) -> X28_ug_alone
mutate(all1,mean=(all1$inner_totaldistance+all1$outer_totaldistance)/time) -> all1
mutate(all1, mean.bursting=(all1$sum/all1$time)) -> all1
mutate(all1 , max=(all1$mean+20)) -> all1
mutate(all1 , min=(all1$mean-10)) -> all1
mutate(all1, all1, max.bursting=(all1$max/all1$time)) -> all1
mutate(all1, all1, mim.bursting=(all1$min/all1$time)) -> all1
edit(sum)
sum(a)


apply(a,2,mean,na.rm=T) -> a1
apply(ctl,2,mean,na.rm=T) -> b1
apply(X7_ug,2,mean,na.rm=T) -> c1
apply(X14_ug,2,mean,na.rm=T) -> d1
apply(X28_ug,2,mean,na.rm=T) -> e1
apply(X28_ug_alone,2,mean,na.rm=T) -> f1
data.frame(a1,b1,c1,d1,e1,f1) -> all1
colnames(all1) <-c("利血平造模","Ctl","7_ug","14_ug","28_ug","28_ug_alone")
t(all1) -> all1
as.data.frame(all1) -> all1
all3 <-  all1[,apply(all1, 2, function(x) sd(x)!=0)] 
