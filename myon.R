

for (i in 1:6){
  Q1 <- quantile(a[[i]], .25)
  Q3 <- quantile(a[[i]], .75)
  fi<- subset(a[[i]], a[[i]] < Q1| a[[i]] > Q3)
  c[[i]] <- list(fi)
  }
fi(3)
c <- data.frame()
data_no_outlier <- NULL
