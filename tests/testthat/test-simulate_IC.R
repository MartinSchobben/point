test_that("R generation works", {
  expect_snapshot(
    R_gen(1000, 0, 30, "VPDB", "13C", type = "ideal")
  )
  expect_snapshot(
    R_gen(1000, 0, 30, "VPDB", "13C", type = "inclusion", offset = 1.05)
  )
  expect_snapshot(
    R_gen(1000, 0, 30, "VPDB", "13C", type = "gradient")
  )
})

test_that("ion count generation works", {
  expect_snapshot(
    simu_R(50, "ideal", "13C", "12C", "VPDB", 1)
  )
  expect_snapshot(
    simu_R(50, "inclusion", "13C", "12C", "VPDB", 1)
  )
  expect_snapshot(
    simu_R(50, "gradient", "13C", "12C", "VPDB", 1)
  )
})
