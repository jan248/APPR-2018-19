library(ggplot2)
library(dplyr)
library(tidyr)
library(rgdal)
library(ggvis)
library(mosaic)
library(maptools)

source('lib/uvozi.zemljevid.r')
ocena.stanovanj.gradnja1 <- ocena.stanovanj.gradnja%>%gather('Tip.stanovanja', 'Število', -Leto)
ocena.stanovanj.gradnja1 <- ocena.stanovanj.gradnja1%>%filter(Tip.stanovanja != 'Stanovanja.v.gradnji...SKUPAJ')%>%filter(Tip.stanovanja != 'Dokončana.stanovanja...SKUPAJ.')%>%filter(Tip.stanovanja != 'Dokončana.stanovanja.na.1000.prebivalcev')


graf.gradbena.dovoljenja.regije <- ggplot((data=grad.dovol.regije), aes(x=Leto, y=Število.stavb, col=Regija)) + 
  geom_point() + geom_line() + 
  scale_x_continuous('Leto', breaks = seq(2007, 2017, 1), limits = c(2007,2017))
plot(graf.gradbena.dovoljenja.regije) 

graf.ocena.stanovanj.gradnja <- ggplot((data=ocena.stanovanj.gradnja1), aes(x=Leto, y=Število, col=Tip.stanovanja)) + 
  geom_point() + geom_line() +
  scale_x_continuous('Leto', breaks = seq(2008, 2017, 1), limits = c(2008,2017))
plot(graf.ocena.stanovanj.gradnja) 






Slovenija <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2.8/shp/SVN_adm_shp.zip",
                             "SVN_adm1") %>% fortify()
colnames(Slovenija)[12] <- 'Regija'
Slovenija$Regija <- gsub('GoriĹˇka', 'Goriška', Slovenija$Regija)
Slovenija$Regija <- gsub('KoroĹˇka', 'Koroška', Slovenija$Regija)
Slovenija$Regija <- gsub('Notranjsko-kraĹˇka', 'Primorsko-notranjska', Slovenija$Regija)
Slovenija$Regija <- gsub('Obalno-kraĹˇka', 'Obalno-kraška', Slovenija$Regija)
Slovenija$Regija <- gsub('Spodnjeposavska', 'Posavska', Slovenija$Regija)

graf_slovenija <- ggplot(Slovenija, aes(x=long, y=lat, group=group, fill=Regija)) +
  geom_polygon(inherit.aes = TRUE, show.legend = TRUE) +
  labs(title="Slovenija - brez podatkov") +
  theme(legend.position="none")
#plot(graf_slovenija)

indeks <- left_join(preb.reg, grad.dovol.st.stavb, by=c('Regija', 'Leto')) %>% filter(Stevilo.stavb != '')
indeks <- transform(indeks, Indeks=(Stevilo.stavb * 1000/Stevilo ))
colnames(indeks)[3] <- 'Prebivalstvo'
indeks <- indeks[c(-3, -4)]

indeks.2010 <- indeks %>% filter(Leto == '2010')
indeks.2011 <- indeks %>% filter(Leto == '2011')
indeks.2012 <- indeks %>% filter(Leto == '2012')
indeks.2015 <- indeks %>% filter(Leto == '2015')
indeks.2017 <- indeks %>% filter(Leto == '2017')


graf.indeks.2010 <- ggplot() + geom_polygon(data = right_join(Slovenija, indeks.2010, by=('Regija')), aes(x=long, y=lat,group = group, fill=Indeks))+
  scale_fill_gradient(low = '#9999FF', high='#000033') + 
  theme(axis.title=element_blank(), axis.text=element_blank(), axis.ticks=element_blank(), panel.background = element_blank()) + 
  labs(title = 'Število dokončanih stanovanj na 1000 prebivalcev po regijah Slovenije v letu 2010')

graf.indeks.2011 <- ggplot() + geom_polygon(data = right_join(Slovenija, indeks.2011, by=('Regija')), aes(x=long, y=lat,group = group, fill=Indeks))+
  scale_fill_gradient(low = '#9999FF', high='#000033') + 
  theme(axis.title=element_blank(), axis.text=element_blank(), axis.ticks=element_blank(), panel.background = element_blank()) + 
  labs(title = 'Število dokončanih stanovanj na 1000 prebivalcev po regijah Slovenije v letu 2011')

graf.indeks.2012 <- ggplot() + geom_polygon(data = right_join(Slovenija, indeks.2012, by=('Regija')), aes(x=long, y=lat,group = group, fill=Indeks))+
  scale_fill_gradient(low = '#9999FF', high='#000033') + 
  theme(axis.title=element_blank(), axis.text=element_blank(), axis.ticks=element_blank(), panel.background = element_blank()) + 
  labs(title = 'Število dokončanih stanovanj na 1000 prebivalcev po regijah Slovenije v letu 2012')

graf.indeks.2015 <- ggplot() + geom_polygon(data = right_join(Slovenija, indeks.2015, by=('Regija')), aes(x=long, y=lat,group = group, fill=Indeks))+
  scale_fill_gradient(low = '#9999FF', high='#000033') + 
  theme(axis.title=element_blank(), axis.text=element_blank(), axis.ticks=element_blank(), panel.background = element_blank()) + 
  labs(title = 'Število dokončanih stanovanj na 1000 prebivalcev po regijah Slovenije v letu 2015')

graf.indeks.2017 <- ggplot() + geom_polygon(data = right_join(Slovenija, indeks.2017, by=('Regija')), aes(x=long, y=lat,group = group, fill=Indeks))+
  scale_fill_gradient(low = '#9999FF', high='#000033') + 
  theme(axis.title=element_blank(), axis.text=element_blank(), axis.ticks=element_blank(), panel.background = element_blank()) + 
  labs(title = 'Število dokončanih stanovanj na 1000 prebivalcev po regijah Slovenije v letu 2017')

  
plot(graf.indeks.2010)
plot(graf.indeks.2011)
plot(graf.indeks.2012)
plot(graf.indeks.2015)
plot(graf.indeks.2017)



