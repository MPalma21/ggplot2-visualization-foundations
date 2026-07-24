source(here::here("R", "analysis.R"))

test_that("mtcars preparation creates semantic factors", {
  cars <- prepare_mtcars()
  expect_equal(nrow(cars), 32)
  expect_true(all(c("model", "cylinders", "transmission", "gears") %in% names(cars)))
  expect_s3_class(cars$cylinders, "factor")
  expect_equal(levels(cars$transmission), c("Automatic", "Manual"))
})

test_that("preparation rejects incomplete data", {
  expect_error(prepare_mtcars(data.frame(mpg = 1)), "Missing required columns")
})

test_that("chart functions return ggplot objects", {
  cars <- prepare_mtcars()
  expect_s3_class(plot_cylinder_counts(cars), "ggplot")
  expect_s3_class(plot_efficiency_weight(cars), "ggplot")
  expect_s3_class(plot_horsepower_distribution(cars), "ggplot")
  expect_s3_class(plot_efficiency_boxplot(cars), "ggplot")
})

