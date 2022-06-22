# diagnostics wrapper on synthetic data is consistent

    Code
      diag_R(simu_IC, "13C", "12C", type.nm, spot.nm)
    Output
      # A tibble: 9 x 7
        execution type.nm   spot.nm ratio.nm M_R_Xt.pr F_R_Xt.pr p_R_Xt.pr
            <dbl> <chr>       <int> <chr>        <dbl>     <dbl>     <dbl>
      1         1 gradient        1 13C/12C     0.0110   52.2     6.68e-33
      2         1 gradient        2 13C/12C     0.0110   69.8     1.30e-43
      3         1 gradient        3 13C/12C     0.0110   62.8     2.19e-39
      4         1 ideal           1 13C/12C     0.0112    0.192   9.43e- 1
      5         1 ideal           2 13C/12C     0.0112    0.0603  9.93e- 1
      6         1 ideal           3 13C/12C     0.0112    1.51    1.95e- 1
      7         1 inclusion       1 13C/12C     0.0111   13.5     9.93e- 9
      8         1 inclusion       2 13C/12C     0.0111   28.8     2.31e-18
      9         1 inclusion       3 13C/12C     0.0111   17.7     2.31e-11

---

    Code
      diag_R(simu_IC, "13C", "12C", type.nm, spot.nm, .method = "CV")
    Output
      # A tibble: 9 x 3
        type.nm   spot.nm hyp                  
        <chr>       <int> <chr>                
      1 gradient        1 H0 (homoskedasticity)
      2 gradient        2 H0 (homoskedasticity)
      3 gradient        3 H0 (homoskedasticity)
      4 inclusion       1 H0 (homoskedasticity)
      5 inclusion       2 H0 (homoskedasticity)
      6 inclusion       3 H0 (homoskedasticity)
      7 ideal           1 H0 (homoskedasticity)
      8 ideal           2 H0 (homoskedasticity)
      9 ideal           3 H0 (homoskedasticity)

---

    Code
      diag_R(simu_IC, "13C", "12C", type.nm, spot.nm, .output = "complete")
    Output
      # A tibble: 27,000 x 66
         execution type.nm  spot.nm  t.nm trend.nm.13C trend.nm.12C base.nm.13C
             <dbl> <chr>      <int> <int>        <dbl>        <dbl>       <dbl>
       1         1 gradient       1     1          120          120           0
       2         1 gradient       1     2          120          120           0
       3         1 gradient       1     3          120          120           0
       4         1 gradient       1     4          120          120           0
       5         1 gradient       1     5          120          120           0
       6         1 gradient       1     6          120          120           0
       7         1 gradient       1     7          120          120           0
       8         1 gradient       1     8          120          120           0
       9         1 gradient       1     9          120          120           0
      10         1 gradient       1    10          120          120           0
      # ... with 26,990 more rows, and 59 more variables: base.nm.12C <dbl>,
      #   force.nm.13C <dbl>, force.nm.12C <dbl>, bl.nm.13C <int>, bl.nm.12C <int>,
      #   n.rw.13C <dbl>, n.rw.12C <dbl>, N.pr.13C <dbl>, N.pr.12C <dbl>,
      #   Xt.pr.13C <dbl>, Xt.pr.12C <dbl>, n_t.nm.13C <int>, n_t.nm.12C <int>,
      #   tot_N.pr.13C <dbl>, tot_N.pr.12C <dbl>, M_Xt.pr.13C <dbl>,
      #   M_Xt.pr.12C <dbl>, S_Xt.pr.13C <dbl>, S_Xt.pr.12C <dbl>,
      #   RS_Xt.pr.13C <dbl>, RS_Xt.pr.12C <dbl>, SeM_Xt.pr.13C <dbl>, ...

---

    Code
      diag_R(simu_IC, "13C", "12C", type.nm, spot.nm, .output = "augmented")
    Output
      # A tibble: 105,298 x 12
         execution type.nm  trend.nm base.nm force.nm  t.nm bl.nm  n.rw spot.nm
             <dbl> <chr>       <dbl>   <dbl>    <dbl> <int> <int> <dbl>   <int>
       1         1 gradient      120       0      -60     1     1  3000       1
       2         1 gradient      120       0      -60     1     1  3000       1
       3         1 gradient      120       0      -60     1     1  3000       2
       4         1 gradient      120       0      -60     1     1  3000       2
       5         1 gradient      120       0      -60     1     1  3000       3
       6         1 gradient      120       0      -60     1     1  3000       3
       7         1 gradient      120       0      -60     2     1  3000       1
       8         1 gradient      120       0      -60     2     1  3000       1
       9         1 gradient      120       0      -60     2     1  3000       2
      10         1 gradient      120       0      -60     2     1  3000       2
      # ... with 105,288 more rows, and 3 more variables: species.nm <chr>,
      #   N.pr <dbl>, Xt.pr <dbl>

---

    Code
      diag_R(simu_IC, "13C", "12C", type.nm, spot.nm, .output = "diagnostic")
    Output
      # A tibble: 27,000 x 55
         execution type.nm  spot.nm  t.nm trend.nm.13C trend.nm.12C base.nm.13C
             <dbl> <chr>      <int> <int>        <dbl>        <dbl>       <dbl>
       1         1 gradient       1     1          120          120           0
       2         1 gradient       1     2          120          120           0
       3         1 gradient       1     3          120          120           0
       4         1 gradient       1     4          120          120           0
       5         1 gradient       1     5          120          120           0
       6         1 gradient       1     6          120          120           0
       7         1 gradient       1     7          120          120           0
       8         1 gradient       1     8          120          120           0
       9         1 gradient       1     9          120          120           0
      10         1 gradient       1    10          120          120           0
      # ... with 26,990 more rows, and 48 more variables: base.nm.12C <dbl>,
      #   force.nm.13C <dbl>, force.nm.12C <dbl>, bl.nm.13C <int>, bl.nm.12C <int>,
      #   n.rw.13C <dbl>, n.rw.12C <dbl>, N.pr.13C <dbl>, N.pr.12C <dbl>,
      #   Xt.pr.13C <dbl>, Xt.pr.12C <dbl>, n_t.nm.13C <int>, n_t.nm.12C <int>,
      #   tot_N.pr.13C <dbl>, tot_N.pr.12C <dbl>, M_Xt.pr.13C <dbl>,
      #   M_Xt.pr.12C <dbl>, S_Xt.pr.13C <dbl>, S_Xt.pr.12C <dbl>,
      #   RS_Xt.pr.13C <dbl>, RS_Xt.pr.12C <dbl>, SeM_Xt.pr.13C <dbl>, ...

---

    Code
      diag_R(simu_IC, "13C", "12C", type.nm, spot.nm, .output = "outlier")
    Output
      # A tibble: 27,000 x 23
         execution type.nm  spot.nm  t.nm trend.nm.13C trend.nm.12C base.nm.13C
             <dbl> <chr>      <int> <int>        <dbl>        <dbl>       <dbl>
       1         1 gradient       1     1          120          120           0
       2         1 gradient       1     2          120          120           0
       3         1 gradient       1     3          120          120           0
       4         1 gradient       1     4          120          120           0
       5         1 gradient       1     5          120          120           0
       6         1 gradient       1     6          120          120           0
       7         1 gradient       1     7          120          120           0
       8         1 gradient       1     8          120          120           0
       9         1 gradient       1     9          120          120           0
      10         1 gradient       1    10          120          120           0
      # ... with 26,990 more rows, and 16 more variables: base.nm.12C <dbl>,
      #   force.nm.13C <dbl>, force.nm.12C <dbl>, bl.nm.13C <int>, bl.nm.12C <int>,
      #   n.rw.13C <dbl>, n.rw.12C <dbl>, N.pr.13C <dbl>, N.pr.12C <dbl>,
      #   Xt.pr.13C <dbl>, Xt.pr.12C <dbl>, hat_S_N.pr.13C <dbl>,
      #   hat_Xt.pr.13C <dbl>, CooksD <dbl>, hat_E <dbl>, flag <fct>

---

    Code
      diag_R(simu_IC, "13C", "12C", type.nm, spot.nm, .label = "latex")
    Output
      # A tibble: 9 x 7
        execution type.nm   spot.nm ratio.nm `$\\bar{R}$` `$F_{R}$` `$p_{R}$`
            <dbl> <chr>       <int> <chr>           <dbl>     <dbl>     <dbl>
      1         1 gradient        1 13C/12C        0.0110   52.2     6.68e-33
      2         1 gradient        2 13C/12C        0.0110   69.8     1.30e-43
      3         1 gradient        3 13C/12C        0.0110   62.8     2.19e-39
      4         1 ideal           1 13C/12C        0.0112    0.192   9.43e- 1
      5         1 ideal           2 13C/12C        0.0112    0.0603  9.93e- 1
      6         1 ideal           3 13C/12C        0.0112    1.51    1.95e- 1
      7         1 inclusion       1 13C/12C        0.0111   13.5     9.93e- 9
      8         1 inclusion       2 13C/12C        0.0111   28.8     2.31e-18
      9         1 inclusion       3 13C/12C        0.0111   17.7     2.31e-11

---

    Code
      diag_R(simu_IC, "13C", "12C", type.nm, spot.nm, .nest = type.nm, .label = "latex")
    Output
      # A tibble: 9 x 11
        execution type.nm   spot.nm ratio.nm `$\\bar{R}$` `$F_{R}$` `$p_{R}$`
            <dbl> <chr>       <int> <chr>           <dbl>     <dbl>     <dbl>
      1         1 gradient        1 13C/12C        0.0110   52.2     6.68e-33
      2         1 gradient        2 13C/12C        0.0110   69.8     1.30e-43
      3         1 gradient        3 13C/12C        0.0110   62.8     2.19e-39
      4         1 ideal           1 13C/12C        0.0112    0.192   9.43e- 1
      5         1 ideal           2 13C/12C        0.0112    0.0603  9.93e- 1
      6         1 ideal           3 13C/12C        0.0112    1.51    1.95e- 1
      7         1 inclusion       1 13C/12C        0.0111   13.5     9.93e- 9
      8         1 inclusion       2 13C/12C        0.0111   28.8     2.31e-18
      9         1 inclusion       3 13C/12C        0.0111   17.7     2.31e-11
      # ... with 4 more variables: `$\\hat{\\bar{R}}$` <dbl>,
      #   `$\\hat{\\epsilon}_{\\bar{R}}$ (\\text{\\textperthousand})` <dbl>,
      #   `$\\Delta AIC_{\\bar{R}}$` <dbl>, `$p_{\\bar{R}}$` <dbl>

---

    Code
      dplyr::distinct(tb_sig, type.nm, trend.nm, force.nm, spot.nm, .keep_all = TRUE)
    Output
      # A tibble: 9 x 9
        execution type.nm   trend.nm force.nm spot.nm ratio.nm M_R_Xt.pr F_R_Xt.pr
            <dbl> <chr>        <dbl>    <dbl>   <int> <chr>        <dbl>     <dbl>
      1         1 gradient       120      -60       1 13C/12C     0.0104    85.8  
      2         1 gradient       120      -60       2 13C/12C     0.0106   112.   
      3         1 gradient       120      -60       3 13C/12C     0.0104   113.   
      4         1 ideal          120      -60       1 13C/12C     0.0112     0.300
      5         1 ideal          120      -60       2 13C/12C     0.0110     0.948
      6         1 ideal          120      -60       3 13C/12C     0.0111     0.736
      7         1 inclusion      120      -60       1 13C/12C     0.0114    20.9  
      8         1 inclusion      120      -60       2 13C/12C     0.0115    41.0  
      9         1 inclusion      120      -60       3 13C/12C     0.0111    27.6  
      # ... with 1 more variable: p_R_Xt.pr <dbl>

# QQ diagnostic on synthetic data is consistent

    Code
      diag_R(simu_IC, "13C", "12C", type.nm, spot.nm, .method = "QQ")
    Output
      # A tibble: 9 x 3
        type.nm   spot.nm hyp            
        <chr>       <int> <chr>          
      1 gradient        1 H0 (normal)    
      2 gradient        2 H0 (normal)    
      3 gradient        3 Ha (non-normal)
      4 inclusion       1 H0 (normal)    
      5 inclusion       2 H0 (normal)    
      6 inclusion       3 H0 (normal)    
      7 ideal           1 H0 (normal)    
      8 ideal           2 H0 (normal)    
      9 ideal           3 H0 (normal)    

# IR diagnostic on synthetic data is consistent

    Code
      diag_R(simu_IC, "13C", "12C", type.nm, spot.nm, .method = "IR")
    Output
      # A tibble: 9 x 3
        type.nm   spot.nm hyp                           
        <chr>       <int> <chr>                         
      1 gradient        1 Ha (dependence of residuals)  
      2 gradient        2 Ha (dependence of residuals)  
      3 gradient        3 Ha (dependence of residuals)  
      4 inclusion       1 Ha (dependence of residuals)  
      5 inclusion       2 Ha (dependence of residuals)  
      6 inclusion       3 Ha (dependence of residuals)  
      7 ideal           1 H0 (independence of residuals)
      8 ideal           2 Ha (dependence of residuals)  
      9 ideal           3 H0 (independence of residuals)

# diagnostics preserve metadata

    Code
      diag_R(real_IC, "13C", "12C", file.nm)
    Output
      # A tibble: 3 x 6
        execution file.nm                ratio.nm M_R_Xt.pr F_R_Xt.pr p_R_Xt.pr
            <dbl> <chr>                  <chr>        <dbl>     <dbl>     <dbl>
      1         1 2018-01-19-GLENDON_1_1 13C/12C     0.0110     0.564  6.89e- 1
      2         1 2018-01-19-GLENDON_1_2 13C/12C     0.0110    10.9    3.94e- 7
      3         1 2018-01-19-GLENDON_1_3 13C/12C     0.0110    30.2    2.57e-19

---

    Code
      unfold(diag_R(real_IC, "13C", "12C", file.nm, .meta = TRUE))
    Output
      # A tibble: 81,900 x 43
         execution file.nm     ratio.nm M_R_Xt.pr F_R_Xt.pr p_R_Xt.pr  t.nm species.nm
             <dbl> <chr>       <chr>        <dbl>     <dbl>     <dbl> <dbl> <chr>     
       1         1 2018-01-19~ 13C/12C     0.0110     0.564     0.689  0.54 12C       
       2         1 2018-01-19~ 13C/12C     0.0110     0.564     0.689  1.08 12C       
       3         1 2018-01-19~ 13C/12C     0.0110     0.564     0.689  1.62 12C       
       4         1 2018-01-19~ 13C/12C     0.0110     0.564     0.689  2.16 12C       
       5         1 2018-01-19~ 13C/12C     0.0110     0.564     0.689  2.7  12C       
       6         1 2018-01-19~ 13C/12C     0.0110     0.564     0.689  3.24 12C       
       7         1 2018-01-19~ 13C/12C     0.0110     0.564     0.689  3.78 12C       
       8         1 2018-01-19~ 13C/12C     0.0110     0.564     0.689  4.32 12C       
       9         1 2018-01-19~ 13C/12C     0.0110     0.564     0.689  4.86 12C       
      10         1 2018-01-19~ 13C/12C     0.0110     0.564     0.689  5.4  12C       
      # ... with 81,890 more rows, and 35 more variables: sample.nm <chr>,
      #   bl.nm <int>, num.mt <dbl>, bfield.mt <dbl>, rad.mt <dbl>, mass.mt <chr>,
      #   tc.mt <dbl>, coord.mt <chr>, file_raw.mt <chr>, bl_num.mt <dbl>,
      #   meas_bl.mt <dbl>, rejection.mt <dbl>, slit.mt <chr>, lens.mt <chr>,
      #   presput.mt <chr>, rast_com.mt <dbl>, frame.mt <chr>, blank_rast.mt <chr>,
      #   raster.mt <chr>, tune.mt <chr>, reg_mode.mt <chr>, chk_frm.mt <dbl>,
      #   sec_ion_cent.mt <chr>, frame_sec_ion_cent.mt <chr>, width_hor.mt <dbl>, ...

