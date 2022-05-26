## code to prepare `sim_IC` dataset

#-------------------------------------------------------------------------------
# Sensitivity of intra variability test
#-------------------------------------------------------------------------------
# repetition
reps <- 3

# Types of R variation
var_R <- c("symmetric", "asymmetric", "ideal")

# Execute
simu_IC <- purrr::map2_dfr(
  var_R,
  seq_along(var_R),
  ~simu_R(
    .sys = 120,
    .type = .x,
    .ion1 = "13C",
    .ion2 = "12C",
    .reference = "VPDB",
    .seed = .y,
    .reps = reps,
    .baseR = 0,
    .devR = -60,
    .equal_means = T
    )
  ) |>
# rename to make examples clearer
  dplyr::rename(Xt.pr = Xt.sm, N.pr = N.sm)

# Save small data-set for package
usethis::use_data(simu_IC, overwrite = TRUE, compress = "xz")
