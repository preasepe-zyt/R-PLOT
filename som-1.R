#### generate some RGB data ####

## select the number of random RGB vectors for training data

sample.size <- 10000

## generate dataframe of random RGB vectors

sample.rgb <- as.data.frame(matrix(nrow = sample.size, ncol = 3))
colnames(sample.rgb) <- c('R', 'G', 'B')

sample.rgb$R <- sample(0:255, sample.size, replace = T)
sample.rgb$G <- sample(0:255, sample.size, replace = T)
sample.rgb$B <- sample(0:255, sample.size, replace = T)
#### train the SOM ####

## define a grid for the SOM and train

library(kohonen)

grid.size <- ceiling(sample.size ^ (1/2.5))
som.grid <- somgrid(xdim = grid.size, ydim = grid.size, topo = 'hexagonal', toroidal = T)
som.model <- som(data.matrix(sample.rgb), grid = som.grid)
## extract some data to make it easier to use

som.events <- som.model$codes[[1]]
som.events.colors <- rgb(som.events[,1], som.events[,2], som.events[,3], maxColorValue = 255)
som.dist <- as.matrix(dist(som.events))
## generate a plot of the untrained data.  this isn't really the configuration at first iteration, but
## serves as an example

plot(som.model,
     type = 'mapping',
     bg = som.events.colors[sample.int(length(som.events.colors), size = length(som.events.colors))],
     keepMargins = F,
     col = NA,
     main = '')
## generate a plot after training.

plot(som.model,
     type = 'mapping',
     bg = som.events.colors,
     keepMargins = F,
     col = NA,
     main = '')
#### look for a reasonable number of clusters ####

## Evaluate within cluster distances for different values of k.  This is
## more dependent on the number of map units in the SOM than the structure
## of the underlying data, but until we have a better way...

## Define a function to calculate mean distance within each cluster.  This
## is roughly analogous to the within clusters ss approach

clusterMeanDist <- function(clusters){
  cluster.means = c()
  
for(c in unique(clusters)){
    temp.members <- which(clusters == c)
    
    if(length(temp.members) > 1){
      temp.dist <- som.dist[temp.members,]
      temp.dist <- temp.dist[,temp.members]
      cluster.means <- append(cluster.means, mean(temp.dist))
    }else(cluster.means <- 0)
  }
  
  return(mean(cluster.means))
  
}

try.k <- 2:100
cluster.dist.eval <- as.data.frame(matrix(ncol = 3, nrow = (length(try.k))))
colnames(cluster.dist.eval) <- c('k', 'kmeans', 'hclust')

for(i in 1:length(try.k)) {
  cluster.dist.eval[i, 'k'] <- try.k[i]
  cluster.dist.eval[i, 'kmeans'] <- clusterMeanDist(kmeans(som.events, centers = try.k[i], iter.max = 20)$cluster)
  cluster.dist.eval[i, 'hclust'] <- clusterMeanDist(cutree(hclust(vegdist(som.events)), k = try.k[i]))
}

plot(cluster.dist.eval[, 'kmeans'] ~ try.k,
     type = 'l')

lines(cluster.dist.eval[, 'hclust'] ~ try.k,
      col = 'red')

legend('topright',
       legend = c('k-means', 'hierarchical'),
       col = c('black', 'red'),
       lty = c(1, 1))

#### evaluate clustering algorithms ####

## Having selected a reasonable value for k, evaluate different clustering algorithms.

library(pmclust)

## Define a function for make a simple plot of clustering output.
## This is the same as previousl plotting, but we define the function
## here as we wanted to play with the color earlier.

plotSOM <- function(clusters){
  plot(som.model,
       type = 'mapping',
       bg = som.events.colors,
       keepMargins = F,
       col = NA)
  
  add.cluster.boundaries(som.model, clusters)
}

## Try several different clustering algorithms, and, if desired, different values for k

cluster.tries <- list()

for(k in c(20)){
  
  ## model based clustering using pmclust
  
  som.cluster.pm.em <- pmclust(som.events, K = k, algorithm = 'em')$class # model based
  som.cluster.pm.aecm <- pmclust(som.events, K = k, algorithm = 'aecm')$class # model based
  som.cluster.pm.apecm <- pmclust(som.events, K = k, algorithm = 'apecm')$class # model based
  som.cluster.pm.apecma <- pmclust(som.events, K = k, algorithm = 'apecma')$class # model based
  som.cluster.pm.kmeans <- pmclust(som.events, K = k, algorithm = 'kmeans')$class # model based
  
  ## k-means clustering
  
  som.cluster.k <- kmeans(som.events, centers = k, iter.max = 100, nstart = 10)$cluster # k-means
  
  ## hierarchical clustering
  
  som.dist <- dist(som.events) # hierarchical, step 1
  som.cluster.h <- cutree(hclust(som.dist), k = k) # hierarchical, step 2
  
  ## capture outputs
  
  cluster.tries[[paste0('som.cluster.pm.em.', k)]] <- som.cluster.pm.em
  cluster.tries[[paste0('som.cluster.pm.aecm.', k)]] <- som.cluster.pm.aecm
  cluster.tries[[paste0('som.cluster.pm.apecm.', k)]] <- som.cluster.pm.apecm
  cluster.tries[[paste0('som.cluster.pm.apecma.', k)]] <- som.cluster.pm.apecma
  cluster.tries[[paste0('som.cluster.pm.kmeans.', k)]] <- som.cluster.pm.kmeans
  cluster.tries[[paste0('som.cluster.k.', k)]] <- som.cluster.k
  cluster.tries[[paste0('som.cluster.h.', k)]] <- som.cluster.h
}

## Take a look at the various clusters.  You're looking for the algorithm that produces the
## least fragmented clusters.

plotSOM(cluster.tries$som.cluster.pm.em.20)
plotSOM(cluster.tries$som.cluster.pm.aecm.20)
plotSOM(cluster.tries$som.cluster.pm.apecm.20)
plotSOM(cluster.tries$som.cluster.pm.apecma.20)
plotSOM(cluster.tries$som.cluster.k.20)
plotSOM(cluster.tries$som.cluster.h.20)

## The SOM and map unit clustering represent a classification model.  These can be saved for
## later use.

som.cluster <- som.cluster.k
som.notes <- c('Clustering based on k-means')

save(file = 'som_model_demo.Rdata', list = c('som.cluster', 'som.notes', 'som.model', 'som.events.colors'))

#### classification ####

## make a new dataset to classify ##

new.data.size <- 20
new.data <- as.data.frame(matrix(nrow = new.data.size, ncol = 3))
colnames(new.data) <- c('R', 'G', 'B')

new.data$R <- sample(0:255, new.data.size, replace = T)
new.data$G <- sample(0:255, new.data.size, replace = T)
new.data$B <- sample(0:255, new.data.size, replace = T)

## get the closest map unit to each point

new.data.units <- map(som.model, newdata = data.matrix(new.data))

## get the classification for closest map units

new.data.classes <- som.cluster[new.data.units$unit.classif]

## compare colors of the new data, unit, and class, first define a function
## to calculate the mean colors for each cluster

clusterMeanColor <- function(clusters){
  cluster.means = c()
  som.codes <- som.model$codes[[1]]
  
  for(c in sort(unique(clusters))){
    temp.members <- which(clusters == c)
    
    if(length(temp.members) > 1){
      temp.codes <- som.codes[temp.members,]
      temp.means <- colMeans(temp.codes)
      temp.col <- rgb(temp.means[1], temp.means[2], temp.means[3], maxColorValue = 255)
      cluster.means <- append(cluster.means, temp.col)
    }else({
      temp.codes <- som.codes[temp.members,]
      temp.col <- rgb(temp.codes[1], temp.codes[2], temp.codes[3], maxColorValue = 255)
      cluster.means <- append(cluster.means, temp.col)
    })
  }
  
return(cluster.means)
  
}

class.colors <- clusterMeanColor(som.cluster)

plot(1:length(new.data$R), rep(1, length(new.data$R)),
     col = rgb(new.data$R, new.data$G, new.data$B, maxColorValue = 255),
     ylim = c(0,4),
     pch = 19,
     cex = 3,
     xlab = 'New data',
     yaxt = 'n',
     ylab = 'Level')

axis(2, at = c(1, 2, 3), labels = c('New data', 'Unit', 'Class'))


points(1:length(new.data.units$unit.classif), rep(2, length(new.data.units$unit.classif)),
       col = som.events.colors[new.data.units$unit.classif],
       pch = 19,
       cex = 3)

points(1:length(new.data.classes), rep(3, length(new.data.classes)),
       col = class.colors[new.data.classes],
       pch = 19,
       cex = 3)
