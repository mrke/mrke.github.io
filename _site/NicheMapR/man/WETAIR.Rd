% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/WETAIR.R
\name{WETAIR}
\alias{WETAIR}
\title{WETAIR}
\usage{
WETAIR(db = db, wb = db, rh = 0, dp = 999, bp = 101325)
}
\arguments{
\item{db}{Dry bulb temperature (degrees C)}

\item{wb}{Wet bulb temperature (degrees C)}

\item{rh}{Relative humidity (\%)}

\item{dp}{Dew point temperature (degrees C)}

\item{bp}{Barometric pressure (pascal)}
}
\value{
e Vapour pressure (Pa)

esat Saturation vapour pressure (Pa)

vd Vapour density (kg m-3)

rw Mixing ratio (kg kg-1)

tvir Virtual temperature (K)

tvinc Virtual temperature increment (K)

denair Hourly predictions of the soil moisture under the maximum specified shade

cp Specific heat of air at constant pressure (J kg-1 K-1)

wtrpot Water potential (Pa)

Relative humidity (\%)
}
\description{
Calculates several properties of humid air as output variables below. The program
is based on equations from List, R. J. 1971. Smithsonian Meteorological Tables. Smithsonian
Institution Press. Washington, DC. WETAIR must be used in conjunction with function VAPPRS.
}
\details{
Input variables are shown below. The user must supply known values for db and bp (bp at one standard
atmosphere is 101 325 pascals). Values for the remaining variables are determined by whether the user has
either (1) psychrometric data (wb or rh), or (2) hygrometric data (dp)

(1) Psychrometric data:
If wb is known but not rh, then set rh=-1 and dp=999
If rh is known but not wb then set wb=0 and dp=999

(2) Hygrometric data:
If dp is known then set wb = 0 and rh = 0.
}
