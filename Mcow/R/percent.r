#' The function to format data into percentage format
#' 
#' 
#' @param x is numeric 
#' @export
#' @examples
#'  data <- percent(x)

percent <- function(x, digits = 2, format = "f", ...) {
  paste(formatC(100 * x, format = format, digits = digits, ...), "%", sep = "")
}

