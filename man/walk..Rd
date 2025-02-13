% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/purrr-map.R
\name{walk.}
\alias{walk.}
\title{Apply a function to each element of a vector or list}
\usage{
walk.(.x, .f, ...)
}
\arguments{
\item{.x}{A list or vector}

\item{.f}{A function}

\item{...}{Other arguments to pass to a function}
}
\description{
The map functions transform their input by applying a function to each element and returning
a list/vector/data.table.
\itemize{
\item \code{map()} returns a list
\item \verb{_lgl()}, \verb{_int}, \verb{_dbl},\verb{_chr}, \verb{_df} variants return their specified type
\item \verb{_dfr} & \verb{_dfc} Return all data frame results combined utilizing row or column binding
}
}
\examples{
map(c(1,2,3), ~ .x + 1)

map_dbl(c(1,2,3), ~ .x + 1)

map_chr(c(1,2,3), as.character)
}
\keyword{internal}
