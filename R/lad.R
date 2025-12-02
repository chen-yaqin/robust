#' Least Absolute Deviations Regression
#'
#' @param x A numeric vector of predictor values.
#' @param y A numeric vector of response values.
#' @return An object of class "lad" containing coefficients, fitted.values, and residuals.
#' @export
#' @examples
#' # Load data
#' data(area)
#'
#' # Fit LAD model
#' lad_model = lad(x = area$land, y = area$farm)
#'
#' # Fit LM model
#' lm_model = lm(farm ~ land, data = area)
#'
#' # 1. Print coefficients
#' print(lad_model)
#'
#' # 2. Draw scatterplot with lines
#' plot(area$land, area$farm, main = "LAD vs LM Regression", xlab = "Land", ylab = "Farm")
#' abline(lm_model, col = "red", lty = 2, lwd = 2)
#' abline(lad_model, col = "blue", lwd = 2)
#' legend("topleft", legend = c("LM", "LAD"), col = c("red", "blue"), lty = c(2, 1), lwd = 2)
#'
#' # 3. Predict and add green points
#' q_vals = quantile(area$land, probs = c(0, 0.25, 0.5, 0.75, 1))
#' preds = predict(lad_model, new.x = q_vals)
#' points(q_vals, preds, col = "green", pch = 19, cex = 1)
lad = function(x, y) {
  m = lm(y ~ x)
  init_betas = m$coefficients
  obj_fun = function(beta){
    sum(abs(y - (beta[1] + beta[2] * x)))
  }
  result = optim(par = init_betas, fn = obj_fun, method = "Nelder-Mead")
  final_betas = result$par
  names(final_betas) = c("(Intercept)", "x")
  fitted = final_betas[1] + final_betas[2] * x
  resids = y - fitted
  output = list(coefficients = final_betas, fitted.values = fitted, residuals = resids)
  class(output) = "lad"
  return(output)
}

#' Print method for lad objects
#'
#' @param x A lad object.
#' @param ... Further arguments passed to or from other methods.
#' @export
print.lad <- function(x, ...) {
  print(x$coefficients)
}

#' Extract coefficients from lad objects
#'
#' @param object A lad object.
#' @param ... Further arguments passed to or from other methods.
#' @export
coef.lad <- function(object, ...) {
  return(object$coefficients)
}

#' Predict method for lad objects
#'
#' @param object A lad object.
#' @param new.x A numeric vector of new x values to predict at.
#' @param ... Further arguments passed to or from other methods.
#' @export
predict.lad <- function(object, new.x, ...) {
  return(object$coefficients[1]+object$coefficients[2] * new.x)
}
