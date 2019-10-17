---
title          : "Plant Models"
excerpt: Current plant modelling capacity in NicheMapR

---
<h1>Plant Models</h1>
<p>
Presently, there is only limitied plant modelling capacity in NicheMapR. The microclimate model provides many of the environmental inputs required for plant modelling, including soil temperature and moisture, and wavelength-specific irradiance (parameter 'lamb' set to 1 returns the wavelength-specific solar radiation output). 
<p>
Also, the soil moisture algorithm incorporates a soil-plant-atmosphere-continuum (SPAC) model that is defined by the following plant trait parameters (with default values shown):
<p>
<ul>
<li>L = c(0, 0, 8.2, 8.0, 7.8, 7.4, 7.1, 6.4, 5.8, 4.8, 4.0, 1.8, 0.9, 0.6, 0.8, 0.4, 0.4, 0, 0) * 10000, root density (m/m3), (19 values descending through soil for specified soil nodes in parameter</li>
<li>R1 = 0.001, root radius, m</li>
<li>RW = 2.5e+10, resistance per unit length of root, m3 kg-1 s-1</li>
<li>RL = 2e+6, resistance per unit length of leaf, m3 kg-1 s-1</li>
<li>PC = -1500, critical leaf water potential for stomatal closure, J kg-1</li>
<li>SP = 10, stability parameter for stomatal closure equation, -</li>
<li>LAI = 0.1, leaf area index, used to partition traspiration/evaporation from potential evapotranspiration (PET)</li>
</ul>
The microclimate model also produces estimates of plant transpiration rate and the leaf and (depth-specific) root water potential from the from the soil moisture calculations (output tables 'plant' and 'shadplant').
<p>
The function <a href="https://github.com/mrke/NicheMapR/blob/master/R/plantgro.R">plantgro</a> takes soil water potential and soil temperature input and computes a crude growing degree day model of potential plant growth and an estimate of plant water content, given threshold values of soil water potential at which the wilting point and permanent wilting point occurs, the depth range of the roots and a threshold root temperature for growth.
<p>
A Dynamic Energy Budget plant model is also under development, with a working version that links to the microclimate model outputs available under Julia programming environment (see <a href="https://github.com/rafaqz/DEBScripts">here</a>). 