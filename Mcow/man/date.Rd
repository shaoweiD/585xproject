\name{date}
\alias{date}
\title{This function to reformat the date in the given dataset}
\usage{
date(x)
}
\arguments{
  \item{x}{is a column of date with format as "mon-year"}
}
\description{
Since the day of every date is missing, this function gives
a default value (the first day of each month) to each data
}
\examples{
newdate <- date(x)
}

