test_that("simulation of IC works", {
  expect_snapshot(
    simu_R(50, "symmetric", "13C", "12C", "VPDB", 1, .baseR = 0, .devR = 30)
  )
  expect_snapshot(
    simu_R(50, "asymmetric", "13C", "12C", "VPDB", 1, .baseR = 0, .devR = 30)
  )
  expect_snapshot(
    simu_R(50, "ideal", "13C", "12C", "VPDB", 1, .baseR = 0, .devR = 30)
  )
  expect_error(
    simu_R(50, "wrong", "13C", "12C", "VPDB", 1, .baseR = 0, .devR = 30),
    NULL
  )
})


test_that("test that mean R stays the same", {

  # simulate R with anomaly (asymmetric)
  simuR <- simu_R(50, "asymmetric", "13C", "12C", "VPDB", 20, .baseR = 0,
                  .devR = 30, .equal_means = T)
  # calculate mean R
  M_R <- stat_R(simuR, "13C", "12C", trend.nm, base.nm, force.nm, .stat = "M",
                .N = N.sm, .X = Xt.sm)$M_R_Xt.sm |>
    # calculate per mille relative to VPDB
    calib_R(reference = "VPDB", isotope = "13C", type = "composition",
            input = "R", output = "delta")

  expect_equal(M_R, 0, tolerance = 1)

  # simulate R with anomaly (symmetric)
  simuR <- simu_R(50, "symmetric", "13C", "12C", "VPDB", 20, .baseR = 0,
                  .devR = 30, .equal_means = T)
  # calculate mean R
  M_R <- stat_R(simuR, "13C", "12C", trend.nm, base.nm, force.nm, .stat = "M",
                .N = N.sm, .X = Xt.sm)$M_R_Xt.sm |>
    # calculate per mille relative to VPDB
    calib_R(reference = "VPDB", isotope = "13C", type = "composition",
            input = "R", output = "delta")

  expect_equal(M_R, 0, tolerance = 1)
})
