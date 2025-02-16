% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/slice.R
\name{slice.}
\alias{slice.}
\title{Choose rows in a data.table}
\usage{
slice.(.df, ..., .by = NULL)
}
\arguments{
\item{.df}{A data.frame or data.table}

\item{...}{Integer row values}

\item{.by}{Columns to group by}
}
\description{
Choose rows in a data.table.
Grouped data.tables grab rows within each group.
}
\examples{
df <- data.table(
  x = 1:4,
  y = 5:8,
  z = c("a", "a", "a", "b")
)

df \%>\%
  slice(1:3)

df \%>\%
  slice(1, 3)

df \%>\%
  slice(1:2, .by = z)

df \%>\%
  slice_head(1, .by = z)

df \%>\%
  slice_tail(1, .by = z)

df \%>\%
  slice_max(order_by = x, .by = z)

df \%>\%
  slice_min(order_by = y, .by = z)
}
\keyword{internal}
