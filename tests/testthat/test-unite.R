test_that("works with no input & works with NA", {
  test_df <- tidytable(a = c("a", "a", "a"),
                       b = c("b", "b", "b"),
                       c = c("c", NA, "c"))

  unite_df <- test_df %>%
    unite()

  expect_named(unite_df, ".united")
  expect_equal(unite_df$.united, c("a_b_c", "a_b_NA", "a_b_c"))
})

test_that("unite. works", {
  test_df <- tidytable(a = c("a", "a", "a"),
                       b = c("b", "b", "b"),
                       c = c("c", NA, "c"))

  unite_df <- test_df %>%
    unite.() %>%
    suppressWarnings()

  expect_named(unite_df, ".united")
  expect_equal(unite_df$.united, c("a_b_c", "a_b_NA", "a_b_c"))
})

test_that("works with selected cols", {

  test_df <- tidytable(a = c("a", "a", "a"),
                       b = c("b", "b", "b"),
                       c = c("c", NA, "c"))

  unite_df <- test_df %>%
    unite("new_col", a:b)

  expect_named(unite_df, c("new_col", "c"))
  expect_equal(unite_df$new_col, c("a_b", "a_b", "a_b"))
})

test_that("does not remove new col in case of name clash", {
  df <- data.table(x = "a", y = "b")
  out <- unite(df, x, x:y)
  expect_equal(names(out), "x")
  expect_equal(out$x, "a_b")
})

test_that("na.rm works", {
  test_df <- tidytable(a = c("a", "a", "a"),
                       b = c("b", "b", "b"),
                       c = c("c", NA, "c"))

  unite_df <- test_df %>%
    unite("new_col", a:c, na.rm = TRUE)

  expect_named(unite_df, "new_col")
  expect_equal(unite_df$new_col, c("a_b_c", "a_b", "a_b_c"))
})

test_that("can keep cols", {
  test_df <- tidytable(a = c("a", "a", "a"),
                       b = c("b", "b", "b"),
                       c = c("c", NA, "c"))

  unite_df <- test_df %>%
    unite("new_col", a:c, remove = FALSE, na.rm = TRUE)

  expect_named(unite_df, c("new_col", "a", "b", "c"))
  expect_equal(unite_df$new_col, c("a_b_c", "a_b", "a_b_c"))
})

test_that("doesn't modify-by-reference", {
  test_df <- tidytable(a = c("a", "a", "a"),
                       b = c("b", "b", "b"),
                       c = c("c", NA, "c"))

  test_df %>%
    unite("new_col", a:b, na.rm = TRUE)

  expect_named(test_df, c("a", "b", "c"))
})

test_that("works with selected cols with quosure function", {

  test_df <- tidytable(a = c("a", "a", "a"),
                       b = c("b", "b", "b"),
                       c = c("c", NA, "c"))

  unite_fn <- function(.df, col1, col2) {
    unite(.df, "new_col", {{ col1 }}, {{ col2 }})
  }

  unite_df <- test_df %>%
    unite_fn(a, b)

  expect_named(unite_df, c("new_col", "c"))
  expect_equal(unite_df$new_col, c("a_b", "a_b", "a_b"))
})
