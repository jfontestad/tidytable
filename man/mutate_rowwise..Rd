% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mutate_rowwise.R
\name{mutate_rowwise.}
\alias{mutate_rowwise.}
\title{Add/modify columns by row}
\usage{
mutate_rowwise.(
  .df,
  ...,
  .keep = c("all", "used", "unused", "none"),
  .before = NULL,
  .after = NULL
)
}
\arguments{
\item{.df}{A data.table or data.frame}

\item{...}{Columns to add/modify}

\item{.keep}{\emph{experimental}:
This is an experimental argument that allows you to control which columns
from \code{.df} are retained in the output:
\itemize{
\item \code{"all"}, the default, retains all variables.
\item \code{"used"} keeps any variables used to make new variables; it's useful
for checking your work as it displays inputs and outputs side-by-side.
\item \code{"unused"} keeps only existing variables \emph{\strong{not}} used to make new
variables.
\item \code{"none"}, only keeps grouping keys (like \code{\link[=transmute]{transmute()}}).
}}

\item{.before, .after}{Optionally indicate where new columns should be placed.
Defaults to the right side of the data frame.}
}
\description{
Allows you to mutate "by row". this is most useful when a vectorized function doesn't exist.
}
\examples{
df <- data.table(x = 1:3, y = 1:3 * 2, z = 1:3 * 3)

# Compute the mean of x, y, z in each row
df \%>\%
  mutate_rowwise(row_mean = mean(c(x, y, z)))

# Use c_across() to more easily select many variables
df \%>\%
  mutate_rowwise(row_mean = mean(c_across(x:z)))
}
\keyword{internal}
