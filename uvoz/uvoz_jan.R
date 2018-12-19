library(dplyr)
library(tidyr)

# 1. tabela: brezposelnost po regijah
brezposelnost.po.regijah<-read.csv2(file = 'podatki/Brezposelnost po regijah.csv', fileEncoding = 'Windows-1250', header = TRUE,
                                    nrows = 9)
# 2.tabela: stanovanjski standart
stanovanjski.standard <- read.csv2(file = 'podatki/Stanovanjski standard.csv', fileEncoding = 'Windows-1250', header = FALSE,
                                   skip = 4, nrows = 213,col.names = c('Regija', '2011', '2015'), na = c('', '-', ' ') )
