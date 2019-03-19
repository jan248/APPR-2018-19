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


# 12. tabela: gradbena dovoljenja po regijah površina stavb
grad.dovol.povrsina <- read.csv2(file = 'podatki/Grad_dovol_povrsina.csv', fileEncoding = 'Windows-1250', header = TRUE,
                          skip = 3, nrows = 543, sep = ';', dec = '.', na = c('', '-', ' ') )
grad.dovol.povrsina <- grad.dovol.povrsina[c(-3:-5)]
colnames(grad.dovol.povrsina)<-c('Regija','Leto','Povrsina')
grad.dovol.povrsina <- grad.dovol.povrsina %>% fill(1:2) %>% filter(Povrsina != ' ')

# 13. tabela: gradbena dovoljenja po regijah število stavb
grad.dovol.st.stavb <- read.csv2(file = 'podatki/Grad_dovoljenje_st_stavb.csv', fileEncoding = 'Windows-1250', header = TRUE,
                                 skip = 3, nrows = 540, sep = ';', dec = '.', na = c('', '-', ' ') )
grad.dovol.st.stavb <- grad.dovol.st.stavb[c(-3:-5)]
colnames(grad.dovol.st.stavb)<-c('Regija','Leto','Stevilo.stavb')
grad.dovol.st.stavb <- grad.dovol.st.stavb %>% fill(1:2) %>% filter(Stevilo.stavb != ' ')

# 14. tabela: indeksi stroškov
indeksi.stroskov <- read.csv2(file = 'podatki/Indeksi_stroskov.csv', fileEncoding = 'Windows-1250', header = TRUE,
                                 skip = 1, nrows = 152, sep = ';', dec = '.', na = c('', '-', ' ') )
indeksi.stroskov <- indeksi.stroskov[c(-2)]
colnames(indeksi.stroskov)<-c('Leto','Indeksi.stroskov')
indeksi.stroskov <- indeksi.stroskov %>% fill(1:2) %>% filter(Indeksi.stroskov != ' ')


# 15. tabela: živorojeni po regijah
zivorojeni.reg <- read.csv2(file = 'podatki/Zivorojeni_regije.csv', fileEncoding = 'Windows-1250', header = TRUE,
                              skip = 2, nrows = 204, sep = ';', dec = '.', na = c('', '-', ' ') )
colnames(zivorojeni.reg)<-c('Regija','Leto','Stevilo')
zivorojeni.reg <- zivorojeni.reg %>% fill(1:2) %>% filter(Stevilo != ' ')


# 16. tabela: prebivalstvo po regijah
preb.reg <- read.csv2(file = 'podatki/Prebivalstvo_regije.csv', fileEncoding = 'Windows-1250', header = TRUE,
                              skip = 2, nrows = 469, sep = ';', dec = '.', na = c('', '-', ' ') )
preb.reg <- preb.reg[c(-1,-4)]
colnames(preb.reg)<-c('Regija','Leto','Stevilo')
preb.reg <- preb.reg %>% fill(1:2) %>% filter(Stevilo != ' ')

# 17. tabela: prisotnost kriminala po regijah
krim.regije <- read.csv2(file = 'podatki/Prisotnost_kriminala_regije.csv', fileEncoding = 'Windows-1250', header = TRUE,
                              skip = 1, nrows = 231, sep = ';', dec = '.', na = c('', '-', ' ') )
krim.regije <- krim.regije[c(-3)]
colnames(krim.regije)<-c('Regija','Leto','Stevilo')
krim.regije <- krim.regije %>% fill(1:2) %>% filter(Stevilo != ' ')

# 18. tabela: onesnaženost okolja po regijah
ones.reg <- read.csv2(file = 'podatki/Onesnazenost_okolja_regije.csv', fileEncoding = 'Windows-1250', header = TRUE,
                         skip = 1, nrows = 231, sep = ';', dec = '.', na = c('', '-', ' ') )
ones.reg <- ones.reg[c(-3)]
colnames(ones.reg)<-c('Regija','Leto','Stevilo')
ones.reg <- ones.reg %>% fill(1:2) %>% filter(Stevilo != ' ')


# 19. tabela: težave s hrupom po regijah
hrup.reg <- read.csv2(file = 'podatki/Tezave_s_hrupom_regije.csv', fileEncoding = 'Windows-1250', header = TRUE,
                      skip = 1, nrows = 231, sep = ';', dec = '.', na = c('', '-', ' ') )
hrup.reg <- hrup.reg[c(-3)]
colnames(hrup.reg)<-c('Regija','Leto','Stevilo')
hrup.reg <- hrup.reg %>% fill(1:2) %>% filter(Stevilo != ' ')

# 20. tabela: premalo svetlobe po regijah
svet.reg <- read.csv2(file = 'podatki/Premalo_svetlobe_regije.csv', fileEncoding = 'Windows-1250', header = TRUE,
                      skip = 1, nrows = 231, sep = ';', dec = '.', na = c('', '-', ' ') )
svet.reg <- svet.reg[c(-3)]
colnames(svet.reg)<-c('Regija','Leto','Stevilo')
svet.reg <- svet.reg %>% fill(1:2) %>% filter(Stevilo != ' ')

# 21. tabela: ni primernega ogrevanja po regijah
ogrev.reg <- read.csv2(file = 'podatki/Ni_primernega_ogrevanja_regije.csv', fileEncoding = 'Windows-1250', header = TRUE,
                      skip = 1, nrows = 231, sep = ';', dec = '.', na = c('', '-', ' ') )
ogrev.reg <- ogrev.reg[c(-3)]
colnames(ogrev.reg)<-c('Regija','Leto','Stevilo')
ogrev.reg <- ogrev.reg %>% fill(1:2) %>% filter(Stevilo != ' ')

# 22. tabela: slabo stanje stanovanj po regijah
slab.stan.reg <- read.csv2(file = 'podatki/Slabo_stanje_stanovanj_regije.csv', fileEncoding = 'Windows-1250', header = TRUE,
                      skip = 1, nrows = 231, sep = ';', dec = '.', na = c('', '-', ' ') )
slab.stan.reg <- slab.stan.reg[c(-3)]
colnames(slab.stan.reg)<-c('Regija','Leto','Stevilo')
slab.stan.reg <- slab.stan.reg %>% fill(1:2) %>% filter(Stevilo != ' ')


# 23. tabela: dokončana stanovanja v Sloveniji
dokon.stan.slo <- read.csv2(file = 'podatki/Dokoncana_stanovanja_slo.csv', fileEncoding = 'Windows-1250', header = TRUE,
                           skip = 6, nrows = 10, sep = ';', dec = '.', na = c('', '-', ' ') )
dokon.stan.slo <- dokon.stan.slo[c(-1:-4)]
colnames(dokon.stan.slo)<-c('Leto','Stevilo')










write.csv2(prenas.stanovanj,'podatki/tidy_prenas_stanovanj.csv', fileEncoding = 'UTF-8')
write.csv2(grad.dovol.stat.reg,'podatki/tidy_grad_dovol_stat_reg.csv', fileEncoding = 'UTF-8')
write.csv2(grad.dovol.stavb,'podatki/tidy_grad_dovol_stavb.csv', fileEncoding = 'UTF-8')

write.csv2(ocena.dokon.stavb,'podatki/tidy_ocena_dokon_stavb.csv', fileEncoding = 'UTF-8')

write.csv2(ocena.stanovanj.gradnja,'podatki/tidy_ocena_stanovanj_gradnja.csv', fileEncoding = 'UTF-8')

write.csv2(stanovanjski.standard,'podatki/tidy_stanovanjski_standard.csv', fileEncoding = 'UTF-8')
write.csv2(vred.opr.grad.del,'podatki/tidy_vred_opr_grad_del.csv', fileEncoding = 'UTF-8')


