# precision estimates on internal dataset are consistent

    Code
      stat_X(real_IC, file.nm)
    Output
      # A tibble: 21 x 12
         file.nm         species.nm n_t.nm tot_N.pr M_Xt.pr S_Xt.pr RS_Xt.pr SeM_Xt.pr
         <chr>           <chr>       <int>    <dbl>   <dbl>   <dbl>    <dbl>     <dbl>
       1 2018-01-19-GLE~ 12C          3900 41718475  3.06e4 2738.       8.94   43.8   
       2 2018-01-19-GLE~ 12C13C       3900    15254  1.12e1    9.17    81.9     0.147 
       3 2018-01-19-GLE~ 12C14N       3900   511093  3.75e2  220.      58.7     3.53  
       4 2018-01-19-GLE~ 12C2         3900   686187  5.04e2  341.      67.7     5.46  
       5 2018-01-19-GLE~ 13C          3900   458139  3.36e2   42.5     12.6     0.680 
       6 2018-01-19-GLE~ 13C14N       3900     9158  6.72e0    5.63    83.8     0.0902
       7 2018-01-19-GLE~ 40Ca16O      3900 18082538  1.33e4 1856.      14.0    29.7   
       8 2018-01-19-GLE~ 12C          3900 72956119  5.35e4 4073.       7.61   65.2   
       9 2018-01-19-GLE~ 12C13C       3900    10786  7.92e0    7.48    94.4     0.120 
      10 2018-01-19-GLE~ 12C14N       3900   362709  2.66e2  114.      42.9     1.83  
      # ... with 11 more rows, and 4 more variables: hat_S_N.pr <dbl>,
      #   hat_RS_N.pr <dbl>, hat_SeM_N.pr <dbl>, chi2_N.pr <dbl>

---

    Code
      stat_X(real_IC, file.nm, .label = "latex")
    Output
      # A tibble: 21 x 12
         file.nm  species.nm `$n$` `$N_{tot}$` `$\\bar{X}$` `$s_{X}$` `$\\epsilon_{X~`
         <chr>    <chr>      <int>       <dbl>        <dbl>     <dbl>            <dbl>
       1 2018-01~ "${}^{12}~  3900    41718475     30616.     2738.               8.94
       2 2018-01~ "${}^{12}~  3900       15254        11.2       9.17            81.9 
       3 2018-01~ "${}^{12}~  3900      511093       375.      220.              58.7 
       4 2018-01~ "${}^{12}~  3900      686187       504.      341.              67.7 
       5 2018-01~ "${}^{13}~  3900      458139       336.       42.5             12.6 
       6 2018-01~ "${}^{13}~  3900        9158         6.72      5.63            83.8 
       7 2018-01~ "${}^{40}~  3900    18082538     13270.     1856.              14.0 
       8 2018-01~ "${}^{12}~  3900    72956119     53541.     4073.               7.61
       9 2018-01~ "${}^{12}~  3900       10786         7.92      7.48            94.4 
      10 2018-01~ "${}^{12}~  3900      362709       266.      114.              42.9 
      # ... with 11 more rows, and 5 more variables: `$s_{\\bar{X}}$` <dbl>,
      #   `$\\hat{s}_{N}$` <dbl>,
      #   `$\\hat{\\epsilon}_{N}$ (\\text{\\textperthousand})` <dbl>,
      #   `$\\hat{s}_{\\bar{N}}$` <dbl>, `$\\chi^{2}_{N}$` <dbl>

---

    Code
      stat_R(real_IC, "13C", "12C", file.nm, .zero = TRUE)
    Output
      # A tibble: 3 x 13
        file.nm       n_R_t.nm M_R_Xt.pr S_R_Xt.pr RS_R_Xt.pr SeM_R_Xt.pr RSeM_R_Xt.pr
        <chr>            <int>     <dbl>     <dbl>      <dbl>       <dbl>        <dbl>
      1 2018-01-19-G~     3900    0.0110  0.00102        93.0   0.0000163         1.49
      2 2018-01-19-G~     3900    0.0110  0.000779       70.8   0.0000125         1.13
      3 2018-01-19-G~     3900    0.0110  0.000733       66.5   0.0000117         1.06
      # ... with 6 more variables: hat_S_R_N.pr <dbl>, hat_RS_R_N.pr <dbl>,
      #   hat_SeM_R_N.pr <dbl>, hat_RSeM_R_N.pr <dbl>, chi2_R_N.pr <dbl>,
      #   ratio.nm <chr>

---

    Code
      stat_R(real_IC, "13C", "12C", file.nm, .zero = TRUE, .label = "latex")
    Output
      # A tibble: 3 x 13
        file.nm                ratio.nm `$n$` `$\\bar{R}$` `$s_{R}$` `$\\epsilon_{R}~`
        <chr>                  <chr>    <int>        <dbl>     <dbl>             <dbl>
      1 2018-01-19-GLENDON_1_1 13C/12C   3900       0.0110  0.00102               93.0
      2 2018-01-19-GLENDON_1_2 13C/12C   3900       0.0110  0.000779              70.8
      3 2018-01-19-GLENDON_1_3 13C/12C   3900       0.0110  0.000733              66.5
      # ... with 7 more variables: `$s_{\\bar{R}}$` <dbl>,
      #   `$\\epsilon_{\\bar{R}}$ (\\text{\\textperthousand})` <dbl>,
      #   `$\\hat{s}_{R}$` <dbl>,
      #   `$\\hat{\\epsilon}_{R}$ (\\text{\\textperthousand})` <dbl>,
      #   `$\\hat{s}_{\\bar{R}}$` <dbl>,
      #   `$\\hat{\\epsilon}_{\\bar{R}}$ (\\text{\\textperthousand})` <dbl>,
      #   `$\\chi^{2}_{R}$` <dbl>

---

    Code
      stat_R(real_IC, "13C", "12C", sample.nm, file.nm, .nest = file.nm, .zero = TRUE,
        .label = "latex", .stat = c("M", "RS"))
    Output
      # A tibble: 1 x 4
        sample.nm        ratio.nm `$\\bar{\\bar{R}}$` `$\\epsilon_{\\bar{R}}$ (\\tex~`
        <chr>            <chr>                  <dbl>                            <dbl>
      1 Belemnite,Indium 13C/12C               0.0110                             1.85

---

    Code
      stat_R(real_IC, "13C", "12C", sample.nm, file.nm, .nest = file.nm, .zero = TRUE)
    Output
      # A tibble: 1 x 13
        sample.nm        n_R_t.nm M_R_M_Xt.pr S_R_M_Xt.pr RS_R_M_Xt.pr SeM_R_M_Xt.pr
        <chr>               <int>       <dbl>       <dbl>        <dbl>         <dbl>
      1 Belemnite,Indium        3      0.0110   0.0000203         1.85     0.0000117
      # ... with 7 more variables: RSeM_R_M_Xt.pr <dbl>, hat_S_R_tot_N.pr <dbl>,
      #   hat_RS_R_tot_N.pr <dbl>, hat_SeM_R_tot_N.pr <dbl>,
      #   hat_RSeM_R_tot_N.pr <dbl>, chi2_R_tot_N.pr <dbl>, ratio.nm <chr>

---

    Code
      stat_R(real_IC, "13C", "12C", sample.nm, file.nm, .nest = file.nm, .zero = TRUE,
        .label = "latex", .stat = c("M", "RS"))
    Output
      # A tibble: 1 x 4
        sample.nm        ratio.nm `$\\bar{\\bar{R}}$` `$\\epsilon_{\\bar{R}}$ (\\tex~`
        <chr>            <chr>                  <dbl>                            <dbl>
      1 Belemnite,Indium 13C/12C               0.0110                             1.85

