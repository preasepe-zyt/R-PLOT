library(dplyr)
library(readxl)
library(xlsx)
X2 <- read_excel("C:/Users/79403/Desktop/2.xlsx")
X3 <- read_excel("C:/Users/79403/Desktop/3.xlsx")
X4 <- read_excel("C:/Users/79403/Desktop/4.xlsx")
select(X2,-c(animal,algostatus,locationcode,samplecode)) -> b2
select(X3,-c(animal,algostatus,locationcode,samplecode)) -> b3
select(X4,-c(animal,algostatus,locationcode,samplecode)) -> b4
na.omit(b2) -> c2
na.omit(b3) -> c3
na.omit(b4) -> c4
write.xlsx(c2,"C:/Users/79403/Desktop/second.xlsx",sheetName = "Sheet1",col.names = TRUE,row.names = TRUE,append = FALSE,showNA = TRUE,password = NULL)
write.xlsx(c3,"C:/Users/79403/Desktop/third.xlsx",sheetName = "Sheet1",col.names = TRUE,row.names = TRUE,append = FALSE,showNA = TRUE,password = NULL)
write.xlsx(c4,"C:/Users/79403/Desktop/fourth.xlsx",sheetName = "Sheet1",col.names = TRUE,row.names = TRUE,append = FALSE,showNA = TRUE,password = NULL)