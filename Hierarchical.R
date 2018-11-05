hier <- function(df,normalize=TRUE,groupNum=0){
  #Functions-----------------------------------------------------------------------------------------------------
  newP1 <- function(p1, p2) {
    #Calculate the point average
    p1[1:(length(p1)-2)] <- (t(p1[1:(length(p1)-2)])*p2[rep(length(p2),length(p2)-2)] + t(p2[1:(length(p2)-2)])*p1[rep(length(p1),(length(p1)-2))])/c(p1[length(p1)]+p2[length(p2)])
    p1[length(p1)-1] <- paste(p1[length(p1)-1], p2[length(p2)-1])
    p1[length(p1)] <- p1[length(p1)] + p2[length(p2)]
    return (p1)
  }
  
  #1. Initial the values
  df_original <- cbind(df, Group = 0)
  df_temp <- df[,-ncol(df)] #create a copy of df
  df_temp <- cbind(df_temp, Index = 1:nrow(df_temp), Weight = 1) #cbind index (1-150) &  wegiht (1 for all attribute) in the end of df_temp
  dist <- -1 #Initial the distance value
  
  for (j in 1:(nrow(df)-1)) {
    dupli = 0
    total <- matrix(NA, nrow=nrow(df_temp), ncol=nrow(df_temp)-1)
    
    #2. Calculate the closest distance among all points
    for (i in 1:nrow(df_temp)) {
      temp <- df_temp[rep(i,nrow(df_temp)-1),1:(ncol(df_temp)-2)] - df_temp[-i, 1:(ncol(df_temp)-2)]
      temp <- temp^2
      result <- rowSums(temp)
      total[i,] <- result^0.5
    }
    current_dist = min(total) #Finding the minimum distance in all values
    if (groupNum==0){
      if(current_dist > 1.1*dist) { #Update the dist value and stored the current df_temp to best_df
        dist <- current_dist
        best_df <- df_temp
      }
    } else if(nrow(df_temp)==groupNum){
      best_df <- df_temp
    }
    
    
    #3. Find two points and calculate 
    if(nrow(df_temp) <= 2) {
      p1 <- df_temp[1, ] #point 1
      p2 <- df_temp[2, ] #point 2
    } else {
      min_val <- which(total == min(total), arr.ind=TRUE) #Find the place of two points
      if (nrow(min_val)>2) {
        dupli <- nrow(min_val)/2
      }
      p1 <- df_temp[min_val[1,1], ]
      if (min_val[1,2] >= min_val[1,1]){
        p2 <- df_temp[min_val[1,2]+1, ]
      } else {
        p2 <- df_temp[min_val[1,2], ]
      }
    }
    p1 <- newP1(p1,p2) #call the function newP1 to create and stored a new p1
    df_temp[min_val[1,1], ] <- p1
    if (min_val[1,2] >= min_val[1,1]){
      df_temp <- df_temp[-(min_val[1,2]+1), ] #delete p2
    } else {
      df_temp <- df_temp[-min_val[1,2], ] #delete p2
    }
    if (dupli != 0){
      print(paste(j,dupli,sep=":"))
    }
  }
  
  #4
  saved_index <- strsplit(best_df[,ncol(best_df)-1], " ")
  
  for (k in 1:length(saved_index)) {
    df_original[unlist(saved_index[k]), "Group"] = k
  }
  df_original$Group <- as.factor(df_original$Group)
  return(df_original)
}

