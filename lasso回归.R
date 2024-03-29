library(Ipaper) ##画图的包
library(glmnet) ## 建模的包
x_all <- subset(diff_irg_clinical, select = -c(OS, OS.time)) 
x_all <- x_all[,rownames(res_results_0.05)]
y_all <- subset(diff_irg_clinical, select = c(OS, OS.time))
cvfit = cv.glmnet(as.matrix(x_all),
                  Surv(y_all$OS.time,y_all$OS),nfold=10,
                  #默认10折交叉验证
                  family = "cox") 
png(filename = "lasso1.png", height = 450, width = 600)
plot(cvfit, las =1)
dev.off()
pdf(file = "lasso1.pdf", height = 5)
plot(cvfit, las =1)
dev.off()

fit <- glmnet(as.matrix(x_all), Surv(y_all$OS.time,y_all$OS), 
              family = "cox") 

png(filename = "lasso2.png", height = 450, width = 600)
plot(fit, xvar = "lambda",label = TRUE, las=1)
dev.off()
pdf(file = "lasso2.pdf", height = 5)
plot(fit, xvar = "lambda",label = TRUE, las=1)
dev.off()

coef.min = coef(cvfit, s = "lambda.min")  ## lambda.min & lambda.1se 取一个

active.min = which(coef.min@i != 0) ## 找出那些回归系数没有被惩罚为0的

lasso_geneids <- coef.min@Dimnames[[1]][coef.min@i+1] ## 提取基因名称

write(lasso_geneids, "lasso_genes.csv")

write.csv(x_all,file = "Lasso_x.csv",quote = F)
write.csv(y_all,file = "Lasso_y.csv",quote = F)