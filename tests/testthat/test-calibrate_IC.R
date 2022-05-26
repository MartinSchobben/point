test_that("isotope values can be converted", {
  expect_snapshot(
    calib_R(0.0111, reference = 0.011237, type = "composition", input = "R",
            output = "delta")
  )
  expect_snapshot(
    calib_R(0.0111, reference = "VPDB", isotope = "13C",
            type = "composition", input = "R", output = "delta")
  )
  expect_snapshot(
    calib_R(0.0111, reference = 0.011237, type = "composition",
            input = "R", output = "F")
  )
  expect_snapshot(
    calib_R(-25, reference = "VPDB", isotope = "13C",
            type = "enrichment", input = "delta", output = "alpha", y = -105)
  )
})

test_that("errors occur", {
  # error (same in and out)
  expect_error(
    calib_R(0.0111, reference = "VPDB", isotope = "13C",
            type = "composition", input = "R", output = "R")
  )
  # error enrichment should output epsilon or alpha
  expect_error(
    calib_R(-25, reference = "VPDB", isotope = "13C",
            type = "enrichment", input = "delta", output = "R")
  )
  # error enrichment should be supplied with secondary value (y)
  expect_error(
    calib_R(-25, reference = "VPDB", isotope = "13C",
            type = "enrichment", input = "delta", output = "alpha")
  )
  # error for enrichment conversions secondary value is not used
  expect_warning(
    calib_R(1.046154, reference = "VPDB", isotope = "13C",
            type = "enrichment", input = "alpha", output = "epsilon", y = 1)
  )
})
