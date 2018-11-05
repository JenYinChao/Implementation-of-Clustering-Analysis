# Implementation-of-Clustering-Analysis
Analysis of Algorithms Final Project (Spring 2018)

# Author
Jen-Yin Chao: Main Code, R package using part, and Nonhierarchical 

Meng-Tse Li: Hierarchical part (Directed by Jen-Yin Chao)

# Abstract
Cluster is an essential method of data analysis, which can be used in customer analysis, market basket analysis, and most cases of segmentation without clear boundary of classification. Accordingly, there have been several available packages in R and Python, but they can only be used one of the method at a time, while it’s more useful and accurate to combine hierarchical and non-hierarchical cluster analysis, that is to say, the setting of group number of K-means method(non-hierarchical) can be fetched from the outcome of Ward’s method(hierarchical). Furthermore, when the scale of data set becomes larger, most of packages will be quite time-consuming. As the result, our goal is to implement these two cluster methods with algorithm theories to improve efficiency and compute more accurate result. However, after the implementation, we cannot compete the execution time, although we have similar clustering outcome.
