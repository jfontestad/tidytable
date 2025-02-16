% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/across.R
\name{across.}
\alias{across.}
\title{Apply a function across a selection of columns}
\usage{
across.(.cols = everything(), .fns = NULL, ..., .names = NULL)
}
\arguments{
\item{.cols}{vector \code{c()} of unquoted column names. \code{tidyselect} compatible.}

\item{.fns}{Function to apply. Can be a purrr-style lambda.
Can pass also list of functions.}

\item{...}{Other arguments for the passed function}

\item{.names}{A glue specification that helps with renaming output columns.
\code{{.col}} stands for the selected column, and \code{{.fn}} stands for the name of the function being applied.
The default (\code{NULL}) is equivalent to \code{"{.col}"} for a single function case and \code{"{.col}_{.fn}"}
when a list is used for \code{.fns}.}
}
\description{
Apply a function across a selection of columns. For use in \code{arrange()},
\code{mutate()}, and \code{summarize()}.
}
\examples{
df <- data.table(
  x = rep(1, 3),
  y = rep(2, 3),
  z = c("a", "a", "b")
)

df \%>\%
  mutate(across(c(x, y), ~ .x * 2))

df \%>\%
  summarize(across(where(is.numeric), ~ mean(.x)),
            .by = z)

df \%>\%
  arrange(across(c(y, z)))
}
\keyword{internal}
