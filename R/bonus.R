#' Find the base R generic function with the most methods
#'
#' This function scans all objects in the "base" package to find which generic function
#' has the largest number of S3 methods.
#'
#' @return A list containing:
#' \item{base.function}{The name of the generic function with the most methods.}
#' \item{n}{The number of methods it has.}
#' @export
#' @examples
#' \dontrun{
#'   base.function.most.methods()
#' }
base.function.most.methods = function() {
  objs = ls("package:base")

  best_func = NULL
  max_n = -1

  for (obj_name in objs) {
    m = try(methods(obj_name), silent = TRUE)

    if (!inherits(m, "try-error")) {
      now_n = length(m)
      if (now_n > max_n) {
        max_n = now_n
        best_func = obj_name
      }
    }
  }
  return(list(base.function = best_func, n = max_n))
}
