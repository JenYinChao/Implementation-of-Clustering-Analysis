library(datasets)
library(ggplot2)
data("iris")
set.seed(123)
groupNum = 3

# ------- Data Iris --------
#Self designed Algo
source("Hierarchical.R")
source("Nonhierarchical.R")
#Hier
ptm <- proc.time()
df_hier <- hier(iris, normalize = FALSE, groupNum)
proc.time() - ptm
#Non-hier
ptm <- proc.time()
df_nonhier <- non_hier(iris, groupNum, normalize = FALSE)
proc.time() - ptm

#Package
library(cluster)
#Hier
ptm <- proc.time()
d <- dist(iris[,1:4], method = "euclidean") # distance matrix
fit <- hclust(d, method="average")
groups <- as.factor(cutree(fit, k=groupNum)) # cut tree into 3 clusters
proc.time() - ptm
plot(fit)
rect.hclust(fit, k=groupNum, border="red")
#Non-hier
ptm <- proc.time()
iris.kmeans <- kmeans(iris[1:4],3)
proc.time() - ptm


#table
table(df_hier$Species, df_hier$Group)   #self hier
table(df_nonhier$Species,df_nonhier$group)    #self non-hier

table(iris$Species,groups)    #cluster package
table(iris$Species,iris.kmeans$cluster)    #kmeans package

#plot
X11()
ggplot(iris, aes(Sepal.Length, Petal.Length, color = Species, shape=Species)) + geom_point(size=4) + ggtitle("Iris species") +
  theme(plot.title=element_text(size=20,face="bold"),axis.title=element_text(size=18),legend.title=element_text(size=16),legend.text=element_text(size=16))
dev.copy(jpeg,'Iris species.jpg',width=800,height=700)
dev.off()

X11()
ggplot(df_hier, aes(Sepal.Length, Petal.Length, color = Group, shape=Group)) + geom_point(size=4) + ggtitle("Iris species with self-designed hier-clustering algo") +
  theme(plot.title=element_text(size=20,face="bold"),axis.title=element_text(size=18),legend.title=element_text(size=16),legend.text=element_text(size=16))
dev.copy(jpeg,'Iris species with self-designed hier-clustering algo.jpg',width=800,height=700)
dev.off()

X11()
ggplot(data.frame(iris,Group=groups), aes(Sepal.Length, Petal.Length, color = groups, shape=groups)) + geom_point(size=4) + ggtitle("Iris species with clustering package") +
  theme(plot.title=element_text(size=20,face="bold"),axis.title=element_text(size=18),legend.title=element_text(size=16),legend.text=element_text(size=16))
dev.copy(jpeg,'Iris species with clustering package.jpg',width=800,height=700)
dev.off()

X11()
ggplot(df_nonhier, aes(Sepal.Length, Petal.Length, color = group, shape=group)) + geom_point(size=4) + ggtitle("Iris species with self-designed nonhier-clustering algo") +
  theme(plot.title=element_text(size=20,face="bold"),axis.title=element_text(size=18),legend.title=element_text(size=16),legend.text=element_text(size=16))
dev.copy(jpeg,'Iris species with self-designed nonhier-clustering algo.jpg',width=800,height=700)
dev.off()

X11()
ggplot(data.frame(iris,Group=iris.kmeans$cluster), aes(Sepal.Length, Petal.Length, color = groups, shape=groups)) + geom_point(size=4) + ggtitle("Iris species with kmeans package") +
  theme(plot.title=element_text(size=20,face="bold"),axis.title=element_text(size=18),legend.title=element_text(size=16),legend.text=element_text(size=16))
dev.copy(jpeg,'Iris species with kmeans package.jpg',width=800,height=700)
dev.off()

graphics.off()

