# simulation of IC works

    Code
      simu_R(50, "symmetric", "13C", "12C", "VPDB", 1, .baseR = 0, .devR = 30)
    Output
      # A tibble: 6,000 x 11
         type.nm  trend.nm base.nm force.nm  t.nm bl.nm  n.rw spot.nm species.nm  N.sm
         <chr>       <dbl>   <dbl>    <dbl> <int> <int> <dbl>   <int> <chr>      <dbl>
       1 symmetr~       50   -14.7     15.3     1     1  3000       1 13C          234
       2 symmetr~       50   -14.7     15.3     1     1  3000       1 12C        21945
       3 symmetr~       50   -14.7     15.3     2     1  3000       1 13C          236
       4 symmetr~       50   -14.7     15.3     2     1  3000       1 12C        21952
       5 symmetr~       50   -14.7     15.3     3     1  3000       1 13C          286
       6 symmetr~       50   -14.7     15.3     3     1  3000       1 12C        21900
       7 symmetr~       50   -14.7     15.3     4     1  3000       1 13C          237
       8 symmetr~       50   -14.7     15.3     4     1  3000       1 12C        21915
       9 symmetr~       50   -14.7     15.3     5     1  3000       1 13C          240
      10 symmetr~       50   -14.7     15.3     5     1  3000       1 12C        21694
      # ... with 5,990 more rows, and 1 more variable: Xt.sm <dbl>

---

    Code
      simu_R(50, "asymmetric", "13C", "12C", "VPDB", 1, .baseR = 0, .devR = 30)
    Output
      # A tibble: 6,000 x 11
         type.nm  trend.nm base.nm force.nm  t.nm bl.nm  n.rw spot.nm species.nm  N.sm
         <chr>       <dbl>   <dbl>    <dbl> <int> <int> <dbl>   <int> <chr>      <dbl>
       1 asymmet~       50   -6.95     23.0     1     1  3000       1 13C          234
       2 asymmet~       50   -6.95     23.0     1     1  3000       1 12C        22435
       3 asymmet~       50   -6.95     23.0     2     1  3000       1 13C          236
       4 asymmet~       50   -6.95     23.0     2     1  3000       1 12C        22443
       5 asymmet~       50   -6.95     23.0     3     1  3000       1 13C          286
       6 asymmet~       50   -6.95     23.0     3     1  3000       1 12C        22390
       7 asymmet~       50   -6.95     23.0     4     1  3000       1 13C          237
       8 asymmet~       50   -6.95     23.0     4     1  3000       1 12C        22405
       9 asymmet~       50   -6.95     23.0     5     1  3000       1 13C          240
      10 asymmet~       50   -6.95     23.0     5     1  3000       1 12C        22181
      # ... with 5,990 more rows, and 1 more variable: Xt.sm <dbl>

---

    Code
      simu_R(50, "ideal", "13C", "12C", "VPDB", 1, .baseR = 0, .devR = 30)
    Output
      # A tibble: 6,000 x 11
         type.nm trend.nm base.nm force.nm  t.nm bl.nm  n.rw spot.nm species.nm  N.sm
         <chr>      <dbl>   <dbl>    <dbl> <int> <int> <dbl>   <int> <chr>      <dbl>
       1 ideal         50   -1.04     29.0     1     1  3000       1 13C          234
       2 ideal         50   -1.04     29.0     1     1  3000       1 12C        22303
       3 ideal         50   -1.04     29.0     2     1  3000       1 13C          236
       4 ideal         50   -1.04     29.0     2     1  3000       1 12C        22311
       5 ideal         50   -1.04     29.0     3     1  3000       1 13C          286
       6 ideal         50   -1.04     29.0     3     1  3000       1 12C        22258
       7 ideal         50   -1.04     29.0     4     1  3000       1 13C          237
       8 ideal         50   -1.04     29.0     4     1  3000       1 12C        22273
       9 ideal         50   -1.04     29.0     5     1  3000       1 13C          240
      10 ideal         50   -1.04     29.0     5     1  3000       1 12C        22050
      # ... with 5,990 more rows, and 1 more variable: Xt.sm <dbl>

