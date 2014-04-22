#' This function to reformat the date in the given dataset
#' 
#' Since the day of every date is missing, this function gives a default value (the first day of each month) to each data
#' @param x is a column of date with format as "mon-year" 
#' @export
#' @examples
#'  newdate <- date(x)
date<-function(x){
as.Date(x = paste("1-", x, sep = ""), format = "%d-%b-%y")
}