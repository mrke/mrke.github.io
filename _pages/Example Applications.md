---
title          : "Dynamic Energy Budget Models"
excerpt: A general metabolic theory for biology

---
<h1>Dynamic Energy Budget Models</h1>


<p>
<a href="https://en.wikipedia.org/wiki/Dynamic_energy_budget_theory">Dynamic Energy Budget theory</a> (DEB) is a theory of metabolism, i.e. of the chemical transformations of living things as they develop, grow, reproduce and age thoughtout their life cycle, given their food intake and body temperature. It was developed primarily by Prof. Bas Kooijman in collaboration with a range colleagues. It explains a wide range of general scaling patterns including 1/4 power scaling. DEB theory thus covers the same ground as "The Metabolic Theory of Ecology" but predates the latter ideas and encompasses a wider range of metabolic processes.
<p>
NicheMapR provides stand-alone routines (functions <a href="https://github.com/mrke/NicheMapR/blob/master/R/DEB.R">DEB</a>, <a href="https://github.com/mrke/NicheMapR/blob/master/R/DEB_euler.R">DEB_euler</a>) for using DEB theory to simulate trajectories of growth, development and reproduction as shown in the <a href="https://mrke.github.io/NicheMapR/inst/doc/deb-model-tutorial">DEB model vignette</a>. It is also fully integrated into the ectotherm model (function <a href="https://github.com/mrke/NicheMapR/blob/master/R/ectotherm.R">ectotherm</a>), as shown in the <a href="https://mrke.github.io/NicheMapR/inst/doc/ectotherm-model-tutorial">ectotherm model vignette</a>.
<p>
<a href="https://www.bio.vu.nl/thb/deb/deblab/add_my_pet/">DEB parameters</a> have been estimated for over 2000 species across the tree of animal life and DEB models also exist for <a href="https://github.com/rafaqz/DEBScripts">plants</a>. The key reference is Kooijman 2010 and an overview of resources can be found on the <a href="http://www.debtheory.org/wiki/">DEB wiki</a>.