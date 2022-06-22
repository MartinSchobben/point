#' Simulate ion count data
#'
#' @param sys  ionization trend based on relative change in common isotope
#'  in per mille.
#' @param n Numeric for the number of measurements.
#' @param N Numeric for total ion count of the light isotope.
#' @param bl Numeric for block number.
#' @param reps Multiplication of the procedure (e.g. effectively generating
#'  multiple analyses).
#' @param ion1 A character string constituting the heavy isotope ("13C").
#' @param ion2 A character string constituting the light isotope ("12C").
#' @param sys Systematic variation caused by ionization fluctuations as
#'  relative standard deviation of the major ion in per mille
#' @param type Character string to select the type of simulation
#'  \code{"gradient"}, \code{"inclusion"} and \code{"ideal"}, where the former
#'  two types introduce an offset caused by a deviation in R.
#' @param baseR Numeric for the baseline isotope value in delta notation in per
#'  mille.
#' @param devR Numeric for the deviation (or forcing) away from the baseline as
#'  delta notation in per mille.
#' @param reference Character string for conversion of delta values to R
#'  (.e.g. VPDB; see \code{?calib_R()} for more information).
#' @param seed Numeric sees for reproducibility of the generated data.
#' @param equal_means Should the mean of the output be equal to `.baseR`. This
#'  defaults to `FALSE`, if set to `TRUE` this can be an computationally
#'  expensive procedure.
#'
#'
#' @return Tibble with simulated ion count data.D
#' @export
#' @examples
#'
#' # inclusion in 13C/12C over measurement transect
#' simu_R(50, "gradient", "13C", "12C", "VPDB", 1)
#'
simu_R <- function(sys, type, ion1, ion2, reference, seed, n = 3e3,
                   N = 1e6,  bl = 50, reps = 1, baseR = 0, devR = 0,
                   offset = 1.5, equal_means = FALSE) {

  if (!(type %in% c("gradient", "inclusion", "ideal"))) {
    rlang::abort("Unkown type of simulation")
  }

  # initiate
  M_N <- N / n # mean
  blocks <- rep(1:(n / bl), each = bl) # block numbering (for Camece-style diagnostics)

  simu_R <- tibble::tibble(
    type.nm = type,
    trend.nm = sys,
    base.nm = baseR,
    force.nm =  devR,
    t.nm = 1:n,
    bl.nm = blocks,
    n.rw = n,
    M_N.in = M_N,
    # Systematic variation (Ionization differences)
    N.in =
      as.integer(
        seq(
          unique(.data$M_N.in) * (1 - (sys / 100) / 2),
          unique(.data$M_N.in) * (1 + (sys / 100) / 2),
          length.out = n
        )
      ),
    # Isotopic variation
    R.in = R_gen(
      n,
      baseR,
      devR,
      reference = reference,
      ion1 = ion1,
      input = "delta",
      type = type,
      offset = offset
    )[[1]],
    # offset in ionization (important for inclusions)
    N.offset = R_gen(
      n,
      baseR,
      devR,
      reference = reference,
      ion1 = ion1,
      input = "delta",
      type = type,
      offset = offset
    )[[2]]
  ) |>
    # Expand over species and repetition (virtual samples)
    tidyr::expand_grid(spot.nm = c(1:reps), species.nm = c(ion1, ion2)) |>
    # Convert common isotope N with variable R and variable ionization
    dplyr::mutate(
      seed = seed + reps + dplyr::row_number(),
      # variable R
      N.in = dplyr::if_else(
        .data$species.nm == ion2, R_conv(.data$N.in, .data$R.in), .data$N.in
      ),
      # variable ionization
      N.in = .data$N.in * .data$N.offset
    ) |>
    # Random variation (Number generation)
    dplyr::group_by(.data$type.nm, .data$species.nm) |>
    dplyr::mutate(
      N.sm =
        purrr::pmap_dbl(
          list(M_N = .data$N.in, seed = .data$seed), N_gen),
      Xt.sm = .data$N.sm
    ) |>
    dplyr::ungroup() |>
    dplyr::select(-c(.data$seed, .data$N.in, .data$M_N.in, .data$R.in,
                     .data$N.offset))

    # correct for difference R to make R output equal to input `baseR`
    M_R <- stat_R(simu_R, ion1, ion2, .data$trend.nm, .data$base.nm,
                  .data$force.nm,  .data$spot.nm, .stat = "M", .N = N.sm,
                  .X = Xt.sm)$M_R_Xt.sm |>
      calib_R(reference = "VPDB", isotope = "13C", type = "composition",
              input = "R", output = "delta")

    # recursively apply again to get a mean that is equal to `baseR` with
    # tolerance 1 per mille
    if (isTRUE(equal_means)) {
      if (!isTRUE(all.equal(baseR, mean(M_R), tolerance = 1 / mean(M_R)))) {
        simu_R <- simu_R(sys, type, ion1, ion2, reference, seed, n, N, bl, reps,
                         baseR = baseR - mean(M_R), devR = devR - mean(M_R),
                         equal_means = TRUE)
      } else {
        # when equal it can be returned
        simu_R
      }
    }
    # return
    simu_R

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
# Create isotopic inclusions and offsets
#-------------------------------------------------------------------------------
R_gen <- function(reps, baseR, devR, reference, ion1, input = "delta", type,
                  offset) {

  baseR <- calib_R(
    baseR,
    reference = "VPDB",
    isotope = ion1,
    type = "composition",
    input = input,
    output = "R"
  )

  devR <- calib_R(
    devR,
    reference = "VPDB",
    isotope = ion1,
    type = "composition",
    input = input,
    output = "R"
  )

  if (type == "ideal") {

    R_simu <- rep(baseR, reps)
    N_excess <- rep(1, reps)

    return(list(R_simu, N_excess))

  } else if (type == "inclusion") {

    # middle of transect
    mid_point <- reps / 2
    # 1/2 interval of inclusion
    half_width <- reps / 6 / 2
    # inclusion in the middle of transect
    mid_vc <- c(1, mid_point - half_width, mid_point + half_width, reps)

    R_simu <- approx(
      mid_vc,
      c(baseR, devR, baseR, baseR),
      n = reps ,
      method = "constant"
    )$y
    # only here we expect excess ions to be offset due to measurement of
    # different materials across the transect
    N_excess <- approx(
      mid_vc,
      c(1, offset, 1, 1),
      n = reps ,
      method = "constant"
    )$y

    return(list(R_simu, N_excess))

  } else if (type == "gradient") {

    R_simu <- approx(
      c(1, reps),
      c(devR, baseR),
      n = reps ,
      method = "linear"
      )$y
    N_excess <- rep(1, reps)

    return(list(R_simu, N_excess))

  }
}
