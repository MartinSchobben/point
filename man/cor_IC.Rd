% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/process_IC.R
\name{cor_IC}
\alias{cor_IC}
\title{Process raw ion count data}
\usage{
cor_IC(
  .IC,
  ...,
  .N = NULL,
  .t = NULL,
  .bl_t = NULL,
  .det = NULL,
  .deadtime = NULL,
  .thr_PHD = NULL,
  .M_PHD = NULL,
  .SD_PHD = NULL,
  .hide = TRUE
)
}
\arguments{
\item{.IC}{A tibble containing raw ion count data.}

\item{...}{Currently not supported.}

\item{.N}{A variable constituting the ion counts.}

\item{.t}{A variable constituting the time increments.}

\item{.bl_t}{A variable or numeric value for the blanking time
(in milliseconds).}

\item{.det}{Variable or character string or variable for the detection
system ("EM" or "FC").}

\item{.deadtime}{A numeric value for the deadtime of the EM system with
units nanoseconds.}

\item{.thr_PHD}{A numeric value for the discriminator threshold of the EM.
system.}

\item{.M_PHD}{A variable or numeric value of the mean PHD value.}

\item{.SD_PHD}{A variable or numeric value of standard deviation of
the PHD value.}

\item{.hide}{A logical indicating whether only processed data should be
 returned. If \code{TRUE} The raw data is contained as an attribute named
\code{"rawdata"}.}
}
\value{
A \code{tibble::\link[tibble:tibble]{tibble}()} containing the
 original dataset and adds the variables: \code{Xt.rw}, ion count rates
 uncorrected for detection device-specific biases; \code{Xt.pr}, ion count
 rates corrected for detection device-specific biases; and \code{N.pr},
 counts corrected for detection device-specific biases.
}
\description{
\code{cor_IC} function for processing ion count data.
}
\details{
The accuracy of pulsed ion counting is influenced by systematic errors which
depend on the ion counting system. Deadtime and EM yield are two
prominent effects for the electron multiplier systems. The deadtime refer to
the timewindow when the system does not register counts; this occurs when
incident ions strike the EM in a small enough time window in which the EM
channel is electronically paralysed. The EM yield is the ratio between the
number of output pulses counted after the EM  discriminator threshold and
the number of ions arriving at the EM. The latter can be gauged with the peak
height distribution (PHD) which is the probability for an EM output to have a
certain voltage amplitude.
}
\examples{
# Use point_example() to access the examples bundled with this package

# raw data containing 13C and 12C counts on carbonate
tb_rw <- read_IC(point_example("2018-01-19-GLENDON"))

# Processing raw ion count data
cor_IC(tb_rw)
}
