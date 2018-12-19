library(dplyr)
library(tidyr)


# 2.tabela: stanovanjski standart
stanovanjski.standard <- read.csv2(file = 'podatki/Stanovanjski standard.csv', fileEncoding = 'Windows-1250', header = FALSE,
                                   skip = 4, nrows = 213,col.names = c('Regija', '2011', '2015'),sep = ';', dec = '.', na = c('', '-', ' ') )
# 3.tabela: stanovanja v gradnji
ocena.stanovanj.gradnja <- read.csv2(file = 'podatki/Ocena_stanovanj_v_gradnji.csv', fileEncoding = 'Windows-1250', header = FALSE,
                                        skip = 4, nrows = 11, na = c('', '-', ' '), sep = ';', dec = '.',
                                     col.names = c('oaknfoans','Leto','Stanovanja v gradnji - SKUPAJ','Stanovanja v gradnji - z začetkom gradnje v letu','Stanovanja v gradnji ob koncu leta','Dokončana stanovanja - SKUPAJ
','Dokončana stanovanja - investitor pravna oseba','Dokončana stanovanja - investitor fizična oseba','Dokončana stanovanja na 1000 prebivalcev','baifba'))
ocena.stanovanj.gradnja <- ocena.stanovanj.gradnja[,-1]
ocena.stanovanj.gradnja <- ocena.stanovanj.gradnja[,-9]
ocena.stanovanj.gradnja <- ocena.stanovanj.gradnja%>% filter(Leto != ' ')
