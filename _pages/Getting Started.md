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

Simulate microclimate for 2018 in Madison, Wisconsin using the gridMet database for the USA and plot hourly 5 cm soil temperature:

Compute a heat budget for the default ectotherm (Eastern Water Skink, __Eulamprus quoyii__) in Madison, Wisconsin for 2018 and plot the consequences for its body temperature and seasonal activity window:

Compute the full heat, water and Dynamic Energy Budget for the __E. quoyii__ in Madison, Wisconsin for 2018, starting as an egg, and plot its growth trajector as wet mass:


<h2> Source code </h2>

To view the code please visit the NicheMapR <a href="http://www.github.com/mrke/NicheMapR">GitHub account</a>

