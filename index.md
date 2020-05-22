---
title: "Welcome to NicheMapR"
layout: single
permalink: /
author_profile: true
header:
  overlay_color: "#EAEAEA"
  overlay_image: /assets/images/near_papunya.jpg
  caption: "Photo credit: **Michael Kearney**"
  actions:
    - label: "Jump To GitHub Code"
      url: "http://github.com/mrke/NicheMapR"
---
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-151353837-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-151353837-1');
</script>

<b>NicheMapR:</b> Software suite for microclimate and mechanistic niche modelling in the R programming environment.

<hr color="black" align="center" size="5">

<h1>Overview</h1>

NicheMapR is a suite of programs for the R environment that compute fundamental physical and chemical constraints on living things. It aims at asking the general question: _Can an organism complete its life cycle in a particular place and time, without overheating, desiccating or starving_?

In other words, starting with the **functional traits** of an organism, the programs can be used to determine the environmental sequence experienced by an organism in a particular habitat and assess whether this sequence is inside, or outside, of its niche.

To achieve this it integrates: 
* calculations of the external processes of heat and water exchange using the principles of **biophysical ecology**
* calculations of internal processes of growth, development and reproduction, i.e. metabolism, using the principles of **metabolic theory** (Dynamic Energy Budget theory)
* calculations of the **microclimates** to which the organism is exposed using principles of micrometerology, soil physics and hydrology.

<a href="https://www.youtube.com/watch?v=ud_s7056GXo">Michael Kearney introduces NicheMapR</a>

R Shiny apps for the <a href="http://bioforecasts.science.unimelb.edu.au/soil/">microclimate</a> and <a href="http://bioforecasts.science.unimelb.edu.au/ectotherm/">ectotherm</a> models.


<h2> Background and History </h2>

NicheMapR started as a project on why desert iguanas change colour. Learn more <a href="https://mrke.github.io/background/"> here</a>.

<h2> Applications </h2>

To see examples from the literature that have applied NicheMapR, click <a href="https://mrke.github.io/examples/"> here</a>.

<h2> Tests </h2>

The algorithms underlying NicheMapR have been subjected to a range of tests as described in the papers <a href="https://mrke.github.io/tests/"> here</a>.

Snow model test from Kearney, M. R. (2019). microclimUS: hourly estimates of historical microclimates for the United States of America with example applications. Ecology, 0(ja), e02829. doi:10.1002/ecy.2829
: ![gras](/assets/images/snodastest.gif)
<p>
Sample comparison of SNODAS and NicheMapR predictions of snow depth in 2010, showing (top left) SNODAS prediction, (top right) microclimUS prediction, (bottom left) prediction overlap (i.e. only showing SNODAS points coinciding with microclimUS points, the size of points represents relative depth of snow for each data set) and (bottom right) correlation.

