---
title: "Models"
layout: single
permalink: /models/
---

<b>NicheMapR models are divided into five categories: </b> <i>Microclimates, Ectotherms, Endotherms, Plants, Dynamic Energy Budgets.</i>

{% for models in site.models %}
  <h1><a href="{{models.permalink}}" class="btn btn--inverse" >{{models.title}}</a></h1>
<hr>
{% endfor %}