library(kohonen)
library(tidyverse)

ads <- read.csv("data_input/KAG_conversion_data.csv") %>% 
  glimpse()
ads <- counts %>% 
  glimpse()
ads <- ads %>% 
  mutate(ad_id = as.factor(ad_id),
         xyz_campaign_id = as.factor(xyz_campaign_id),
         fb_campaign_id = as.factor(fb_campaign_id)) %>% 
  glimpse()
levels(ads$xyz_campaign_id)
# change the chategoric variables to a dummy variables
ads.s <- ads %>% 
  mutate(genderM = ifelse(gender == "M", 1, 0),
         age2 = ifelse(age == "35-39", 1, 0),
         age3 = ifelse(age == "40-44", 1, 0),
         age4 = ifelse(age == "45-49", 1, 0)) %>% 
  select(-c(1,3:5))

# make a train data sets that scaled and convert them to be a matrix cause kohonen function accept numeric matrix
ads.train <- as.matrix(scale(ads[,c(1:10)]))
# make a SOM grid
set.seed(100)
ads.grid <- somgrid(xdim = 10, ydim = 10, topo = "hexagonal")

# make a SOM model
set.seed(100)
ads.model <- som(ads.train, ads.grid, rlen = 500, radius = 2.5, keep.data = TRUE,
                 dist.fcts = "euclidean")
# str(ads.model)
ads.model$unit.classif
plot(ads.model, type = "mapping", pchs = 19, shape = "round")
head(data.frame(ads.train), 20)
plot(ads.model, type = "codes", main = "Codes Plot", palette.name = rainbow)
plot(ads.model, type = "changes")


#Supervised SOM
#In supervised SOM, we want to classify our SOM model with our dependent variable (xyz_campaign_id).
# split data
set.seed(100)
int <- sample(nrow(ads.s), nrow(ads.s)*0.8)
train <- ads.s[int,]
test <- ads.s[-int,]

# scaling data
trainX <- scale(train[,-1])
testX <- scale(test[,-1], center = attr(trainX, "scaled:center"))


# make label
train.label <- factor(train[,1])
test.label <- factor(test[,1])
test[,1] <- 916
testXY <- list(independent = testX, dependent = test.label)

# classification & predict
set.seed(100)
class <- xyf(trainX, classvec2classmat(train.label), ads.grid, rlen = 500)
plot(class, type = "changes")
pred <- predict(class, newdata = testXY)
table(Predict = pred$predictions[[2]], Actual = test.label)

#Cluster Boundaries
plot(ads.model, type = "codes", bgcol = rainbow(9)[clust$cluster], main = "Cluster SOM")
add.cluster.boundaries(ads.model, clust$cluster)


c.class <- kmeans(class$codes[[2]], 3)
par(mfrow = c(1,2))
plot(class, type = "codes", main = c("Unsupervised SOM", "Supervised SOM"), 
     bgcol = rainbow(3)[c.class$cluster])
add.cluster.boundaries(class, c.class$cluster)

