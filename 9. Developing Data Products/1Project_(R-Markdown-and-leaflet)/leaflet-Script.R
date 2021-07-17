## Creating a Leaflet map

library(dplyr)
library(leaflet)

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