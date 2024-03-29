#' @rdname Cameca
#'
#' @export
CooksD <- function(.IC, .ion1, .ion2, ..., .X = NULL, .N = NULL, .species = NULL,
                   .t = NULL, .output = "complete", .hyp = "none",
                   .alpha_level = 0.05, .mc_cores = 1){

  # Grouping
  gr_by <- enquos(...)

  # function name
  fun_nm <- rlang::as_name(match.call()[[1]])

  # check for package dependencies
  if (fun_nm == "IR") {
    # suggested package
    if (!requireNamespace("stats", quietly = TRUE)) {
      stop(
        "Package \"stats\" must be installed to use this function.",
        call. = FALSE
      )
    }
  }

  # check for package dependencies
  if (fun_nm == "QQ") {
    # suggested package
    if (!requireNamespace("nortest", quietly = TRUE)) {
      stop(
        "Package \"nortest\" must be installed to use this function.",
        call. = FALSE
      )
    }
  }

  # check if name has hypothesis test
  if(fun_nm != "CV" & .hyp == "bp") {
    stop("Wrong hypothesis test for this method.")
  }
  if(fun_nm != "QQ" & (.hyp == "norm" | .hyp == "ttest")) {
    stop("Wrong hypothesis test for this method.")
  }
  if(fun_nm != "IR" & .hyp == "ljung") {
    stop("Wrong hypothesis test for this method.")
    }
  if (!(fun_nm == "QQ" | fun_nm == "CV" | fun_nm == "IR") &  .hyp != "none") {
    .hyp <- "none"
    warning("No hypothesis test avalaible for this method.")
  }

  # Quoting the call (user-supplied expressions)
  args <- enquos(.X = .X, .N = .N, .species = .species, .t = .t)

  # Rare isotope
  X1 <- quo_updt(args[[".X"]], post = .ion1) # count rate
  # Common isotope
  X2 <- quo_updt(args[[".X"]], post = .ion2) # count rate

  # Execute
  IC_nest <- nest_R_lm(.IC, gr_by, X1, X2, args[[".t"]], method = fun_nm,
                       hyp = .hyp, alpha_level = .alpha_level,
                       mc_cores = .mc_cores)

  # Output
  if (fun_nm == "IR") {
    IC <- tidyr::unnest(
      dplyr::select(IC_nest, -c(.data$t, .data$data)),
      cols = c(.data$extr, .data$flag)
    )
    return(IC)
  }
  if (.output == "flag") {
    IC <- tidyr::unnest(
      dplyr::select(IC_nest, -.data$data),
      cols = c(.data$t, .data$extr, .data$flag)
    )
    return(IC)
  }
  if (.output == "complete") {
    IC <- tidyr::unnest(
      dplyr::select(IC_nest, -.data$t),
      cols = c(.data$data, .data$extr, .data$flag)
    )
    return(IC)
  }
}

#-------------------------------------------------------------------------------
# Not exportet helper functions
#-------------------------------------------------------------------------------

# nest lm (args as quos)
nest_R_lm <- function(IC, gr_by, X1, X2, t, method, hyp, alpha_level,
                      mc_cores) {

  tidyr::nest(IC, t = !! t, data = -c(!!! gr_by)) |>
    dplyr::mutate(
      aug =
        # parallel computation makes this step faster
        parallel::mcMap(
          function(x) broom::augment(formula_parser(x, X1, X2, type = "Rm")),
          .data$data,
          mc.cores = mc_cores
        ),
      extr =
        trans_switch(.data$aug, X1, X2, method, hyp, alpha_level),
      flag =
        purrr::map(.data$extr, ~flag_set(.x, method, alpha_level))
      ) |>
    dplyr::select(-c(.data$aug))
}

# switch to required method
trans_switch <- function(IC, X1, X2, method, hyp, alpha_level) {
  switch(
    method,
    Rm =,
    norm_E =,
    CooksD = extract_(IC, X1, X2, method),
    QQ = QQ_(IC, X1, X2, method, hyp, alpha_level),
    IR = IR_(IC, X1, X2, method, hyp, alpha_level),
    CV = CV_(IC, X1, X2, method, hyp, alpha_level)
  )
}

# vectorised functions
extract_ <- function(augmented, X1, X2, method) {
  purrr::map(augmented, ~transmute_reg(.x, X1, X2, method))
}

QQ_ <- function(augmented, X1, X2, method, hyp, alpha_level) {
  extract_(augmented, X1, X2, method) |>
    purrr::map(~QQ_trans(.x, method, hyp, alpha_level))
}

IR_ <- function(augmented, X1, X2, method, hyp, alpha_level) {
  extract_(augmented, X1, X2, method) |>
    purrr::map(~IR_trans(.x, method, hyp, alpha_level))
}

CV_ <- function(augmented, X1, X2, method, hyp, alpha_level) {
  extracted <- extract_(augmented, X1, X2, method)
  purrr::map2(
    augmented,
    extracted,
    ~bp_wrap(.x, .y, X2, method, hyp, alpha_level)
  )
}
# augment function transform  and rename variables to standards of point
transmute_reg <- function(IC, X1, X2, type){

  # predicted heavy isotope
  hat_X1 <- quo_updt(X1, pre = "hat")

  # model args
  args <- rlang::quos(
    hat_E = .data$.resid,
    !! hat_X1 := .data$.fitted,
    studE = .data$.std.resid,
    hat_Xi = .data$.hat,
    CooksD = .data$.cooksd,
  )

  if (type == "Rm"| type == "CV") args <- args[c(as_name(hat_X1), "studE")]
  if (type == "norm_E") args <- args[c("studE", "hat_Xi", "CooksD")]
  if (type == "CooksD") args <- args[c(as_name(hat_X1), "CooksD")]
  if (type == "QQ"| type == "IR") args <- args["studE"]

  # Execute
  dplyr::transmute(IC, !!! args)
}

# create flag variable
flag_set <- function(IC, type, alpha_level){

  data_env <- rlang::env(data = IC)

  if (type == "Rm" | type == "CV") {
    IC <- flagger(IC, !! rlang::parse_quo("studE", env = data_env), 3.5)
    return(IC)
  }
  if (type == "IR") {
    IC <- flagger(
      IC,
      !! rlang::parse_quo("acf", env = data_env),
      unique(!! rlang::parse_quo("e_acf", env = data_env))
    )
    return(IC)
  }
  if (type == "CooksD" | type == "norm_E") {
   IC <- dplyr::transmute(
     IC,
     flag =
       factor(
         dplyr::if_else(
           CooksD < {4 / (dplyr::n() - 2)},
           "confluent",
           "divergent"
          )
        )
   )
   return(IC)
  }
  if (type == "QQ") {
    IC <- dplyr::mutate(
      IC,
      lower = - qt((1 - alpha_level / 2), dplyr::n() - 1) * .data$hat_e_RQ,
      upper = qt((1 - alpha_level / 2), dplyr::n() - 1) * .data$hat_e_RQ,
    ) |>
    dplyr::transmute(
        flag = factor(.data$QE < .data$lower | .data$QE > .data$upper),
        flag =
          dplyr::recode_factor(
            .data$flag,
            `FALSE` = "confluent",
            `TRUE` = "divergent"
          )
    )
    return(IC)
  }
}

# function to create flag based on error or variance in modelled value
flagger <- function(IC, value, bound, fct = 1){
  dplyr::transmute(
    IC,
    flag =
      factor(
        dplyr::if_else(
          dplyr::between({{ value }}, - fct * {{ bound }}, fct * {{ bound }}),
          "confluent",
          "divergent"
        )
      )
  )
}

# quantile transformations and hypothesis tests
QQ_trans <- function(IC, type, hyp, alpha_level) {

  # short-cut
  if (type!= "QQ") return(IC)

  # Normality hypothesis test
  if (hyp == "norm") {
    hyp_result <- nortest::ad.test(IC$studE)$p.value
    Ha <- "Ha (non-normal)"
    H0 <- "H0 (normal)"
  }
  # t-test flag for mu0 (aka the conditional mean of residual) being zero
  if (hyp == "ttest") {
    hyp_result <- t.test(IC$studE, mu = 0)$p.value
    Ha <- "Ha (mu0 is not zero)"
    H0 <- "H0 (mu0 is zero)"
  }

  IC <- dplyr::transmute(
    IC,
    RQ = unname(quantile(.data$studE, probs = ppoints(dplyr::n()))),
    # Calculate normal (Theoretical) quantiles using mean and standard deviation
    TQ = qnorm(ppoints(dplyr::n()), mean(.data$RQ), sd(.data$RQ)),
    QE = .data$RQ - .data$TQ,
    # The standard error
    hat_RQ = mean(.data$RQ) + sd(.data$RQ) * .data$TQ,
    hat_e_RQ = hat_QR_se(.data$RQ, .data$TQ, ppoints(dplyr::n()), dplyr::n()),
  )

  if (hyp != "none") {
    IC <- dplyr::mutate(
      IC,
      hyp = dplyr::if_else(hyp_result < alpha_level, Ha, H0)
    )
    return(IC)
  } else {
    return(IC)
  }
}

# auto-correlation and hypothesis tests
IR_trans <- function(IC, type, hyp, alpha_level) {

  # short-cut
  if (type != "IR") return(IC)

  # independence test
  if (hyp == "ljung") {
    hyp_result <- stats::Box.test(IC$studE, type = "Ljung-Box")$p.value
    Ha <- "Ha (dependence of residuals)"
    H0 <- "H0 (independence of residuals)"
  }

  acf <- acf(IC$studE, plot = FALSE)
  si <- qnorm((1 - alpha_level / 2)) / sqrt(length(IC$studE))

  IC <- tibble::tibble(
    lag = as.vector(acf$lag)[-1],
    acf = as.vector(acf$acf)[-1],
    e_acf = si
  )

  if (hyp != "none") {
    IC <- dplyr::mutate(
      IC,
      hyp = dplyr::if_else(hyp_result < alpha_level, Ha, H0)
    )
    return(IC)
  } else {
    return(IC)
  }
}

# Hetroscadasticity test (Breusch Pagan test)(level of confidence 95%;
# cut-off 0.05 for H0 rejection)
bp_wrap <- function(IC1, IC2, X2, type, hyp, alpha_level){
  # Breusch Pagan test
  if (type == "CV" & hyp == "bp") {
    Chi_R2 <- custom_bp(IC1, X2)
    Ha <- "Ha (heteroskedasticity)"
    H0 <- "H0 (homoskedasticity)"
    IC2 <- dplyr::mutate(
      IC2,
      hyp = dplyr::if_else(Chi_R2 > qchisq((1 - alpha_level), df = 1), Ha, H0)
    )
    return(IC2)
  } else {
    return(IC2)
  }
}

# Breusch pagan test
custom_bp <- function(IC, X2){
  data_env <- rlang::env(data = IC)
  res_lm <- formula_parser(
    IC,
    rlang::parse_quo(".std.resid", env = data_env),
    X2
  )
  R2 <- dplyr::pull(broom::glance(res_lm), .data$`r.squared`)
  SE_beta <- dplyr::pull(broom::tidy(res_lm), .data$std.error)[2]
  R2 * length(R2)
}

# standard error of quantiles model
hat_QR_se <- function(RQ, TQ, pb, n){
  (sd(RQ) / dnorm(TQ)) * sqrt((pb * (1 - pb))/ unique(n))
}

#' @rdname Cameca
#'
#' @export
CV <- CooksD

#' @rdname Cameca
#'
#' @export
Rm <- CooksD

#' @rdname Cameca
#'
#' @export
norm_E <- CooksD

#' @rdname Cameca
#'
#' @export
QQ <- CooksD

#' @rdname Cameca
#'
#' @export
IR <- CooksD
