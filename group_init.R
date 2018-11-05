group_init <- function(df,groupNum){
  group = sample(1:groupNum,nrow(df),replace=TRUE)
  df = cbind(df,group)
  return(df)
}