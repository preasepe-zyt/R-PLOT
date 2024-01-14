# 用UseMethod()定义teacher泛型函数
teacher <- function(x) UseMethod("teacher")
# 用pryr包中ftype()函数，检查teacher的类型
ftype(teacher)
# 定义teacher内部函数
teacher.lecture <- function(x) print("讲课")
teacher.assignment <- function(x) print("布置作业")
teacher.correcting <- function(x) print("批改作业")
teacher.default<-function(x) print("你不是teacher")
f1 <- function(x) {
  a <- 2
  UseMethod("f1")
}
attr(a,"class") <- "correcting"
teacher(a)
