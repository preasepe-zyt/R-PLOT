LASSO回归，全称：least absolute shrinkage and selection operator（最小绝对值收敛和选择算子算法），是一种压缩估计。在拟合广义线性模型的同时进行（variable selection）和（regularization），以提高所得统计模型的预测准确性和可解释性
LASSO回归复杂度调整的程度由参数 λ 来控制，λ 越大对变量较多的线性模型的惩罚力度就越大，从而最终获得一个变量较少的模型。 LASSO回归与同属于一个被称为 的广义线性模型家族。 这一家族的模型除了相同作用的参数 λ之外，还有另一个参数 α来控制应对高相关性(highly correlated)数据时模型的性状。 LASSO回归 α=1，Ridge回归 α=0，一般Elastic Net模型 0<α<1
# install.packages("glmnet")
library(glmnet)

## 定义响应变量
y <- mtcars$hp

## 定义预测变量矩阵
x <- data.matrix(mtcars[, c('mpg', 'wt', 'drat', 'qsec')])
#：拟合 Lasso 回归模型

library(glmnet)

# 执行k折交叉验证(https://www.statology.org/k-fold-cross-validation/)并确定产生最低测试均方误差 (MSE) 的 lambda 值
cv_model <- cv.glmnet(x, y, alpha = 1)  

# 找寻最小化测试 MSE 的最佳 lambda 值
best_lambda <- cv_model$lambda.min #l
best_lambda
## [1] 2.215202

# produce plot of test MSE by lambda value
plot(cv_model) 
glmnet-1

★ 图中有两条虚线，左边为的线，右边为的线。
★ ambda.min是指在所有的λ值中，得到最小目标参量均值的那一个；
lambda.1se是指在 lambda.min一个方差范围内得到最简单模型的那一个λ值；
λ值到达一定大小之后，继续增加模型自变量个数即缩小λ值，并不能很显著的提高模型性能， lambda.1se 给出的就是一个具备优良性能但是自变量个数最少的模型
：分析最终模型

# 找寻最佳模型系数
best_model <- glmnet(data, y, alpha = 1 , lambda = best_lambda) 
coef(best_model) 
## 5 x 1 sparse Matrix of class "dgCMatrix"
##                     s0
## (Intercept) 486.013958
## mpg          -2.916499
## wt           21.989615
## drat          .       
## qsec        -19.692037

print(best_model)
## Call:  glmnet(x = x, y = y, alpha = 1, lambda = best_lambda) 

##   Df  %Dev Lambda
## 1  3 80.47  2.215
glmnet()参数 family 规定了回归模型的类型：
family = "gaussian" 适用于一维连续因变量（univariate）
family = "mgaussian" 适用于多维连续因变量（multivariate）
family = "poisson" 适用于非负次数因变量（count）
family = "binomial" 适用于二元离散因变量（binary）
family = "multinomial" 适用于多元离散因变量（category）

★ 没有显示预测变量 drat的系数，因为套索回归将系数一直缩小到零。这意味着它完全从模型中，因为它的影响力不够。
。