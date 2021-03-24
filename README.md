
<!--  use the --webtex argument in the YAML to render equations -->

<!-- badges: start -->

[![License: GPL
v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0)
[![DOI](https://zenodo.org/badge/240023228.svg)](https://zenodo.org/badge/latestdoi/240023228)
[![Travis build
status](https://travis-ci.org/MartinSchobben/point.svg?branch=master)](https://travis-ci.org/MartinSchobben/point)
<!-- badges: end -->

# Introduction to point

This project was originally inspired by the lack of detailed insight in
the inner workings of the default software for the *Cameca NanoSIMS50L*
(Utrecht University). Hence this project has the objective of processing
raw ion count data into ion and isotope ratios of point-sourced
measurements. Combined with statistics for the internal and external
precision of, respectively, individual analyses and complete series of
analyses, this functionality allows for the interrogation of the
analytical consistency. Access to raw ion count data is, furthermore,
useful as it allows detection of anomalous values associated with
e.g. machine instability or heterogeneity of the analysed sample. Upon
detection, anomalous values can be omitted or further analysed to
delineate the source of variation.

The point package is still under development but the master branch is
functioning. Functionality is automatically tested with Travis CI.

## Credits

The construction of the R (R Core Team 2020) package *point* and
associated documentation was aided by the packages; *devtools* (Wickham,
Hester, and Chang 2020), *roxygen2* (Wickham, Danenberg, et al. 2020),
*testthat* (Wickham 2020a), *knitr* (Xie 2014 , 2015), *rmarkdown* (Xie,
Allaire, and Grolemund 2018; Xie, Dervieux, and Riederer 2020),
*bookdown* (Xie 2016) and the superb guidance in the book: *R packages:
organize, test, document, and share your code*, by Wickham (2015). In
addition, this package relies on a set of external packages from the
tidyverse universe, including: *dplyr* (Wickham et al. 2021), *tidyr*
(Wickham 2020b), *tibble* (Müller and Wickham 2021), *stringr* (Wickham
2019), *readr* (Wickham and Hester 2020), *magrittr* (Bache and Wickham
2020), *ggplot2* (Wickham, Chang, et al. 2020), *rlang* (Henry and
Wickham 2020b), and *purrr* (Henry and Wickham 2020a) for internal
functioning as well as specialised statistics; *polyaAeppli* (Burden
2014). Plots are made with *ggplot2* (Wickham 2016)

## Installation

You can install the released version of point

``` r
# Install point from GitHub:
# install.packages("devtools")
devtools::install_github("MartinSchobben/point")
```

## Usage

Load point with `library`.

``` r
library(point)
```

## The point workflow

A more detailed outline of the general point workflow is given in the
vignette *IC-introduction* (`vignette("IC-introduction")`).

<img src="vignettes/workflow.png" width="100%" />

To read, process and analyse raw ion count data use the functions:

  - `read_IC`: raw ion count data
  - `cor_IC`: process ion count data
  - `stat_Xt`: analyse single ion count data
  - `stat_R`: analyse ion ratios

## Example 1: internal precision of isotope ratios

This is an example of how *Cameca NanoSIMS50L* raw data files can be
extracted, processed and analysed for the <sup>13</sup>C/<sup>12</sup>C
isotope ratio (![R](http://chart.apis.google.com/chart?cht=tx&chl=R
"R")). This produces a [tibble](https://tibble.tidyverse.org/) with
descriptive and predictive (Poisson) statistics (demarcated with an ^)
of the ion count data. This can be done for single analysis in order to
obtain internal precision.

``` r
# Use point_example() to access the examples bundled with this package in the
# inst/extdata directory.

# Raw data containing 13C and 12C counts on carbonate
tb_rw <- read_IC(point_example("2018-01-19-GLENDON"))

# Processing raw ion count data
tb_pr <- cor_IC(tb_rw)

# Internal precision for 13C/12C ratios
tb_R <- stat_R(tb_pr, "13C", "12C", sample.nm, file.nm, .label = "webtex")
```

| sample.nm         | file.nm                  | ratio.nm                                                                                                                                                                                                                                                                                                                                                                                | ![n](http://chart.apis.google.com/chart?cht=tx&chl=n "n") | ![\\bar{R}](http://chart.apis.google.com/chart?cht=tx&chl=%5Cbar%7BR%7D "\\bar{R}") | ![s\_{R}](http://chart.apis.google.com/chart?cht=tx&chl=s_%7BR%7D "s_{R}") | ![\\epsilon\_{R}](http://chart.apis.google.com/chart?cht=tx&chl=%5Cepsilon_%7BR%7D "\\epsilon_{R}") (‰) | ![s\_{\\bar{R}}](http://chart.apis.google.com/chart?cht=tx&chl=s_%7B%5Cbar%7BR%7D%7D "s_{\\bar{R}}") | ![\\epsilon\_{\\bar{R}}](http://chart.apis.google.com/chart?cht=tx&chl=%5Cepsilon_%7B%5Cbar%7BR%7D%7D "\\epsilon_{\\bar{R}}") (‰) | ![\\hat{s}\_{R}](http://chart.apis.google.com/chart?cht=tx&chl=%5Chat%7Bs%7D_%7BR%7D "\\hat{s}_{R}") | ![\\hat{\\epsilon}\_{R}](http://chart.apis.google.com/chart?cht=tx&chl=%5Chat%7B%5Cepsilon%7D_%7BR%7D "\\hat{\\epsilon}_{R}") (‰) | ![\\hat{s}\_{\\bar{R}}](http://chart.apis.google.com/chart?cht=tx&chl=%5Chat%7Bs%7D_%7B%5Cbar%7BR%7D%7D "\\hat{s}_{\\bar{R}}") | ![\\hat{\\epsilon}\_{\\bar{R}}](http://chart.apis.google.com/chart?cht=tx&chl=%5Chat%7B%5Cepsilon%7D_%7B%5Cbar%7BR%7D%7D "\\hat{\\epsilon}_{\\bar{R}}") (‰) | ![\\chi^{2}\_{R}](http://chart.apis.google.com/chart?cht=tx&chl=%5Cchi%5E%7B2%7D_%7BR%7D "\\chi^{2}_{R}") |
| :---------------- | :----------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------: | ----------------------------------------------------------------------------------: | -------------------------------------------------------------------------: | ------------------------------------------------------------------------------------------------------: | ---------------------------------------------------------------------------------------------------: | --------------------------------------------------------------------------------------------------------------------------------: | ---------------------------------------------------------------------------------------------------: | --------------------------------------------------------------------------------------------------------------------------------: | -----------------------------------------------------------------------------------------------------------------------------: | ----------------------------------------------------------------------------------------------------------------------------------------------------------: | --------------------------------------------------------------------------------------------------------: |
| Belemnite, Indium | 2018-01-19-GLENDON\_1\_1 | ![\\phantom{,}^{13}](http://chart.apis.google.com/chart?cht=tx&chl=%5Cphantom%7B%2C%7D%5E%7B13%7D "\\phantom{,}^{13}")C![\_{}](http://chart.apis.google.com/chart?cht=tx&chl=_%7B%7D "_{}")/![\\phantom{,}^{12}](http://chart.apis.google.com/chart?cht=tx&chl=%5Cphantom%7B%2C%7D%5E%7B12%7D "\\phantom{,}^{12}")C![\_{}](http://chart.apis.google.com/chart?cht=tx&chl=_%7B%7D "_{}") |                                                      3900 |                                                                               0.011 |                                                                   0.001021 |                                                                                                    93.0 |                                                                                             1.63e-05 |                                                                                                                              1.49 |                                                                                             0.001019 |                                                                                                                              92.8 |                                                                                                                       1.63e-05 |                                                                                                                                                        1.49 |                                                                                                      1.00 |
| Belemnite, Indium | 2018-01-19-GLENDON\_1\_2 | ![\\phantom{,}^{13}](http://chart.apis.google.com/chart?cht=tx&chl=%5Cphantom%7B%2C%7D%5E%7B13%7D "\\phantom{,}^{13}")C![\_{}](http://chart.apis.google.com/chart?cht=tx&chl=_%7B%7D "_{}")/![\\phantom{,}^{12}](http://chart.apis.google.com/chart?cht=tx&chl=%5Cphantom%7B%2C%7D%5E%7B12%7D "\\phantom{,}^{12}")C![\_{}](http://chart.apis.google.com/chart?cht=tx&chl=_%7B%7D "_{}") |                                                      3900 |                                                                               0.011 |                                                                   0.000779 |                                                                                                    70.8 |                                                                                             1.25e-05 |                                                                                                                              1.13 |                                                                                             0.000771 |                                                                                                                              70.1 |                                                                                                                       1.23e-05 |                                                                                                                                                        1.12 |                                                                                                      1.02 |
| Belemnite, Indium | 2018-01-19-GLENDON\_1\_3 | ![\\phantom{,}^{13}](http://chart.apis.google.com/chart?cht=tx&chl=%5Cphantom%7B%2C%7D%5E%7B13%7D "\\phantom{,}^{13}")C![\_{}](http://chart.apis.google.com/chart?cht=tx&chl=_%7B%7D "_{}")/![\\phantom{,}^{12}](http://chart.apis.google.com/chart?cht=tx&chl=%5Cphantom%7B%2C%7D%5E%7B12%7D "\\phantom{,}^{12}")C![\_{}](http://chart.apis.google.com/chart?cht=tx&chl=_%7B%7D "_{}") |                                                      3900 |                                                                               0.011 |                                                                   0.000733 |                                                                                                    66.5 |                                                                                             1.17e-05 |                                                                                                                              1.06 |                                                                                             0.000722 |                                                                                                                              65.5 |                                                                                                                       1.16e-05 |                                                                                                                                                        1.05 |                                                                                                      1.03 |

## Example 2: external precision of isotope ratios

To calculate the external reproducibility of isotope ratios one needs to
use the total ion counts and count rate of one analysis. The latter is
equivalent to the mean ion count rate, which can be calculated with the
function `stat_Xt`.

``` r
# external precision for 13C/12C ratios
tb_R <- stat_R(tb_pr, "13C", "12C", sample.nm, file.nm, .nest = sample.nm, 
               .label = "webtex")
```

| sample.nm         | ratio.nm                                                                                                                                                                                                                                                                                                                                                                                | ![n](http://chart.apis.google.com/chart?cht=tx&chl=n "n") | ![\\bar{\\bar{R}}](http://chart.apis.google.com/chart?cht=tx&chl=%5Cbar%7B%5Cbar%7BR%7D%7D "\\bar{\\bar{R}}") | ![s\_{\\bar{R}}](http://chart.apis.google.com/chart?cht=tx&chl=s_%7B%5Cbar%7BR%7D%7D "s_{\\bar{R}}") | ![\\epsilon\_{\\bar{R}}](http://chart.apis.google.com/chart?cht=tx&chl=%5Cepsilon_%7B%5Cbar%7BR%7D%7D "\\epsilon_{\\bar{R}}") (‰) | ![s\_{\\bar{\\bar{R}}}](http://chart.apis.google.com/chart?cht=tx&chl=s_%7B%5Cbar%7B%5Cbar%7BR%7D%7D%7D "s_{\\bar{\\bar{R}}}") | ![\\epsilon\_{\\bar{\\bar{R}}}](http://chart.apis.google.com/chart?cht=tx&chl=%5Cepsilon_%7B%5Cbar%7B%5Cbar%7BR%7D%7D%7D "\\epsilon_{\\bar{\\bar{R}}}") (‰) | ![\\hat{s}\_{\\bar{R}}](http://chart.apis.google.com/chart?cht=tx&chl=%5Chat%7Bs%7D_%7B%5Cbar%7BR%7D%7D "\\hat{s}_{\\bar{R}}") | ![\\hat{\\epsilon}\_{\\bar{R}}](http://chart.apis.google.com/chart?cht=tx&chl=%5Chat%7B%5Cepsilon%7D_%7B%5Cbar%7BR%7D%7D "\\hat{\\epsilon}_{\\bar{R}}") (‰) | ![\\hat{s}\_{\\bar{\\bar{R}}}](http://chart.apis.google.com/chart?cht=tx&chl=%5Chat%7Bs%7D_%7B%5Cbar%7B%5Cbar%7BR%7D%7D%7D "\\hat{s}_{\\bar{\\bar{R}}}") | ![\\hat{\\epsilon}\_{\\bar{\\bar{R}}}](http://chart.apis.google.com/chart?cht=tx&chl=%5Chat%7B%5Cepsilon%7D_%7B%5Cbar%7B%5Cbar%7BR%7D%7D%7D "\\hat{\\epsilon}_{\\bar{\\bar{R}}}") (‰) | ![\\chi^{2}\_{\\bar{R}}](http://chart.apis.google.com/chart?cht=tx&chl=%5Cchi%5E%7B2%7D_%7B%5Cbar%7BR%7D%7D "\\chi^{2}_{\\bar{R}}") |
| :---------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------: | ------------------------------------------------------------------------------------------------------------: | ---------------------------------------------------------------------------------------------------: | --------------------------------------------------------------------------------------------------------------------------------: | -----------------------------------------------------------------------------------------------------------------------------: | ----------------------------------------------------------------------------------------------------------------------------------------------------------: | -----------------------------------------------------------------------------------------------------------------------------: | ----------------------------------------------------------------------------------------------------------------------------------------------------------: | -------------------------------------------------------------------------------------------------------------------------------------------------------: | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | ----------------------------------------------------------------------------------------------------------------------------------: |
| Belemnite, Indium | ![\\phantom{,}^{13}](http://chart.apis.google.com/chart?cht=tx&chl=%5Cphantom%7B%2C%7D%5E%7B13%7D "\\phantom{,}^{13}")C![\_{}](http://chart.apis.google.com/chart?cht=tx&chl=_%7B%7D "_{}")/![\\phantom{,}^{12}](http://chart.apis.google.com/chart?cht=tx&chl=%5Cphantom%7B%2C%7D%5E%7B12%7D "\\phantom{,}^{12}")C![\_{}](http://chart.apis.google.com/chart?cht=tx&chl=_%7B%7D "_{}") |                                                         3 |                                                                                                         0.011 |                                                                                             2.03e-05 |                                                                                                                              1.85 |                                                                                                                       1.17e-05 |                                                                                                                                                        1.07 |                                                                                                                        1.3e-05 |                                                                                                                                                        1.18 |                                                                                                                                                  7.5e-06 |                                                                                                                                                                                 0.681 |                                                                                                                                2.45 |

For more detailed information:

*IC-read* (`vignette("IC-read")`): reading raw ion count data use  
*IC-process* (`vignette("IC-process")`): processing ion count data  
*IC-precision* (`vignette("IC-precision")`): statistics concerning ion
count precision  
*IC-diagnostics* (`vignette("IC-diagnostics")`): diagnostics on internal
variation

# References

<div id="refs" class="references">

<div id="ref-magrittr">

Bache, Stefan Milton, and Hadley Wickham. 2020. *Magrittr: A
Forward-Pipe Operator for R*.
<https://CRAN.R-project.org/package=magrittr>.

</div>

<div id="ref-polyaAeppli">

Burden, Conrad. 2014. *PolyaAeppli: Implementation of the Polya-Aeppli
Distribution*. <https://CRAN.R-project.org/package=polyaAeppli>.

</div>

<div id="ref-purrr">

Henry, Lionel, and Hadley Wickham. 2020a. *Purrr: Functional Programming
Tools*. <https://CRAN.R-project.org/package=purrr>.

</div>

<div id="ref-rlang">

———. 2020b. *Rlang: Functions for Base Types and Core R and Tidyverse
Features*. <https://CRAN.R-project.org/package=rlang>.

</div>

<div id="ref-tibble">

Müller, Kirill, and Hadley Wickham. 2021. *Tibble: Simple Data Frames*.
<https://CRAN.R-project.org/package=tibble>.

</div>

<div id="ref-rversion">

R Core Team. 2020. *R: A Language and Environment for Statistical
Computing*. Vienna, Austria: R Foundation for Statistical Computing.
<https://www.R-project.org/>.

</div>

<div id="ref-Wickham2015">

Wickham, Hadley. 2015. *R Packages: Organize, Test, Document, and Share
Your Code*. O’Reilly Media, Inc. <https://r-pkgs.org/>.

</div>

<div id="ref-ggplot22016">

———. 2016. *Ggplot2: Elegant Graphics for Data Analysis*.
Springer-Verlag New York. <https://ggplot2.tidyverse.org>.

</div>

<div id="ref-stringr">

———. 2019. *Stringr: Simple, Consistent Wrappers for Common String
Operations*. <https://CRAN.R-project.org/package=stringr>.

</div>

<div id="ref-testthat">

———. 2020a. *Testthat: Unit Testing for R*.
<https://CRAN.R-project.org/package=testthat>.

</div>

<div id="ref-tidyr">

———. 2020b. *Tidyr: Tidy Messy Data*.
<https://CRAN.R-project.org/package=tidyr>.

</div>

<div id="ref-ggplot2">

Wickham, Hadley, Winston Chang, Lionel Henry, Thomas Lin Pedersen,
Kohske Takahashi, Claus Wilke, Kara Woo, Hiroaki Yutani, and Dewey
Dunnington. 2020. *Ggplot2: Create Elegant Data Visualisations Using the
Grammar of Graphics*. <https://CRAN.R-project.org/package=ggplot2>.

</div>

<div id="ref-roxygen2">

Wickham, Hadley, Peter Danenberg, Gábor Csárdi, and Manuel Eugster.
2020. *Roxygen2: In-Line Documentation for R*.
<https://CRAN.R-project.org/package=roxygen2>.

</div>

<div id="ref-dplyr">

Wickham, Hadley, Romain François, Lionel Henry, and Kirill Müller. 2021.
*Dplyr: A Grammar of Data Manipulation*.
<https://CRAN.R-project.org/package=dplyr>.

</div>

<div id="ref-readr">

Wickham, Hadley, and Jim Hester. 2020. *Readr: Read Rectangular Text
Data*. <https://CRAN.R-project.org/package=readr>.

</div>

<div id="ref-devtools">

Wickham, Hadley, Jim Hester, and Winston Chang. 2020. *Devtools: Tools
to Make Developing R Packages Easier*.
<https://CRAN.R-project.org/package=devtools>.

</div>

<div id="ref-knitr2014">

Xie, Yihui. 2014. “Knitr: A Comprehensive Tool for Reproducible Research
in R.” In *Implementing Reproducible Computational Research*, edited by
Victoria Stodden, Friedrich Leisch, and Roger D. Peng. Chapman;
Hall/CRC. <http://www.crcpress.com/product/isbn/9781466561595>.

</div>

<div id="ref-knitr2015">

———. 2015. *Dynamic Documents with R and Knitr*. 2nd ed. Boca Raton,
Florida: Chapman; Hall/CRC. <https://yihui.org/knitr/>.

</div>

<div id="ref-bookdown2016">

———. 2016. *Bookdown: Authoring Books and Technical Documents with R
Markdown*. Boca Raton, Florida: Chapman; Hall/CRC.
<https://github.com/rstudio/bookdown>.

</div>

<div id="ref-rmarkdown2018">

Xie, Yihui, J. J. Allaire, and Garrett Grolemund. 2018. *R Markdown: The
Definitive Guide*. Boca Raton, Florida: Chapman; Hall/CRC.
<https://bookdown.org/yihui/rmarkdown>.

</div>

<div id="ref-rmarkdown2020">

Xie, Yihui, Christophe Dervieux, and Emily Riederer. 2020. *R Markdown
Cookbook*. Boca Raton, Florida: Chapman; Hall/CRC.
<https://bookdown.org/yihui/rmarkdown-cookbook>.

</div>

</div>
