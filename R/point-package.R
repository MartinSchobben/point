#' point: A package for reading, processing, and analysing raw ion count data.
#'
#' The point package provides function for reading processing and analysing
#' pulsed ion count data.
#'
#' The point functions provide a convenient way to work with and evaluate pulsed
#' ion count data. The \code{read_*} functions can load and collate raw ion
#' count data in a \code{tibble::\link[tibble:tibble]{tibble}()}. Systematic
#' biases that are introduced by the ion detection devices can be corrected with
#' the \code{cor_*} functions. The precision of ion count data can be checked
#' with the \code{stat_*} functions. The \code{diag_*} functions provide a
#' convenient way to measure the influence of individual measurements
#' (\emph{N}) on an \emph{n}-series of measurements (or analysis).
#'
#' @importFrom stats cov sd AIC acf anova approx coef dnorm fitted pchisq
#'  ppoints qchisq qnorm qt quantile rpois t.test median
#' @importFrom mgcv gamm s
#' @importFrom nlme lme gls
#' @importFrom utils data tail
#'
#' @docType package
#' @name point
NULL
