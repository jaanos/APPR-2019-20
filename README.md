# Analiza podatkov s programom R, 2019/20

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2019/20

* [![Shiny](http://mybinder.org/badge.svg)](http://mybinder.org/v2/gh/Babnik21/APPR-2019-20/master?urlpath=shiny/APPR-2019-20/projekt.Rmd) Shiny
* [![RStudio](http://mybinder.org/badge.svg)](http://mybinder.org/v2/gh/Babnik21/APPR-2019-20/master?urlpath=rstudio) RStudio

## Analiza košarkarjev lige NBA

Analiziral bom košarkarje lige NBA. Primerjal jih bom po različnih kategorijah in poskušal ugotoviti,
kako različni faktorji (višina, starost, državljanstvo, pozicija,...) vplivajo na različne aspekte njihove igre (točke, podaje, skoki,...)

Poiskal bom podatke o košarkarjih od leta 1950 do 2017 (upošteval bom le redne dele), iz njih pa izluščil predvsem naslednje:

* Osnovne statistčne podatke igralcev (točke, skoki, podaje, ukradene žoge, blokade, itd.)
* +/- (skupni rezultat ekipe v času, ki ga igralec preživi na igrušču)
* Uspeh igralčeve ekipe v posamezni sezoni (št. zmag in porazov)
* Osnovne lastnosti igralcev (višina, teža, itd.)
* Starost ter izkušnje
* Državljanstvo

Zanima me predvsem, če obstaja povezava med katero od lastnosti igralca in njegovimi statističnimi podatki,
npr. ali mlajši igralci v povprečju izgubijo več žog kot starejši.


Podatke o trenutnih igralcih lige NBA bom črpal z naslova https://www.basketball-reference.com/ ter csv datotek, shranjenih
v mapi "nba_data".


## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `rgdal` - za uvoz zemljevidov
* `rgeos` - za podporo zemljevidom
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `tidyr` - za preoblikovanje podatkov v obliko *tidy data*
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
ob naslednjem zagonu bo mogoče delati commite.
Te podatke lahko nastavite tudi z `git config --global` v konzoli
(vendar bodo veljale le v trenutni seji).
