---
title          : "Background and History"
excerpt: A short history of the development of NicheMapR
layout: single
permalink: /background/
---
<h1>Background and History</h1>
<p>
<h2>Beginnings</h2>
<p>
The NicheMapR package is an R implementation of a biophysical modelling software suite originally developed by Warren Porter and colleagues in the 1970s. Biophysical modelling is the application of physical principles of heat, mass and momentum transfer to organisms (<a href="https://doi:10.2307/1948545">Porter and Gates 1969</a>; Gates 1980). 
<p>
Porter became interested in this approach to understand a simple question about a lizard, the <a href="https://en.wikipedia.org/wiki/Desert_iguana">desert iguana</a>  - what is the thermal advantage to it being able to change colour from dark to light? To answer this question, Porter collaborated with mechanical engineers to develop Fortran programs for computing the lizard's heat budget (<a href = "https://doi.org/10.1007/BF00379617">Porter et al. 1973</a>). They also developed a microclimate model of the desert environment to estimate the environmental conditions required by the heat budget (Mitchell et al. 1975) that incorporated a sophisticated solar radiation algorithm (<a href="https://doi:10.2307/1933806">McCullough and Porter 1971</a>). 
<p>
These models allowed them to answer the question about colour change in the desert iguana, but also to calculate many other important aspects of the ecology of ectotherms as determined by the physical environment, including water loss, energy requirements, and even potential interactions with prey and predators (Porter et al. 1975; <a href = "https://doi.org/10.2307/1443867">Porter and James 1979</a>). Tracy (<a href="https://doi.org/10.2307/1942256">1976</a>) especially developed the approach in the context of wet-skinned ectotherms (e.g. frogs).
<p>
<h2>Endotherms</h2>
<p>
Subsequently, Porter and colleagues developed equivalent heat budget calculations for endotherms (birds and mammals). These models involve the same general principles of solving a heat budget, but in the case of endotherms a solution is found for the metabolic rate or water loss rate that balances the heat budget, rather than finding a solution for the core temperature (<a href = "https://doi.org/10.1071/ZO9940125">Porter et al. 1994</a>; <a href = "https://doi.org/10.1093/icb/40.4.597">Porter et al. 2000</a>).
<p>
<h2>Modelling at the landscape scale</h2>
<p>
In 1998, Porter spent a year at the National Center for Ecological Synthesis and Analysis (NCEAS) as a research fellow and began to apply biophysical calculations at the landscape scale (<a href = "https://doi.org/10.1093/icb/42.3.431">Porter et al. 2002</a>). In 2002 Michael Kearney visited Porter's lab on a Fulbright fellowship as part of his PhD research, extending this spatially-explicit work to develop mechanistic species distribution models that map the fundamental niche to space (<a href="https://doi.org/10.1111/j.1461-0248.2008.01277.x">Kearney and Porter 2004</a>). They contrasted this approach with correlative approaches to species distribution modelling (<a href="https://doi.org/10.1111/j.0906-7590.2008.05457.x">Kearney et al. 2008</a>; <a href="https://doi.org/10.1111/j.1461-0248.2008.01277.x">Kearney and Porter 2009</a>; <a href="https://doi:10.1111/j.1755-263X.2010.00097.x">Kearney et al. 2010</a>). The software suite of the microclimate, ectotherm and endotherm models began to be known as 'Niche Mapper'.
<p>
<h2>Integration of DEB theory</h2>
<p>
The mass budget aspects of Niche Mapper were initially of a static, empirical nature. That is, metabolic rates and other rates such as digestion, metabolic water production, growth and reproduction were computed from allometric functions of mass and body temperature. However, it was found that Dynamic Energy Budget theory could be integrated with the Niche Mapper system to make these calculations from first principles in an integrated manner (<a href="https://doi:10.1098/rstb.2010.0034">Kearney et al. 2010</a>). This provided a stronger thermodynamic basis to the approach opened up the capacity for full life-cycle models that were explicit about life history, phenology and nutrition (<a href="https://doi:10.1111/j.1365-2435.2011.01917.x">Kearney 2012</a>; <a href="https://doi:10.1111/1365-2435.12020">Kearney et al. 2013</a>).
<p>
<h2>Transition to R</h2>
<p>
The Niche Mapper programs were developed in the Fortran language, in part because it was the dominant numerical modelling language at the time the programs were first being developed. However, since around the year 2000 the R programming environment began to emerge as the dominant working language in ecology. Kearney created R interfaces to the Niche Mapper Fortran code and developed it into the 'NicheMapR' package. The microclimate model was officially released first (<a href="https://doi:10.1111/ecog.02360">Kearney and Porter 2017</a>), including new capacity to simulate soil moisture (<a href="https://doi.org/10.1016/j.jhydrol.2018.04.040">Kearney and Maino 2018</a>) and snow (<a href="https://doi:10.1111/geb.13100">Kearney 2020</a>) and a beta version of the ectotherm model. The ectotherm model was officially released subsequently in NicheMapR v2.0.0 (<a href="https://doi:10.1111/ecog.04680">Kearney and Porter 2019</a>), along with a beta version of the endotherm model. The endotherm model was officially released in NicheMapR v3.1.0 (<a href="https://doi.org/10.1111/ecog.05550">Kearney et al. 2021</a>). A modular R-only version of the ectotherm model was released in NicheMapR v3.2.0 as well as new capacity to model liquid uptake from the substrate for eggs and wet-skinned animals (<a href="https://doi.org/10.1111/2041-210X.14018">Kearney and Urzelai, 2022</a>).
<p>
<h2>References</h2>
<p>
Gates, D. M. (1980). Biophysical Ecology. New York: Springer Verlag.
<p>
Kearney, M. R. (2020). How will snow alter exposure of organisms to cold stress under climate warming?. Global Ecology and Biogeography. <a href="https://doi:10.1111/geb.13100">doi:10.1111/geb.13100</a>
<p>
Kearney, M., & Porter, W. P. (2004). Mapping the fundamental niche: physiology, climate, and the distribution of a nocturnal lizard. Ecology, 85(11), 3119–3131. <a href="https://doi.org/10.1890/03-0820">doi.org/10.1890/03-0820</a>
<p>
Kearney, M., Phillips, B. L., Tracy, C. R., Christian, K., Betts, G., & Porter, W. P. (2008). Modelling species distributions without using species distributions: the cane toad in Australia under current and future climates. Ecography, 31, 423–434. <a href="https://doi.org/10.1111/j.0906-7590.2008.05457.x">doi.org/10.1111/j.0906-7590.2008.05457.x</a>
<p>
Kearney, M., & Porter, W. P. (2009). Mechanistic niche modelling: combining physiological and spatial data to predict species’ ranges. Ecology Letters, 12, 334–350. <a href="https://doi.org/10.1111/j.1461-0248.2008.01277.x">doi.org/10.1111/j.1461-0248.2008.01277.x</a>
<p>
Kearney, M. R., Wintle, B. A., & Porter, W. P. (2010). Correlative and mechanistic models of species distribution provide congruent forecasts under climate change. Conservation Letters, 3(3), 203–213. <a href="https://doi:10.1111/j.1755-263X.2010.00097.x">doi:10.1111/j.1755-263X.2010.00097.x</a>
<p>
Kearney, M., Simpson, S. J., Raubenheimer, D., & Helmuth, B. (2010). Modelling the ecological niche from functional traits. Philosophical Transactions of the Royal Society B: Biological Sciences, 365(1557), 3469–3483. <a href="https://doi:10.1098/rstb.2010.0034">doi:10.1098/rstb.2010.0034</a>
<p>
Kearney, M. (2012). Metabolic theory, life history and the distribution of a terrestrial ectotherm. Functional Ecology, 26(1), 167–179. <a href="https://doi:10.1111/j.1365-2435.2011.01917.x">doi:10.1111/j.1365-2435.2011.01917.x</a>
<p>
Kearney, M. R., Simpson, S. J., Raubenheimer, D., & Kooijman, S. A. L. M. (2013). Balancing heat, water and nutrients under environmental change: a thermodynamic niche framework. Functional Ecology, 27(4), 950–966. <a href="https://doi:10.1111/1365-2435.12020">doi:10.1111/1365-2435.12020</a>
<p>
Kearney, M. R., & Porter, W. P. (2017). NicheMapR - an R package for biophysical modelling: the microclimate model. Ecography, 40(5), 664–674. <a href="https://doi:10.1111/ecog.02360">doi:10.1111/ecog.02360</a>
<p>
Kearney, M. R., & Maino, J. L. (2018). Can next-generation soil data products improve soil moisture modelling at the continental scale? An assessment using a new microclimate package for the R programming environment. Journal of Hydrology, 561, 662–673. <a href="https://doi.org/10.1016/j.jhydrol.2018.04.040">doi.org/10.1016/j.jhydrol.2018.04.040</a>
<p>
Kearney, M. R., & Porter, W. P. (2019). NicheMapR - an R package for biophysical modelling: the ectotherm and Dynamic Energy Budget models. Ecography. <a href="https://doi:10.1111/ecog.04680">doi:10.1111/ecog.04680</a>
<p>
Kearney, M. R., Briscoe, N. J., Mathewson, P. D., & Porter, W. P. (2021). NicheMapR – an R package for biophysical modelling: The endotherm model. Ecography, 44(11), 1595–1605. <a href="https://doi.org/10.1111/ecog.05550">doi.org/10.1111/ecog.05550</a>
<p>
Kearney, M. R., & Enriquez-Urzelai, U. (2022). A general framework for jointly modelling thermal and hydric constraints on developing eggs. Methods in Ecology and Evolution, n/a(n/a). <a href="https://doi.org/10.1111/2041-210X.14018">doi.org/10.1111/2041-210X.14018</a>
<p>
Mitchell, J. W., Beckman, W. A., Bailey, R. T., & Porter, W. P. (1975). Microclimatic modeling of the desert. In D. A. De Vries & N. H. Afgan (Eds.), Heat and mass transfer in the biosphere, Part 1. Transfer processes in the plant environment (pp. 275–286). Washington D. C.: Scripta Book Co.
<p>
McCullough, E. C., & Porter, W. P. (1971). Computing clear day solar radiation spectra for the terrestrial ecological environment. Ecology, 52(6), 1008–1015. <a href="https://doi:10.2307/1933806">doi:10.2307/1933806</a>
<p>
Porter, W. P., & Gates, D. M. (1969). Thermodynamic equilibria of animals with environment. Ecological Monographs, 39(3), 227–244. <a href="https://doi:10.2307/1948545">doi:10.2307/1948545</a>
<p>
Porter, W. P., Mitchell, J. W., Beckman, W. A., & DeWitt, C. B. (1973). Behavioral implications of mechanistic ecology - Thermal and behavioral modeling of desert ectotherms and their microenvironment. Oecologia, 13, 1–54. <a href = "https://doi.org/10.1007/BF00379617">doi.org/10.1007/BF00379617</a>
<p>
Porter, W. P., Mitchell, J. W., Beckman, W. A., & Tracy, C. R. (1975). Environmental constraints on some predator-prey interactions. In D. M. Gates & R. B. Schmerl (Eds.), Perspectives in Biophysical Ecology (pp. 347–364). New York: Springer-Verlag.
<p>
Porter, W. P., & James, F. C. (1979). Behavioral implications of mechanistic ecology II: the African Rainbow Lizard, Agama agama. Copeia, 1979(4), 594–619. <a href = "https://doi.org/10.2307/1443867">doi.org/10.2307/1443867</a>
<p>
Porter, W. P., Munger, J. C., Stewart, W. E., Budaraju, S., & Jaeger, J. (1994). Endotherm energetics: from a scalable individual-based model to ecological applications. Australian Journal of Zoology, 42, 125–162. <a href = "https://doi.org/10.1071/ZO9940125">doi.org/10.1071/ZO9940125</a>
<p>
Porter, W. P., Budaraju, S., Stewart, W. E., & Ramankutty, N. (2000). Calculating climate effects on birds and mammals: impacts on biodiversity, conservation, population parameters, and global community structure. American Zoologist, 40(4), 597–630. <a href = "https://doi.org/10.1093/icb/40.4.597">doi.org/10.1093/icb/40.4.597</a>
<p>
Porter, W. P., Sabo, J. L., Tracy, C. R., Reichman, O. J., & Ramankutty, N. (2002). Physiology on a landscape scale: plant-animal interactions. Integrative and Comparative Biology, 42(3), 431–453. <a href = "https://doi.org/10.1093/icb/42.3.431">doi.org/10.1093/icb/42.3.431</a>
<p>
Tracy, C. R. (1976). A model of the dynamic exchanges of water and energy between a terrestrial amphibian and its environment. Ecological Monographs, 46(3), 293–326. <a href="https://doi.org/10.2307/1942256">doi.org/10.2307/1942256</a>
