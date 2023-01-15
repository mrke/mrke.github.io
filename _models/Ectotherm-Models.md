---
title          : "Ectotherm Models"
except: Computing the heat, water and mass budgets of ectotherms
---
<h1>Ectotherm Models</h1>
<p>
<h2>The general ectotherm model</h2>
<p>
The NicheMapR package includes a comprehensive algorithm for the complete heat, water and nutritional budget of an ectotherm to be solved, as described in detail in <a href="https://doi:10.1111/ecog.04680">Kearney and Porter (2019)</a>.
<p>
The program comprises a set of <a href="https://github.com/mrke/NicheMapR/tree/master/src">FORTRAN subroutines</a> that encode calculations of the steady-state heat budget for an ectotherm and its thermoregulatory responses, given a set of functional traits that parameterise its morphology, physiology and behaviour. The R wrapper for the FORTRAN code is <a href="https://github.com/mrke/NicheMapR/blob/master/R/ectorun.R">ectorun</a>. The function <a href="https://github.com/mrke/NicheMapR/blob/master/R/ectotherm.R">ectotherm</a> receives the user input data and sets up the call to <a href="https://github.com/mrke/NicheMapR/blob/master/R/ectorun.R">ectorun</a>. There is also a pared-down R-only version of the ectotherm model that does not include behaviour but only the core heat and water budget algorith, <a href="https://github.com/mrke/NicheMapR/blob/master/R/ectoR_devel.R">ectoR_devel</a>.
<p>
The ectotherm model is driven by the microclimate model output and has the option of being run with or without the Dynamic Energy Budget (DEB) model. When run without the DEB model, the ectotherm model will provide the body temperature, behavioural state (active/inactive, shade level selected, depth underground, etc.), water loss rate and metabolic rate each hour. When run with the DEB model turned on (and parameters set accordingly), the model will provide the trajectory of growth, development and reproduction of the organism as well as a wider range of mass budget outputs.
<p>
The <a href="/NicheMapR/inst/doc/ectotherm-model-tutorial">Ectotherm Model Tutorial</a> provides greater details on the operation of this model.
<p>
<h2>Transient heat budget models for ectotherms</h2>
<p>
In addition, the NicheMapR package has algorithms for computing 'transient heat budgets' of ectotherms (<a href="https://doi.org/10.1111/2041-210X.13528">Kearney et al. 2021</a>). These differ from the steady state calculations made by the <a href="https://github.com/mrke/NicheMapR/blob/master/R/ectotherm.R">ectotherm</a> function in that they account for the lag effects on body temperature of rapidly changing environmental conditions. This can be important for large ectotherms, especially those above about 1kg.
<p>
There are four functions for computing transient heat budgets in NicheMapR:

<ul>
<li><a href="https://github.com/mrke/NicheMapR/blob/master/R/onelump.R">onelump</a>; which analytically computes the trajectory of temperature change of an organism or object in a constant thermal environment;</li>
<li><a href="https://github.com/mrke/NicheMapR/blob/master/R/onelump.R">onelump_var</a>; which uses a numerical solver to compute the trajectory of temperature change of an organism or object in a time-varying thermal environment;</li>
<li><a href="https://github.com/mrke/NicheMapR/blob/master/R/twolump.R">twolump</a>; which uses a numerical solver to compute the trajectory of temperature change of an organism or object in a time-varying thermal environment that is broken into an outer shell and an inner core (may be needed for large organisms);</li>
<li><a href="https://github.com/mrke/NicheMapR/blob/master/R/trans_behav.R">trans_behav</a>; which applies the latter two functions to compute thermoregulatory behaviour of an organism in a time-varying thermal environment as it shuttles between shade and sun.</li>
</ul>
<p> The derivation of these algorithms is described in the <a href="/NicheMapR/inst/doc//transient_equation_derivations">Transient Equation Derivation</a> vignette and the thermoregulatory algorithm will be more fully described in a future publication (currently in prep).

<h1>References</h1>
<p>
Kearney, M. R., & Porter, W. P. (2019). NicheMapR - an R package for biophysical modelling: the ectotherm and Dynamic Energy Budget models. Ecography, 42, 1–12. <a href="https://doi:10.1111/ecog.04680">doi:10.1111/ecog.04680</a>
<p>
Kearney, M. R., Porter, W. P., & Huey, R. B. (2021). Modelling the joint effects of body size and microclimate on heat budgets and foraging opportunities of ectotherms. Methods in Ecology and Evolution, 12(13), 458–467. <a href="https://doi.org/10.1111/2041-210X.13528">doi.org/10.1111/2041-210X.13528</a>

