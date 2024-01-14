apply(totaldistance,2,mean,na.rm=TRUE) -> dis
apply(speed,2,mean,na.rm=TRUE) -> sp
rbind(sp,dis) -> f1
