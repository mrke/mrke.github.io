---
title: "Models"
layout: single
permalink: /models/
---

<b>NicheMapR models are divided into five categories: </b> <i>Microclimates, Ectotherms, Endotherms, Plants, Dynamic Energy Budgets.</i>


{% for model in site.models %}
  <h1>
    <a href="{{ model.url }}">
      {{model.title}}
    </a>
  </h1>
  <hr>
{% endfor %}