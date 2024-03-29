% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc_utils.R
\name{ion_labeller}
\alias{ion_labeller}
\alias{R_labeller}
\alias{stat_labeller}
\title{Chemical species names for plots and tables}
\usage{
ion_labeller(ion, label = "latex")

R_labeller(ion1, ion2, label = "latex")

stat_labeller(var, org, stat, value, label = "latex")
}
\arguments{
\item{ion}{A chemical species character string}

\item{label}{Character string indicating whether the output should be
\code{"latex"} or an expression (\code{"expr"}).}

\item{ion1}{A chemical species character string (for isotope ratios the rare
isotope).}

\item{ion2}{A chemical species character string (for isotope ratios the
common isotope).}

\item{var}{A character string for the variable, either \code{"X"} for single
ions or \code{"R"} for ion ratios.}

\item{org}{A character string for the origin of a derived variable, e.g., R.}

\item{stat}{A character string for the statistic following convention of e.g.
\code{point::names_stat_X}.}

\item{value}{The numeric value for the statistic result.}
}
\value{
A character string parsable in Latex or expression for usage in
plots.
}
\description{
\code{ion_labeller} and \code{R_labeller} converts a character string
containing chemical species names in a latex string or expression. The
\code{stat_labeller} function generates labels for statistics in tables
(latex) or on plots (expressions).
}
\details{
This functions converts chemical species names of the form, e.g. `"12C"`,
`"13C2"`, `"12C 14N"`, or `"12C-14N"` to a character string which can be
parsed in Latex to species names with appropriate superscripts on th left for
mass and subscripts for the index on the right.
}
\examples{
# plot some ion count data
library(ggplot2)
ggplot() +
 geom_blank() +
 ylab(ion_labeller("12C2-40Ca", "expr")) +
 xlab(R_labeller("12C2-40Ca", "13C2-40Ca", "expr"))

}
