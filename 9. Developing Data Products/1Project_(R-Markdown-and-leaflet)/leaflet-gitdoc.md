R-Markdown-and-leaflet
================
Milton Candela
1/23/2021

# Date: 23/1/2021

# User: Milton Candela

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(leaflet)
```

    ## Warning: package 'leaflet' was built under R version 4.0.3

``` r
lat <- -100.2847204357147
lng <- 25.678453330315154

s1lat <- -100.29093818373711
s1lng <- 25.673732643397514

s2lat <- -100.27624563519873
s2lng <- 25.68323008312362

mapa <- leaflet() %>%
       addTiles() %>%
       addMarkers(lat, lng,
                  popup = 
                  '<a href = "https://en.wikipedia.org/wiki/Fundidora_Park">Fundidora Park!</a>
                  <br>
                  Current date: 23/Jan/2021
                  <br>
                  Name: Milton Candela
                  <br>
                  <img src = "https://www.greenflagaward.org/media/1346/arque-fundidora-y-canal-santa-luc%C3%ADa.jpg" height = "200" width ="260">') %>%
       addRectangles(s1lat, s1lng, s2lat, s2lng)
mapa
```

<!--html_preserve-->

<div id="htmlwidget-d3437fc053c28f630d56" class="leaflet html-widget" style="width:672px;height:480px;">

</div>

<script type="application/json" data-for="htmlwidget-d3437fc053c28f630d56">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">OpenStreetMap<\/a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA<\/a>"}]},{"method":"addMarkers","args":[25.6784533303152,-100.284720435715,null,null,null,{"interactive":true,"draggable":false,"keyboard":true,"title":"","alt":"","zIndexOffset":0,"opacity":1,"riseOnHover":false,"riseOffset":250},"<a href = \"https://en.wikipedia.org/wiki/Fundidora_Park\">Fundidora Park!<\/a>\n                  <br>\n                  Current date: 23/Jan/2021\n                  <br>\n                  Name: Milton Candela\n                  <br>\n                  <img src = \"https://www.greenflagaward.org/media/1346/arque-fundidora-y-canal-santa-luc%C3%ADa.jpg\" height = \"200\" width =\"260\">",null,null,null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]},{"method":"addRectangles","args":[25.6737326433975,-100.290938183737,25.6832300831236,-100.276245635199,null,null,{"interactive":true,"className":"","stroke":true,"color":"#03F","weight":5,"opacity":0.5,"fill":true,"fillColor":"#03F","fillOpacity":0.2,"smoothFactor":1,"noClip":false},null,null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]}],"limits":{"lat":[25.6737326433975,25.6832300831236],"lng":[-100.290938183737,-100.276245635199]}},"evals":[],"jsHooks":[]}</script>

<!--/html_preserve-->
