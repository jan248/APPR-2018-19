# Analiza podatkov s programom R, 2018/19

# Jan Skoberne

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2018/19

* [![Shiny](http://mybinder.org/badge.svg)](http://beta.mybinder.org/v2/gh/jaanos/APPR-2018-19/master?urlpath=shiny/APPR-2018-19/projekt.Rmd) Shiny
* [![RStudio](http://mybinder.org/badge.svg)](http://beta.mybinder.org/v2/gh/jaanos/APPR-2018-19/master?urlpath=rstudio) RStudio

## Analiza gradbeništva v Sloveniji

Izbral sem si temo gradbeništvo po Sloveniji. Analiziral bom gradbeništvo po regijah in ugotavljal kje je ta gospodarstvena panoga najbolj in najmanj aktivna. Primerjal bom oceno stanovanj in stavb po regijah ter občinah, vrednost opravljenih gradbenih del, izdana gradbena dovoljenja po statističnih regijah in to primerjal z izobraženostjo ljudi, povprečno plačo, prenaseljenostjo stanovanj, stanovanjskim standardom, brezposelnostjo ter kriminaliteto po teh statističnih regijah.

Tabele za stanovanja v gradnji, gradbena dovoljenja in vrednost gradbenih del sem podal s povezavami do spletne strani, tabele s katerimi jih bom primerjal, torej izobraženostjo ljudi, povprečno plačo, prenaseljenostjo stanovanj, stanovanjskim standardom, brezposelnostjo ter kriminaliteto po statističnih regijah pa sem podal med podatke.

Želim raziskati povezavo med gradnjo stanovanj in pripadajočih elementov z različnimi kategorijami, ki bi lahko na to vplivale in to primerjati po občinah oziroma regijah. Zanima me tudi, kako so se te povezave spreminjale skozi leta in njihova kohezija.

Podatke bom pridobil iz Statističnega urada Republike Slovenije.

# Tabele
Povezave do tabel:
https://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=1906901S&ti=&path=../Database/Ekonomsko/19_gradbenistvo/05_19069_graditev_stan/&lang=2
Ocena stanovanj v gradnji in dokončanih stanovanj, Slovenija, letno

https://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=1906910S&ti=&path=../Database/Ekonomsko/19_gradbenistvo/05_19069_graditev_stan/&lang=2
Ocena dokončanih stanovanj - izbrani kazalniki, po statističnih regijah Slovenije, letno

https://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=1906911S&ti=&path=../Database/Ekonomsko/19_gradbenistvo/05_19069_graditev_stan/&lang=2
Ocena dokončanih stanovanj - izbrani kazalniki, po občinah Slovenije, letno

https://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=1923801S&ti=&path=../Database/Ekonomsko/19_gradbenistvo/05_19238_graditev_stavb/&lang=2
Ocena dokončanih stavb in stavb v gradnji ob koncu leta, Slovenija, letno

https://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=1919801S&ti=&path=../Database/Ekonomsko/19_gradbenistvo/07_19198_vrednost_del/&lang=2
Vrednost opravljenih gradbenih del [v EUR] po tipu gradbene aktivnosti in vrsti objektov, Slovenija, letno

https://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=1970716S&ti=&path=../Database/Ekonomsko/19_gradbenistvo/06_19707_dovoljenja/&lang=2
Dovoljenja za gradnjo stavb: število stavb, njihova gradbena velikost in stanovanja v njih, glede na vrsto stavbe in vrsto investitorja, po statističnih regijah Slovenije, letno

## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`.
Ko ga prevedemo, se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`.
Podatkovni viri so v mapi `podatki/`.
Zemljevidi v obliki SHP, ki jih program pobere,
se shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `rgdal` - za uvoz zemljevidov
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `mosaic` - za pretvorbo zemljevidov v obliko za risanje z `ggplot2`
* `maptools` - za delo z zemljevidi
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)

## Binder

Zgornje [povezave](#analiza-podatkov-s-programom-r-201819)
omogočajo poganjanje projekta na spletu z orodjem [Binder](https://mybinder.org/).
V ta namen je bila pripravljena slika za [Docker](https://www.docker.com/),
ki vsebuje večino paketov, ki jih boste potrebovali za svoj projekt.

Če se izkaže, da katerega od paketov, ki ji potrebujete, ni v sliki,
lahko za sprotno namestitev poskrbite tako,
da jih v datoteki [`install.R`](install.R) namestite z ukazom `install.packages`.
Te datoteke (ali ukaza `install.packages`) **ne vključujte** v svoj program -
gre samo za navodilo za Binder, katere pakete naj namesti pred poganjanjem vašega projekta.

Tako nameščanje paketov se bo izvedlo pred vsakim poganjanjem v Binderju.
Če se izkaže, da je to preveč zamudno,
lahko pripravite [lastno sliko](https://github.com/jaanos/APPR-docker) z želenimi paketi.

Če želite v Binderju delati z git,
v datoteki `gitconfig` nastavite svoje ime in priimek ter e-poštni naslov
(odkomentirajte vzorec in zamenjajte s svojimi podatki) -
ob naslednjem.zagonu bo mogoče delati commite.
Te podatke lahko nastavite tudi z `git config --global` v konzoli
(vendar bodo veljale le v trenutni seji).
