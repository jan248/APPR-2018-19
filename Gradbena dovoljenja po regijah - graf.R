library(ggplot2)
library(dplyr)
library(rgdal)
library(ggvis)
library(mosaic)
library(maptools)

source('lib/uvozi.zemljevid.r')

graf.gradbena.dovoljenja.regije <- ggplot((data=grad.dovol.regije), aes(x=Leto, y=Število.stavb, col=Regija)) + geom_point() + geom_line()
plot(graf.gradbena.dovoljenja.regije)

Slovenija <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2.8/shp/SVN_adm_shp.zip",
                             "SVN_adm1") %>% fortify()


graf_slovenija <- ggplot(Slovenija, aes(x=long, y=lat, group=group, fill=NAME_1)) +
  geom_polygon() +
  labs(title="Slovenija - brez podatkov") +
  theme(legend.position="none")



