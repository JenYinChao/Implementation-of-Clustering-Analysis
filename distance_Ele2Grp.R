distance_Ele2Grp <- function(df,groupNum){
  df_sub = subset(df,select = -group)
  groupMean = aggregate(df_sub,list(df$group),mean)
  df_dis = 0 %>% rep(nrow(df)*groupNum) %>% array(c(nrow(df),groupNum)) %>% data.frame()
  for (group in c(1:groupNum)){
    df_dis[,group] = ( df_sub - groupMean[group,-1] %>% unlist() %>% rep(nrow(df)) %>% array(c(ncol(df_sub),nrow(df))) %>% t() )^2 %>% rowSums()
  }
  names(df_dis) = paste("toGroup",c(1:groupNum),sep = "")
  return(df_dis)
}

