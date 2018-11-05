library(datasets)
library(cluster)

ptm <- proc.time()

data("iris")
d <- dist(iris[,1:4], method = "manhattan") # distance matrix
fit <- hclust(d, method="average") 
plot(fit) # display dendogram
groups <- cutree(fit, k=2) # cut tree into 3 clusters

proc.time() - ptm

# draw dendogram with red borders around the 5 clusters 
rect.hclust(fit, k=3, border="red")
