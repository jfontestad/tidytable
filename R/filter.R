#' Filter rows on one or more conditions
#'
#' @description
#' Filters a dataset to choose rows where conditions are true.
#'
#' @param .df A data.frame or data.table
#' @param ... Conditions to filter by
#' @param .by Columns to group by if filtering with a summary function
#'
#' @export
#'
#' @examples
#' df <- tidytable(
#'   a = 1:3,
#'   b = 4:6,
#'   c = c("a", "a", "b")
#' )
#'
#' df %>%
#'   filter(a >= 2, b >= 4)
#'
#' df %>%
#'   filter(b <= mean(b), .by = c)
filter <- function(.df, ..., .by = NULL) {
  .df <- .df_as_tidytable(.df)

  if (is_ungrouped(.df)) {
    tt_filter(.df, ..., .by = {{ .by }})
  } else {
    .by <- group_vars(.df)
    tt_filter(.df, ..., .by = any_of(.by))
  }
}

#' @export
#' @keywords internal
#' @inherit filter
filter. <- function(.df, ..., .by = NULL) {
  deprecate_dot_fun()
  filter(.df, ..., .by = {{ .by }})
}

tt_filter <- function(.df, ..., .by = NULL) {
  .by <- enquo(.by)

  dots <- enquos(...)
  if (length(dots) == 0) return(.df)

  check_filter(dots)

  dt_env <- get_dt_env(dots)

  dots <- prep_exprs(dots, .df, !!.by, dt_env = dt_env)

  i <- call_reduce(dots, "&")

  .by <- tidyselect_names(.df, !!.by)

  dt_expr <- call2_i(.df, i, .by)

  eval_tidy(dt_expr, .df, dt_env)
}

check_filter <- function(dots) {
  .is_named <- have_name(dots)

  if (any(.is_named)) {
    named_dots <- dots[.is_named]

    i <- which(.is_named)[[1]]
    dot <- as_label(quo_get_expr(named_dots[[1]]))
    dot_name <- names(named_dots[1])

    abort(c(
      glue("Problem with `filter()` input `..{i}`."),
      x = glue("Input `..{i}` is named."),
      i = glue("This usually means that you've used `=` instead of `==`."),
      i = glue("Did you mean `{dot_name} == {dot}`?")
    ))
  }
}
