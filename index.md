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
<b>NicheMapR:</b> Software suite for microclimate and mechanistic niche modelling in the R programming environment.

<hr color="black" align="center" size="5">

<h1>Overview</h1>

NicheMapR is a suite of programs for the R programming environment that compute fundamental physical and constraints on living things. It aims at asking the general question: _Can an organism complete its life cycle in a particular place and time, without overheating, desiccating or starving_?

In other words, starting with the **functional traits** of an organism, the programs can be used to determine the environmental sequence experienced by an organism in a particular habitat and assess whether this sequence is inside, or outside, of its niche.

To achieve this it integrates: 
* calculations of the external processes of heat and water exchange using the principles of **biophysical ecology**
* calculations of internal processes of growth, development and reproduction, i.e. metabolism, using the principles of **metabolic theory** (Dynamic Energy Budget theory)
* calculations of the **microclimates** to which the organism is exposed using principles of micrometerology, soil physics and hydrology.

<a href="https://www.youtube.com/watch?v=ud_s7056GXo">Michael Kearney introduces NicheMapR</a>

{% for background in site.background %}
  <h1><a href="{{background.permalink}}">{{background.title}}</a></h1>
<hr>
{% endfor %}

<h2> Applications </h2>
Coming soon.

<h3> Tests </h3>
Snow model test: ![gras](/assets/images/snodastest.gif)

