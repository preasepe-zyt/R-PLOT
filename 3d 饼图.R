library(plotrix)
pie3D(X111$ocu,labels=X111$name,shade=0.5,col=c("#9DCD82","#F8B62D","#F2997A","#CE97B0","#F4A9A8","#CE97B0","#F4A9A8"))
par(xpd=TRUE)
legend(0.1,-0.7,legend=X111$name,cex=0.7,yjust=1.1, xjust = 0.1,
       fill = heat.colors(length(X111$ocu)))  
pie(X111$ocu,labels=X111$name,min="111")

