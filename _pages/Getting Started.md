---
title: "Getting Started"
layout: single
permalink: /getting_started/
---

<h1> Community </h1>

To discuss ideas and problems with the NicheMapR community, join the NicheMapR <a href="https://groups.google.com/forum/#!forum/nichemapr">Google Group</a>

<h1> Installation </h1>

<h2> From latest release </h2>

To install the latest release of NicheMapR, go to the <a href="https://github.com/mrke/NicheMapR/releases">NicheMapR releases</a> page, download the latest release and do the following, replacing "path to file" and "NicheMapR_x.x.x" accordingly:

Windows:

~~~ R
install.packages("path to file/NicheMapR_x.x.x.zip", repos = NULL, 
  type = "win.binary")
~~~

Mac/Linux:

~~~ R
install.packages("path to file/NicheMapR_x.x.x.tgz", repos = NULL, 
  type = .Platform$pkgType)
~~~


<h2> From source via github </h2>

To install NicheMapR from source via github you will need the devtools package for R as well as a Fortran compiler for your platform (e.g. Win, Mac, Linux). 

Within R, install devtools by typing:

~~~ R
install.packages('devtools')
~~~

To install a Fortran compiler: 
* for Windows, you need to download and install <a href="https://cran.r-project.org/bin/windows/Rtools/">Rtools</a>
* for Mac, download the relevant <a href="https://github.com/fxcoudert/gfortran-for-macOS/releases">gfortran standalone installer</a>
* for Linux (Ubuntu) you can follow the instructions <a href="https://www.scivision.dev/install-latest-gfortran-on-ubuntu/">here</a>

Once you have devtools and a Fortran compiler installed, you can install NicheMapR from the R console by typing:

~~~ R
devtools::install_github('mrke/NicheMapR')
~~~

<h2> Installing the global climate database </h2>

Finally, to install the global climate database (derived from <a href="https://www.int-res.com/abstracts/cr/v21/n1/p1-25/">New et al. 2002</a>) do the following, replacing "path" with the location you want to install to (the default is "c:/global_climate"):

~~~ R
library(NicheMapR)
get.global.climate(folder="path")
~~~

<h2> Example analyses </h2>

Simulate microclimate for the typical middle day of each month in Madison, Wisconsin, using the global climate database of <a href="https://www.int-res.com/abstracts/cr/v21/n1/p1-25/">New et al. 2002</a> and plot hourly 5 cm soil temperature:

~~~ R
library(NicheMapR)
loc <- c(-89.40, 43.07)
micro <- micro_global(loc = loc)
soil <- as.data.frame(micro$soil)
plot(soil$D5cm ~ micro$dates, type = 'l')
~~~

Simulate microclimate for 2017 in Madison, Wisconsin using the gridMet database for the USA and plot hourly 5 cm soil temperature and soil moisture as well as snow depth:

~~~ R
library(NicheMapR)
loc <- c(-89.40, 43.07)
dstart <- "01/01/2017"
dfinish <- "31/12/2017"
micro <- micro_usa(loc = loc, dstart = dstart, dfinish = dfinish)
metout <- as.data.frame(micro$metout)
soil <- as.data.frame(micro$soil)
soilmoist <- as.data.frame(micro$soilmoist)
plot(soil$D5cm ~ micro$dates, type = 'l')
plot(soilmoist$WC5cm ~ micro$dates, type = 'l')
plot(metout$SNOWDEP ~ micro$dates, type = 'l')
~~~

Simulate microclimate for 2017 in Madison, Wisconsin using the NCEP database (this works for any location in the world) and plot hourly 5 cm soil temperature and soil moisture as well as snow depth:

~~~ R
library(NicheMapR)
loc <- c(-89.40, 43.07)
dstart <- "01/01/2017"
dfinish <- "31/12/2017"
micro <- micro_ncep(loc = loc, dstart = dstart, dfinish = dfinish)
metout <- as.data.frame(micro$metout)
soil <- as.data.frame(micro$soil)
soilmoist <- as.data.frame(micro$soilmoist)
plot(soil$D5cm ~ micro$dates, type = 'l')
plot(soilmoist$WC5cm ~ micro$dates, type = 'l')
plot(metout$SNOWDEP ~ micro$dates, type = 'l')
~~~

Compute a heat budget for the default ectotherm (Eastern Water Skink, _Eulamprus quoyii_) in Sydney, Australia for 2015 using the micro_aust function (uses the AWAP daily climate data set for Australia) and plot the consequences for its body temperature and seasonal activity window:

~~~ R
library(NicheMapR)
loc <- c(150.78, -33.78)
ystart <- 2015
yfinish <- 2015
micro <- micro_aust(loc = loc, ystart = ystart, yfinish = yfinish)
metout <- as.data.frame(micro$metout) # aboveground microclimate

# run ectotherm model
ecto <- ectotherm() # run ectotherm model with all default settings (Eastern Water Skink)

# retrieve output
environ <- as.data.frame(ecto$environ) # activity, Tb and environment

# append dates
dates <- micro$dates

############### plot results ######################

# Hourly Tb (black), depth (brown, m) and shade (green, %/10)
with(environ, plot(TC ~ dates, ylab = "", xlab = "month of year", col = 'black', ylim = c(-20, 40), type = "l", yaxt = 'n'))
with(environ, points(SHADE / 10 - 6 ~ dates, type = "l", col = "dark green"))
with(environ, points(DEP - 10 ~ dates, type = "l", col = "brown"))
abline(ecto$T_F_min, 0, lty = 2, col = 'blue')
abline(ecto$T_F_max, 0, lty = 2, col = 'red')
ytick<-seq(15, 40, by = 5)
axis(side = 2, at = ytick, labels = TRUE)
axis(side = 2, at = ytick, labels = FALSE)
mtext(text = seq(0, 100, 20), side = 2, line = 1, at = seq(-6, 4, 2), las = 2)
ytick<-seq(-20, -10, by = 2)
axis(side = 2, at = ytick, labels = FALSE)
mtext(text = rev(seq(0, 100, 20)), side = 2, line = 1, at = seq(-20, -10, 2), las = 2)
abline(h = -10, lty = 2, col = 'grey')
mtext(text = c('body temperature (°C)', 'activity', 'shade (%)', 'depth (cm)'), side = 2, line = 2.5, at = c(30, 9, 0, -15))
text(-0.2, c(ecto$T_F_max + 1, ecto$T_F_min + 1), c('T_F_max', 'T_F_min'), col = c('red', 'blue'), cex = 0.75)

# seasonal activity plot (dark blue = night, light blue = basking, orange = foraging)
forage <- subset(environ, ACT == 2)
bask <- subset(environ, ACT == 1)
night <- subset(metout, ZEN == 90)
day <- subset(metout, ZEN != 90)
with(night, plot(TIME / 60 ~ DOY, ylab = "Hour of Day", xlab = "Day of Year", pch = 15, cex = 0.75, col = 'dark blue'))
# nighttime hours
with(forage, points(TIME ~ DOY, pch = 15, cex = 0.75, col = 'orange')) # foraging Tbs
with(bask, points(TIME ~ DOY, pch = 15, cex = 0.75, col = 'light blue')) # basking Tbs
~~~

Compute the full heat, water and Dynamic Energy Budget for the _E. quoyii_ in in Sydney, Australia for 2015, starting as an egg, and plot its growth trajectory as wet mass:

~~~ R
library(NicheMapR)
loc <- c(150.78, -33.78)
ystart <- 2015
yfinish <- 2015
micro <- micro_aust(loc = loc, ystart = ystart, yfinish = yfinish)
metout <- as.data.frame(micro$metout) # aboveground microclimate

# run ectotherm model
ecto <- ectotherm(DEB = 1) # run ectotherm model for default parameters (Eastern Water Skink) with DEB model turned on

# retrieve output
debout <- as.data.frame(ecto$debout) # Dynamic Energy Budget model turned on

# plot wet mass
plot(debout$WETMASS ~ micro$dates, type = 'l')
E.Hb <- 866.6 # maturity threshold at birth for Eastern Water Skink
abline(v = micro$dates[which(debout$E_H > E.Hb)[1]], lty = 2, col = 'grey')
text(micro$dates[1], max(debout$WETMASS), labels = "embryo", cex = 0.85)
~~~

<h2> Source code </h2>

To view the code please visit the NicheMapR <a href="http://www.github.com/mrke/NicheMapR">GitHub account</a>

