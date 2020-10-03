### Analiza podatkov s programom R, 2019/20

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2019/20

* [![Shiny](http://mybinder.org/badge.svg)](http://mybinder.org/v2/gh/StanicR17/APPR-2019-20/master?urlpath=shiny/APPR-2019-20/projekt.Rmd) Shiny
* [![RStudio](http://mybinder.org/badge.svg)](http://mybinder.org/v2/gh/StanicR17/APPR-2019-20/master?urlpath=rstudio) RStudio

### COVID-19 v Sloveniji in po svetu

V projektu bom analiziral število obolelih in število testiranj za COVID-19. V prvem sklopu se bom osredotočil na Slovenijo v drugem pa na podatke iz celotnega sveta.

Tabele: 
1. Tabela 1: COVID-19 v Sloveniji 
  - `datum` - spremenljivka: datum,
  - `rutinsko.dnevno` - meritev: število rutinskih testiranj dnevno,
  - `raziskava.dnevno` - meritev: število  testiranjv sklopu raziskave dnevno,
  - `moski` - spremenljivka: število pozitivnih testov moških,
  - `zenske` - spremenljivka: število pozitivnih testov žensk,
  - 'delovni.dan' - logični operator: nakazuje ali je delovni dan ali vikend.
  
2. Tabela 2: COVID-19 po Svetu 
  - `date` - spremenljivka: datum,
  - `location` - spremenljivka: država,
  - `new_tests` - meritev: število novih dnevnih testov,
  - `continent` - spremenljivka: celina,
  - `iso_code` -spremenljivka: krajšava države,
  - `total cases` - meritev: število vseh potrjenih primerov,
  - `total_deaths` - meritev: število vseh smrti,
  - `total_deaths_per_million` - meritev: število smtrni na milijon prebivalcev,
  - `total_cases_per_million` - meritev: število vseh primerov na milijon prebivalcev,
  - `life_expectancy` - spremenljivka: pričakovana življenska doba,
  - `extreme_poverty` - spremenljivka: odstotek izjemno revnega prebivalstva.
  - `population` - spremenljivka: število prebivalcev države,
  - `median age` - spremenljivka: medianska starost prebivalstva,
  - `aged 65 or older` - spremenljivka: odstotek ljudi, ki so starejši od 65 let,
  - `aged 70 or older` - spremenljivka: odstotek ljudi, ki so starejši od 70 let
  - `diabetics preveilance` - spremenljivka: prebivalstvo z Diabetesom.
3. Tabela 3: Populacija celin
  - `population_continent` -spremenljivka: prebivalci celine,
  - `continent` - spremenljivka: celina.


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
* `tmap` - za izrisovanje zemljevidov
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
