#' This function to calculate percent reduction year on year
#' 
#' @param x is a column of data. In this project,this function can be used to calculated the percentage reduction of mad cow diseased year on year
#' @export
#' @examples
#'  result <- percent_reduction(x)
percent_reduction<-function(x){
  data<-x
  data$reduction<-NA
  for (i in 2:length(data)) {
    data$reduction[i] <- as.numeric((data[i-1]-data[i])/data[i - 1])
    if (data[i - 1] == 0) {
      data$reduction[i]<- 0
    }
  }
  return(data)
}

