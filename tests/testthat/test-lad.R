test_that("lad computes correct coefficients for a simple case", {
  x = 1:10
  y = 2 * x + 1
  fit = lad(x, y)
  expect_s3_class(fit, "lad")
  coefs = coef(fit)
  expect_equal(as.numeric(coefs["(Intercept)"]), 1, tolerance = 0.01)
  expect_equal(as.numeric(coefs["x"]), 2, tolerance = 0.01)
})
