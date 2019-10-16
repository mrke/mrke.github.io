---
title          : "Background and History"
excerpt: A short history of the development of NicheMapR
layout: single
permalink: /background/
---
<h1>Background and History</h1>
<p>
<h2>Beginnings</h2>
The NicheMapR package is an R implementation of a biophysical modelling software originally developed by Warren Porter and colleagues in the 1970s. Biophysical modelling is the application of physical principles of heat, mass and momentum transfer to organisms (Porter and Gates 1969; Gates 1980). 
<p>
Porter became interested in this approach to understand a simple question about a lizard, the <a href="https://en.wikipedia.org/wiki/Desert_iguana">desert iguana</a>  - what is the thermal advantage to it being able to change colour from dark to light? To answer this question, Porter collaborated with mechanical engineers to develop Fortran programs for computing the lizard's heat budget (Porter et al. 1973). They also developed a microclimate model of the desert environment to estimate the environmental conditions required by the heat budget (Mitchell et al. 1975) that incoporated a sophisticated solar radiation algorithm (McCullough and Porter 1971). 
<p>
These models allowed them to answer the question about colour change in the desert iguana, but also to calculate many other important aspects of the ecology of ectotherms as determined by the physical environment, including water loss, energy requirements, and even potential interactions with prey and predators (Porter et al. 1975; Porter and James 1979). Tracy (1976) especially developed the approach in the context of wet-skinned ectotherms (e.g. frogs).
<p>
<h2>Endotherms</h2>
<p>
Subsequently, Porter and colleagues developed equivalent heat budget calculations for endotherms (birds and mammals). These models involve the same general principles of solving a heat budget, but in the case of endotherms a solution is found for the metabolic rate or water loss rate that balances the heat budget, rather than finding a solution for the core temperature (Porter et al. 1994; Porter et al. 2000).
<p>
<h2>Modelling at the landscape scale</h2>
<p>
In 1998, Porter spent a year at the National Center for Ecological Synthesis and Analysis (NCEAS) as a research fellow and began to apply biophyiscal calculations at the landscape scale (Porter et al. 2002). In 2002 Michael Kearney visited Porter's lab on a Fubright fellowship as part of his PhD research, extending this spatially-explicit work to develop mechanistic species distribution models that map the fundamental niche to space (Kearney and Porter 2004). They contrasted this approach with correlative approaches to species distribution modelling (Kearney et al. 2008; Kearney and Porter 2009; Kearney et al. 2010). The software suite of the microclimate, ectotherm and endotherm models began to be known as 'Niche Mapper'.
<p>
<h2>Integration of DEB theory</h2>
<p>
The mass budget aspects of Niche Mapper were initially of a static, empirical nature. That is, metabolic rates and other rates such as digestion, metabolic water production, growth and reproduction were computed from allometric functions of mass and body temperature. However, it was found that Dynamic Energy Budget theory could be integrated with the Niche Mapper system to make these calculations from first principles in an integrated manner (Kearney et al. 2010). This provided a stronger thermodynamic basis to the approach opened up the capacity for full life-cycle models that were explicit about life history, phenology and nutrition (Kearney 2012; Kearney et al 2013).
<p>
<h2>Transition to R</h2>
<p>
The Niche Mapper programs were developed in the Fortran language, in part because it was the dominant numerical modelling language at the time the programs were first being developed. However, since around the year 2000 the R programming environment began to emerge as the dominant working language in ecology. Kearney developed R interfaces to the Niche Mapper Fortran code and developed it into the 'NicheMapR' package. The microclimate model was officially released first (Kearney and Porter 2017), including new capacity to simulate soil moisture (Kearney and Maino 2018) and snow (Kearney in prep.) and a beta version of the ectotherm model. The ectotherm model was officially released subsequently in NicheMapR v2.0.0 (Kearney and Porter 2019) with a beta version of the endotherm model.
<p>
<h2>References</h2>

Gates, D. M. (1980). Biophysical Ecology. New York: Springer Verlag.

Kearney, M., & Porter, W. P. (2004). Mapping the fundamental niche: physiology, climate, and the distribution of a nocturnal lizard. Ecology, 85(11), 3119–3131.

Kearney, M., Phillips, B. L., Tracy, C. R., Christian, K., Betts, G., & Porter, W. P. (2008). Modelling species distributions without using species distributions: the cane toad in Australia under current and future climates. Ecography, 31, 423–434.

Kearney, M., & Porter, W. P. (2009). Mechanistic niche modelling: combining physiological and spatial data to predict species’ ranges. Ecology Letters, 12, 334–350.

Kearney, M. R., Wintle, B. A., & Porter, W. P. (2010). Correlative and mechanistic models of species distribution provide congruent forecasts under climate change. Conservation Letters, 3(3), 203–213. doi:10.1111/j.1755-263X.2010.00097.x

Kearney, M., Simpson, S. J., Raubenheimer, D., & Helmuth, B. (2010). Modelling the ecological niche from functional traits. Philosophical Transactions of the Royal Society B: Biological Sciences, 365(1557), 3469–3483. doi:10.1098/rstb.2010.0034

Kearney, M. (2012). Metabolic theory, life history and the distribution of a terrestrial ectotherm. Functional Ecology, 26(1), 167–179. doi:10.1111/j.1365-2435.2011.01917.x

Kearney, M. R., Simpson, S. J., Raubenheimer, D., & Kooijman, S. A. L. M. (2013). Balancing heat, water and nutrients under environmental change: a thermodynamic niche framework. Functional Ecology, 27(4), 950–966. doi:10.1111/1365-2435.12020

Kearney, M. R., & Porter, W. P. (2017). NicheMapR - an R package for biophysical modelling: the microclimate model. Ecography, 40(5), 664–674. doi:10.1111/ecog.02360

Kearney, M. R., & Porter, W. P. (2019). NicheMapR - an R package for biophysical modelling: the ectotherm and Dynamic Energy Budget models. Ecography. doi:10.1111/ecog.04680

Mitchell, J. W., Beckman, W. A., Bailey, R. T., & Porter, W. P. (1975). Microclimatic modeling of the desert. In D. A. De Vries & N. H. Afgan (Eds.), Heat and mass transfer in the biosphere, Part 1. Transfer processes in the plant environment (pp. 275–286). Washington D. C.: Scripta Book Co.

McCullough, E. C., & Porter, W. P. (1971). Computing clear day solar radiation spectra for the terrestrial ecological environment. Ecology, 52(6), 1008–1015. doi:10.2307/1933806

Porter, W. P., & Gates, D. M. (1969). Thermodynamic equilibria of animals with environment. Ecological Monographs, 39(3), 227–244. doi:10.2307/1948545

Porter, W. P., Mitchell, J. W., Beckman, W. A., & DeWitt, C. B. (1973). Behavioral implications of mechanistic ecology - Thermal and behavioral modeling of desert ectotherms and their microenvironment. Oecologia, 13, 1–54.

Porter, W. P., Mitchell, J. W., Beckman, W. A., & Tracy, C. R. (1975). Environmental constraints on some predator-prey interactions. In D. M. Gates & R. B. Schmerl (Eds.), Perspectives in Biophysical Ecology (pp. 347–364). New York: Springer-Verlag.

Porter, W. P., & James, F. C. (1979). Behavioral implications of mechanistic ecology II: the African Rainbow Lizard, Agama agama. Copeia, 1979(4), 594–619.

Porter, W. P., Munger, J. C., Stewart, W. E., Budaraju, S., & Jaeger, J. (1994). Endotherm energetics: from a scalable individual-based model to ecological applications. Australian Journal of Zoology, 42, 125–162.

Porter, W. P., Budaraju, S., Stewart, W. E., & Ramankutty, N. (2000). Calculating climate effects on birds and mammals: impacts on biodiversity, conservation, population parameters, and global community structure. American Zoologist, 40(4), 597–630.

Porter, W. P., Sabo, J. L., Tracy, C. R., Reichman, O. J., & Ramankutty, N. (2002). Physiology on a landscape scale: plant-animal interactions. Integrative and Comparative Biology, 42(3), 431–453.

Tracy, C. R. (1976). A model of the dynamic exchanges of water and energy between a terrestrial amphibian and its environment. Ecological Monographs, 46(3), 293–326.
