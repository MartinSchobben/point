#' Simulate ion count data
#'
#' @param .sys  ionization trend based on relative change in common isotope
#' in per mille.
#' @param .n Numeric for the number of measurements.
#' @param .N Numeric for total ion count of the light isotope.
#' @param .bl Numeric for block number.
#' @param .reps Multiplication of the procedure (e.g. effectively generating
#' multiple analyses).
#' @param .ion1 A character string constituting the heavy isotope ("13C").
#' @param .ion2 A character string constituting the light isotope ("12C").
#' @param .sys Systematic variation caused by ionization fluctuations as
#' relative standard deviation of the major ion in per mille
#' @param .type Character string to select the type of simulation
#' \code{"symmetric"}, \code{"asymmetric"} and \code{"ideal"}, where the former
#' two types introduce an offset caused by a deviation in R.
#' @param .baseR Numeric for the baseline isotope value in delta notation in per
#' mille.
#' @param .devR Numeric for the deviation (or forcing) away from the baseline as
#' delta notation in per mille.
#' @param .reference Character string for conversion of delta values to R
#' (.e.g. VPDB; see \code{?calib_R()} for more information).
#' @param .seed Numeric sees for reproducibility of the generated data.
#' @param ... Not supported currently
#'
#' @return Tibble with simulated ion count data.D
#' @export
#' @examples
#'
#' # Gradient in 13C/12C over measurement transect
#' simu_R(50, "symmetric", "13C", "12C", "VPDB", 1)
#'
simu_R <- function(.sys, .type, .ion1, .ion2, .reference, .seed, .n = 3e3,
                   .N = 1e6,  .bl = 50, .reps = 1, .baseR = 0, .devR = 0, ...){

  if (!(.type %in% c("symmetric", "asymmetric", "ideal"))) {
    stop("Unkown type of simulation")
  }

  M_N <- .N / .n
  ini_n <- .n
  blocks <- rep(1:(.n / .bl), each = .bl)
  devR <- rep(.devR, length.out = ini_n)

  tibble::tibble(
    type.nm = .type,
    trend.nm = .sys,
    base.nm = .baseR,
    force.nm = .devR,
    t.nm = 1:.n,
    bl.nm = blocks,
    n.rw = .n,
    M_N.in = M_N, #* (1 + (.sys / 100) / 2),
    # Systematic variation (Ionization differences)
    N.in =
      as.integer(
        seq(
          unique(.data$M_N.in) * (1 - (.sys / 100) / 2),
          unique(.data$M_N.in) * (1 + (.sys / 100) / 2),
          length.out = ini_n
        )
      ),
    # Isotopic variation
    R.in = R_gen(
      ini_n,
      .baseR,
      .devR,
      reference = .reference,
      isotope = .ion1,
      input = "delta",
      type = .type
    )
  ) %>%
    # Expand over species and repetition (virtual samples)
    tidyr::expand_grid(spot.nm = c(1:.reps), species.nm = c(.ion1, .ion2)) %>%
    # Convert common isotope N with variable R
    dplyr::mutate(
      seed = .seed + .reps + dplyr::row_number(),
      N.in = dplyr::if_else(
        .data$species.nm == .ion2, R_conv(.data$N.in, .data$R.in), .data$N.in
        )
        ) %>%
    # Random variation (Number generation)
    dplyr::group_by(.data$type.nm, .data$species.nm) %>%
    dplyr::mutate(
      N.sm =
        purrr::pmap_dbl(
          list(M_N = .data$N.in, seed = .data$seed), N_gen),
      Xt.sm = .data$N.sm
      ) %>%
    dplyr::ungroup() %>%
    dplyr::select(-c(.data$seed, .data$N.in, .data$M_N.in, .data$R.in))

}

#-------------------------------------------------------------------------------
# Random Poisson ion count generator
#-------------------------------------------------------------------------------
N_gen <- function(M_N, seed) {
  set.seed(seed)
  as.double(rpois(n = 1, lambda = M_N))
}

#-------------------------------------------------------------------------------
# Calculate common isotope count from rare isotope
#-------------------------------------------------------------------------------
R_conv <- function(N, R.sim)  as.integer(N * (1 / R.sim))

#-------------------------------------------------------------------------------
# Create isotopic gradients and offsets
#-------------------------------------------------------------------------------
R_gen <- function(reps, baseR, devR, reference, isotope, input = "delta", type) {

  baseR <- calib_R(
    baseR,
    reference = "VPDB",
    isotope = isotope,
    type = "composition",
    input = input,
    output = "R"
  )

  devR <- calib_R(
    devR,
    reference = "VPDB",
    isotope = isotope,
    type = "composition",
    input = input,
    output = "R"
  )

  if (type == "ideal") {
    R_simu <- rep(baseR, reps)
    return(R_simu)
  } else if (type == "asymmetric") {
    R_simu <- approx(
      c(1, 5 * reps / 6, reps),
      c(baseR, devR, devR),
      n = reps ,
      method = "constant"
    )$y
    return(R_simu)
  } else if (type == "symmetric") {
    R_simu <- approx(
      c(1, reps),
      c(devR, baseR),
      n = reps ,
      method = "linear"
      )$y
    return(R_simu)
  }
}
