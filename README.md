# Analiza podatkov s programom R, 2019/20

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2019/20

* [![Shiny](http://mybinder.org/badge.svg)](http://mybinder.org/v2/gh/mperbil/APPR-2019-20/master?urlpath=shiny/APPR-2019-20/projekt.Rmd) Shiny
* [![RStudio](http://mybinder.org/badge.svg)](http://mybinder.org/v2/gh/mperbil/APPR-2019-20/master?urlpath=rstudio) RStudio

## Tematika

ANALIZA NOGOMETNIH VRATARJEV

Analiziral bom vse vratarje, ki so v sezoni 2018/2019 zbrali vsaj 5 nastopov v kateri od petih najmočnejših evropskih lig(to so španska, angleška, italjanska, nemška ter francoska).
Vratarje bom analiziral in primerjal glede na tekme brez prejetega zadetka, obrambe(izven 16m, znotraj 16m, enajstmetrovke) absolutno in relativno(glede na število strelov),
njihovo vključevanje v igro(izhod iz golove črte(uspešen, neuspešen), posredovanje pri predložkih) ter igro z nogo oz. točnost podaj(dolge, kratke podaje, asistence). 
Primerjal bom tudi lige glede na uspešnost vratarjev in poiskal povezave med uspešnostjo vratarjev ter končno uspešnostjo ekip za katere branijo.

Tabele:
Tabela 1:
- vratarji
- tekme brez prejetega zadetka
- odigrane tekme

Tabela 2:
- vratarji
- obrambe strelov izven 16m
- odstotek obramb strelov izven 16m
- obrambe strelov znotraj 16m
- odstotek obramb strelov znotraj 16m
- obrambe enajstmetrovk
- odstotek obramb enajstmetrovk

Tabela 3:
- vratarji
- izhodi iz golove črte
- uspešni izhodi iz golove črte
- uspešno posredovanje pri predložkih
- napake pri predložkih

Tabela 4:
- vratarji
- kratke podaje
- uspešnost kratkih podaj v odstotkih
- dolge podaje
- uspešnost dolgih podaj v odstotkih
- asistence za zadetek

Viri podatkov:
- SofaScore: https://www.sofascore.com/sl/
- Wikipedia: https://en.wikipedia.org/wiki/2018%E2%80%9319_La_Liga
https://en.wikipedia.org/wiki/2018%E2%80%9319_Bundesliga
https://en.wikipedia.org/wiki/2018%E2%80%9319_Premier_League
https://en.wikipedia.org/wiki/2018%E2%80%9319_Serie_A
https://en.wikipedia.org/wiki/2018%E2%80%9319_Ligue_1


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
