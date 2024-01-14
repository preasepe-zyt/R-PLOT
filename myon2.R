a<-matrix(1:12,nrow=3) 
list_mean<- apply(a,2,mean)        #按列求均值
list_sd<-apply(a,2,sd)            #按列求标准差
max<-list_mean+3*(list_sd)         #按列求最大值
min<-list_mean-3*list_sd           #按列求最小值
apply(a,2,mean,na.rm=TRUE)->mean 
fd <- function(i){c<- subset(a[[i]], a[[i]] < mean[[i]] - 2.58*list_sd[[i]])
}
#| a[[i]] > (mean[[i]] + 3*list_sd[[i]]))}

for (i in 1:6){
  fi[[i]]
}
c <- data.frame()
