#' The function to extract polygons
#' 
#' Input file should be a shape file 
#' @param x is a thinned spatialpolygon file
#' @export
#' @examples
#'  oz <- extractPolygons(x)

extractPolygons <- function(shapes) {
  require(plyr)
  
  dframe <- ldply(1:length(shapes@polygons), function(i) {
    ob <- shapes@polygons[[i]]@Polygons
    dframe <- ldply(1:length(ob), function(j) {
      x <- ob[[j]]
      co <- x@coords
      data.frame(co, order = 1:nrow(co), group = j)
    })
    dframe$region <- i
    dframe
  })
  # construct a group variable from both group and polygon:
  dframe$group <- interaction(dframe$region, dframe$group)
  
  dframe
}