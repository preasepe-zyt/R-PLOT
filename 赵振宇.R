
zhenyu3 <- read_excel("C:/Users/79403/Desktop/zhenyu3.xlsx")
zhenyu3[,-1] -> c
unlist(c) %>% as.data.frame() -> c
cbind(c,a[,2:3]) -> c
edit(c) -> c
ggarrange(f1,f2,f3,labels = c("A","B","C"),common.legend=TRUE,legend = "top",nrow = 1)

help("ggarrange")
