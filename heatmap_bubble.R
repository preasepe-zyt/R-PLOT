name1 <- c(rep("CTL",3),rep("MPTP",3),rep("25ug/ml",3),rep("50ug/ml",3),rep("100ug/ml",3))
hm$组别 <- name1
rownames(hm) <- name1
hm[,-1] -> hm
t(hm) -> hm
new <- data.frame()
as.data.frame(hm) -> hm
for (i in 5) {if(i%%3==0) fabp3 <- sum(as.numeric(hm$fabp3[i:i*3]))}