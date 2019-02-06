library(dplyr)
library(tidyr)


# 1.tabela: stanovanjski standard
stanovanjski.standard <- read.csv2(file = 'podatki/Stanovanjski standard.csv', fileEncoding = 'Windows-1250', header = FALSE,
                                   skip = 4, nrows = 213,col.names = c('Regija', '2011', '2015'),sep = ';', dec = '.', na = c('', '-', ' ') )
# 2.tabela: stanovanja v gradnji
ocena.stanovanj.gradnja <- read.csv2(file = 'podatki/Ocena_stanovanj_v_gradnji.csv', fileEncoding = 'Windows-1250', header = FALSE,
                                        skip = 4, nrows = 11, na = c('', '-', ' '), sep = ';', dec = '.',
                                     col.names = c('oaknfoans','Leto','Stanovanja v gradnji - SKUPAJ','Stanovanja v gradnji - z začetkom gradnje v letu','Stanovanja v gradnji ob koncu leta','Dokončana stanovanja - SKUPAJ
','Dokončana stanovanja - investitor pravna oseba','Dokončana stanovanja - investitor fizična oseba','Dokončana stanovanja na 1000 prebivalcev','baifba'))
ocena.stanovanj.gradnja <- ocena.stanovanj.gradnja[,-1]
ocena.stanovanj.gradnja <- ocena.stanovanj.gradnja[,-9]
ocena.stanovanj.gradnja <- ocena.stanovanj.gradnja%>% filter(Leto != ' ')

# 3. tabela: gradbena dovoljenja po statisticnih regijah
grad.dovol.stat.reg <- read.csv2(file = 'podatki/Gradbena_dovoljenja_po_statisticnih_regijah.csv', fileEncoding = 'Windows-1250', header = TRUE,
                                   skip = 3, nrows = 223,sep = ';', dec = '.', na = c('', '-', ' ') )
grad.dovol.stat.reg <- grad.dovol.stat.reg %>% fill(1) %>% filter(Leto != ' ')

# 4.tabela: ocena dokoncanih stavb
ocena.dokon.stavb <- read.csv2(file = 'podatki/Ocena_dokoncanih_stavb.csv', fileEncoding = 'Windows-1250', header = TRUE,
                                   skip = 3, nrows = 69,sep = ';', dec = '.', na = c('', '-', ' ', '...') )
ocena.dokon.stavb <- ocena.dokon.stavb %>% fill(1:3) %>% filter(Leto != ' ')

# 5.tabela: ocena dokoncanih stavb obcine
ocena.dokon.stavb.obcine <- read.csv2(file = 'podatki/Ocena_dokoncanih_stavb_obcine.csv', fileEncoding = 'Windows-1250', header = TRUE,
                                   skip = 2, nrows = 3621, sep = ';', dec = '.', na = c('', '-', ' ') )
ocena.dokon.stavb.obcine <- ocena.dokon.stavb.obcine %>% fill(1:2) %>% filter(Leto != ' ')

# 6.tabela: kriminaliteta po obcinah
krim.obcine <- read.csv2(file = 'podatki/Kriminaliteta_po_obcinah.csv', fileEncoding = 'Windows-1250', header = TRUE,
                         skip = 2, nrows = 2568, sep = ';', dec = '.', na = c('', '-', ' ') )
krim.obcine <- krim.obcine %>% fill(1:2) %>% filter(Leto != ' ')

# 7.tabela: izobrazba po obcinah
izob.obcine <- read.csv2(file = 'podatki/Izobrazba_po_obcinah.csv', fileEncoding = 'Windows-1250', header = TRUE,
                         skip = 1, nrows = 11290, sep = ';', dec = '.', na = c('', '-', ' ') )
izob.obcine <- izob.obcine %>% fill(1:2) %>% filter(Spol != ' ') %>% filter(Izobrazba...SKUPAJ != '') 
izobr.obcine <- izob.obcine%>%filter(Občine != 'SLOVENIJA') %>% filter(Spol == 'Spol - SKUPAJ') 

# 8.tabela: povprecne mesecne place po obcinah
povp.mes.place.obcine <- read.csv2(file = 'podatki/Povprečne_mesečne_plače_po_občinah.csv', fileEncoding = 'Windows-1250', header = TRUE,
                         skip = 3, nrows = 213, sep = ';', dec = '.', na = c('', '-', ' ') )

# 9.tabela: prenaseljenost stanovanj
prenas.stanovanj <- read.csv2(file = 'podatki/Prenaseljenost stanovanj.csv', fileEncoding = 'Windows-1250', header = TRUE,
                         skip = 2, nrows = 6, sep = ';', dec = '.', na = c('', '-', ' ') )
prenas.stanovanj <- prenas.stanovanj %>% fill(1) %>% filter(Del.Slovenije != ' ')

# 10.tabela: vrednost opravljenih gradbenih del
vred.opr.grad.del <- read.csv2(file = 'podatki/Vrednost_opravljenih_gradbenih_del.csv', fileEncoding = 'Windows-1250', header = TRUE,
                              skip = 3, nrows = 2030, sep = ';', dec = '.', na = c('', '-', ' ') )
vred.opr.grad.del <- vred.opr.grad.del %>% fill(1:2) %>% filter(Leto != ' ')

# 11.tabela: gradbena dovoljenja po vrstah stavb
grad.dovol.stavb <- read.csv2(file = 'podatki/Gradbena_dovoljenja_vrsta_stavbe.csv', fileEncoding = 'Windows-1250', header = TRUE,
                               skip = 3, nrows = 483, sep = ';', dec = '.', na = c('', '-', ' ') )
grad.dovol.stavb <- grad.dovol.stavb %>% fill(1:3) %>% filter(Leto != ' ')
grad.dovol.regije <- grad.dovol.stavb %>%filter(Regija != 'SLOVENIJA') %>%filter(Tip.objekta == 'Tip stavbe - SKUPAJ')


write.csv2(prenas.stanovanj,'podatki/tidy_prenas_stanovanj.csv', fileEncoding = 'UTF-8')
write.csv2(grad.dovol.stat.reg,'podatki/tidy_grad_dovol_stat_reg.csv', fileEncoding = 'UTF-8')
write.csv2(grad.dovol.stavb,'podatki/tidy_grad_dovol_stavb.csv', fileEncoding = 'UTF-8')
write.csv2(izob.obcine,'podatki/tidy_izob_obcine.csv', fileEncoding = 'UTF-8')
write.csv2(krim.obcine,'podatki/tidy_krim_obcine.csv', fileEncoding = 'UTF-8')
write.csv2(ocena.dokon.stavb,'podatki/tidy_ocena_dokon_stavb.csv', fileEncoding = 'UTF-8')
write.csv2(ocena.dokon.stavb.obcine,'podatki/tidy_ocena_dokon_stavb_obcine.csv', fileEncoding = 'UTF-8')
write.csv2(ocena.stanovanj.gradnja,'podatki/tidy_ocena_stanovanj_gradnja.csv', fileEncoding = 'UTF-8')
write.csv2(povp.mes.place.obcine,'podatki/tidy_povp_mes_place_obcine.csv', fileEncoding = 'UTF-8')
write.csv2(stanovanjski.standard,'podatki/tidy_stanovanjski_standard.csv', fileEncoding = 'UTF-8')
write.csv2(vred.opr.grad.del,'podatki/tidy_vred_opr_grad_del.csv', fileEncoding = 'UTF-8')


