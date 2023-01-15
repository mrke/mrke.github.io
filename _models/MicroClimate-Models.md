---
title          : "Microclimate Models"
excerpt: Computing the climate near the ground

---
<h1>Microclimate Models</h1>
<p>
Microclimates represent the physical environments experienced by organisms. They are a necessity for mechanistic niche modelling because it is the environment experienced at the scale of the individual that needs to be provided to the equations of energy and mass balance. Microclimate predictions are also useful for a wide range of biological and non-biological applications.
<p>
The NicheMapR package has a range of functions useful in the computations of microclimates. These include functions for computing the physical properties of dry and humid air (functions <a href="https://github.com/mrke/NicheMapR/blob/master/R/DRYAIR.R">DRYAIR</a>, <a href="https://github.com/mrke/NicheMapR/blob/master/R/WETAIR.R">WETAIR</a>). Some empirical and theoretical details about the properties of air are also to be found in the  <a href="https://mrke.github.io/NicheMapR/inst/doc/properties-of-air">properties of air vignette</a>.
<p>
The microclimate model of the NicheMapR package (Kearney and Porter 2017) comprises an R wrapper script that communicates with the <a href="https://github.com/mrke/NicheMapR/tree/master/src">FORTRAN code</a> (function <a href="https://github.com/mrke/NicheMapR/blob/master/R/microrun.R">microrun</a>) and a set of environmental database-specific functions that collate and transform the required input data for submission to the microrun function. Specifically, functions are:
<p>
<a href="https://github.com/mrke/NicheMapR/blob/master/R/micro_global.R">micro_global</a> which connects to the global monthly database of climate conditions developed by New et al. (2002), on a ~10x10 km grid averaged over 1960 to 1990;
<p>
<a href="https://github.com/mrke/NicheMapR/blob/master/R/micro_ncep.R">micro_ncep</a> which uses the microclima package as well as the RNCEP (Kemp et al. 2012) and elevatr (Hollister et al. 2017) packages to connect to the 6-hourly 2.5x2.5 degree gridded historical NCEP data (global scope, from 1957 onward; Kalnay et al. 1996) and downscale them to hourly and account for local terrain effects (~30x30 m) including elevation-induced lapse rates, coastal influences and cold-air drainage (Kearney et al. 2019).
<p>
<a href="https://github.com/mrke/NicheMapR/blob/master/R/micro_era5.R">micro_era5</a> which uses a similar pipeline to micro_ncep as well as the <a href="https://github.com/dklinges9/mcera5">mcera5 package</a> (described in Klinges et al. 2019) to connect to the hourly 0.27x0.25 degree gridded historical ERA5 data (global scope, from 1959 onward; Hersbach et al. 2020).
<p>
<a href="https://github.com/mrke/NicheMapR/blob/master/R/micro_aust.R">micro_aust</a> connects to the Australian Water Availability Project (AWAP; Jones et al. 2009) 5x5 km gridded daily weather grids.
<p>
<a href="https://github.com/mrke/NicheMapR/blob/master/R/micro_usa.R">micro_usa</a> connects to the gridMET (Abatzoglou 2013) 5x5 km daily weather grids for the USA.
<p>
<a href="https://github.com/mrke/NicheMapR/blob/master/R/micro_uk.R">micro_uk</a> connects to the CHESS (Robinson et al. 2017) 1x1 km daily weather grids for the UK  (requires log in). 
<p>
<a href="https://github.com/mrke/NicheMapR/blob/master/R/micro_nz.R">micro_nz</a> connects to the 5 km daily <a href="https://www.niwa.co.nz/climate/our-services/virtual-climate-stations">Virtual Climate Station Network</a> (VCSN) for New Zealand (requires log in).
<p>
All of these functions can connect via the web to the SoilGrids (Hengle 2017) global soil properties database by setting the argument 'soilgrids' to a value of 1.
<p>
In addition, there are example vignettes for setting up your own functions for forcing the microclimate model, including a summary of all <a href="https://mrke.github.io/NicheMapR/inst/doc/microclimate-IO">inputs and outputs</a>, an explanation of all the <a href="https://mrke.github.io/NicheMapR/inst/doc/microclimate_inputs">input parameters</a>, and example setups for <a href="https://mrke.github.io/NicheMapR/inst/doc/microclimate-monthly-input-example">monthly</a> or <a href="https://mrke.github.io/NicheMapR/inst/doc/microclimate-hourly-input-example">hourly</a> input data. There is also a vignette on the underlying <a href="https://mrke.github.io/NicheMapR/inst/doc/microclimate-model-theory-equations">theory and equations</a> as well as a general <a href="https://mrke.github.io/NicheMapR/inst/doc/microclimate-model-tutorial">tutorial</a>.
<h1>References</h1>
Abatzoglou, J. T. (2013). Development of gridded surface meteorological data for ecological applications and modelling. International Journal of Climatology, 33(1), 121–131. <a href="https://doi:10.1002/joc.3413">doi:10.1002/joc.3413</a>
<p>
Hersbach, H., Bell, B., Berrisford, P., Hirahara, S., Horányi, A., Muñoz-Sabater, J., Nicolas, J., Peubey, C., Radu, R., Schepers, D., Simmons, A., Soci, C., Abdalla, S., Abellan, X., Balsamo, G., Bechtold, P., Biavati, G., Bidlot, J., Bonavita, M., … Thépaut, J.-N. (2020). The ERA5 global reanalysis. Quarterly Journal of the Royal Meteorological Society, 146(730), 1999–2049. <a href="https://doi.org/10.1002/qj.3803">doi.org/10.1002/qj.3803</a>
<p>
Hengl, T., de Jesus, J. M., Heuvelink, G. B., Gonzalez, M. R., Kilibarda, M., Blagotić, A., Shangguan, W., Wright, M. N., Geng, X., Bauer-Marschallinger, B., & others. (2017). SoilGrids250m: Global gridded soil information based on machine learning. PloS One, 12(2), e0169748. <a href="https://doi.org/10.1371/journal.pone.0169748">doi.org/10.1371/journal.pone.0169748</a>
<p>
Jeffrey W Hollister, Tarak Shah, & Marcus W Beck. (2017). jhollist/elevatr: Latest CRAN release. Zenodo. <a href="https://doi:10.5281/zenodo.400259">doi:10.5281/zenodo.400259</a>
<p>
Jones, D., Wang, W., & Fawcett, R. (2009). High-quality spatial climate data-sets for Australia. Australian Meteorological and Oceanographic Journal, 58(04), 233–248. <a href="https://doi:10.22499/2.5804.003">doi:10.22499/2.5804.003</a>
<p>
Kalnay, E., Kanamitsu, M., Kistler, R., Collins, W., Deaven, D., Gandin, L., … Joseph, D. (1996). The NCEP/NCAR 40-Year Reanalysis Project. Bulletin of the American Meteorological Society, 77(3), 437–472. <a href="https://doi:10.1175/1520-0477(1996)077<0437:TNYRP>2.0.CO;2">doi:10.1175/1520-0477(1996)077<0437:TNYRP>2.0.CO;2</a>
<p>
Kemp, M. U., Emiel van Loon, E., Shamoun-Baranes, J., & Bouten, W. (2012). RNCEP: global weather and climate data at your fingertips: RNCEP. Methods in Ecology and Evolution, 3(1), 65–70. <a href="https://doi:10.1111/j.2041-210X.2011.00138.x">doi:10.1111/j.2041-210X.2011.00138.x</a>
<p>
Kearney, M. R., & Porter, W. P. (2017). NicheMapR - an R package for biophysical modelling: the microclimate model. Ecography, 40(5), 664–674. <a href="https://doi:10.1111/ecog.02360">doi:10.1111/ecog.02360</a>
<p>
Kearney, M. R., Gillingham, P. K., Bramer, I., Duffy, J. P., & Maclean, I. M. D. (2020). A method for computing hourly, historical, terrain-corrected microclimate anywhere on earth. Methods in Ecology and Evolution, 11(1), 38–43. <a href="https://doi.org/10.1111/2041-210X.13330">doi.org/10.1111/2041-210X.13330</a>
<p>
Klinges, D. H., Duffy, J. P., Kearney, M. R., & Maclean, I. M. D. (2022). mcera5: Driving microclimate models with ERA5 global gridded climate data. Methods in Ecology and Evolution, 13(n/a), 7. <a href="https://doi.org/10.1111/2041-210X.13877">doi.org/10.1111/2041-210X.13877</a>
<p>
New, M., Lister, D., Hulme, M., & Makin, I. (2002). A high-resolution data set of surface climate over global land areas. Climate Research, 21(1), 1–25. <a href="https://doi:10.3354/cr021001">doi:10.3354/cr021001</a>
<p>
Robinson, E. L., Blyth, E., Clark, D. B., Comyn-Platt, E., Finch, J., & Rudd, A. C. (2017). Climate hydrology and ecology research support system meteorology dataset for Great Britain (1961-2015) [CHESS-met] v1.2. NERC Environmental Information Data Centre. Retrieved from <a href="https://doi.org/10.5285/b745e7b1-626c-4ccc-ac27-56582e77b900">doi.org/10.5285/b745e7b1-626c-4ccc-ac27-56582e77b900</a>
