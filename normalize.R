normalize <- function(df){
  df_norm <- (df%>%t() - df%>%apply(2,mean)) / df%>%apply(2,sd)
  return(df_norm%>%t()%>%data.frame())
}