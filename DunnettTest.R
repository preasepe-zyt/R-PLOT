library(DescTools)
x <- c(2.9, 3.0, 2.5, 2.6, 3.2) # normal subjects
y <- c(3.8, 2.7, 4.0, 2.4)      # with obstructive airway disease
z <- c(2.8, 3.4, 3.7, 2.2, 2.0) # with asbestosis

DunnettTest(list(x, y, z))

## Equivalently,
x <- c(x, y, z)
g <- factor(rep(1:37,1),
            labels = c(colnames(d)))

DunnettTest(d, g,na.action)
data_paired<- c[,1]-c[,2]
my_t.test<-function(x){
  A<-try(t.test(x), silent=TRUE)
  if (is(A, "try-error")) return(NA) else return(A$p.value)
}

#  Use aggregate with new t-test.  
aggregate(my_t.test, by=list(c$...3),FUN=my_t.test)


my_t.test2<-function(x,y){
  A <- try(t.test(x,y,paired=FALSE), silent=TRUE)
  if (is(A, "try-error")) return(NA) else return(A$p.value)
}
aggregate(c[,c(1,2)], by=list(c$...3),function(x,y)my_t.test2(c[,2],c[,1]))


t.test(PTZ)