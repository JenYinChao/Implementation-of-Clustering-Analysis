library(dplyr)
source("normalize.R")
source("group_init.R")
source("distance_Ele2Grp.R")

non_hier <- function(df,groupNum,normalize=TRUE){
  
  df_temp <- df[,-ncol(df)]
  #df_temp <- subset(df, select = -Species)
  if (normalize){ df_temp <- normalize(df_temp) }  #Normalized or not
  df_temp <- group_init(df_temp,groupNum)
  
  unstable_list <- 0
  while(length(unstable_list)>0){
    if (unstable_list[1]!=0){
      groupChangeCandidate <- sample(unstable_list,1)
      df_temp[groupChangeCandidate,"group"] <- mindis_Ele2Grp[groupChangeCandidate]
    }
    distance_E2G <- distance_Ele2Grp(df_temp,groupNum)
    mindis_Ele2Grp <- apply(distance_E2G,1,which.min)
    unstable_list <- which(df_temp$group!=mindis_Ele2Grp)
  }
  
  df.colname <- colnames(df)
  df <- cbind(df,mindis_Ele2Grp)
  colnames(df) <- c(df.colname,"group")
  df$group <- as.factor(df$group)
  return(df)
}
