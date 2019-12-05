# Analiza podatkov s programom R, 2019/20

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2019/20

* [![Shiny](http://mybinder.org/badge.svg)](http://mybinder.org/v2/gh/jaanos/APPR-2019-20/master?urlpath=shiny/APPR-2019-20/projekt.Rmd) Shiny
* [![RStudio](http://mybinder.org/badge.svg)](http://mybinder.org/v2/gh/jaanos/APPR-2019-20/master?urlpath=rstudio) RStudio

## Analiza plač v Evropi

V projektni nalogi bom analiziral bruto in neto plače različnih evropskih držav. Prav tako bom primerjal plače glede na različne spremenljivke(BDP) te države. Podrobneje bom analiziral Slovenijo. Plače bom primerjal tudi geografsko in jih povezal z BDP-jem te države. Primerjal bom odvisnost povprečne starosti s povprečno plačo držav.

## Podatkovni viri

* povprečne plače v Evropi: https://www.reinisfischer.com/average-salary-european-union-2018
* plače v Sloveniji: https://pxweb.stat.si/SiStatDb/pxweb/sl/10_Dem_soc/10_Dem_soc__07_trg_dela__10_place__01_07010_place/0701011S.px/
* BDP na prebivalca v Evropi: https://ec.europa.eu/eurostat/databrowser/view/sdg_08_10/default/table?lang=en
* povprečna starost v evropskih državah: http://appsso.eurostat.ec.europa.eu/nui/show.do?query=BOOKMARK_DS-747455_QID_-1F3DBD9B_UID_-3F171EB0&layout=TIME,C,X,0;GEO,B,Y,0;INDIC_DE,L,Z,0;UNIT,L,Z,1;INDICATORS,C,Z,2;&zSelection=DS-747455UNIT,YR;DS-747455INDIC_DE,MEDAGEPOP;DS-747455INDICATORS,OBS_FLAG;&rankName1=UNIT_1_2_-1_2&rankName2=INDICATORS_1_2_-1_2&rankName3=INDIC-DE_1_2_-1_2&rankName4=TIME_1_0_0_0&rankName5=GEO_1_2_0_1&sortC=ASC_-1_FIRST&rStp=&cStp=&rDCh=&cDCh=&rDM=true&cDM=true&footnes=false&empty=false&wai=false&time_mode=ROLLING&time_most_recent=true&lang=EN&cfo=%23%23%23%2C%23%23%23.%23%23%23
https://appsso.eurostat.ec.europa.eu/nui/show.do?dataset=earn_nt_net&lang=en
https://appsso.eurostat.ec.europa.eu/nui/show.do?query=BOOKMARK_DS-053406_QID_2B09D227_UID_-3F171EB0&layout=TIME,C,X,0;GEO,L,Y,0;AGE,L,Z,0;SEX,L,Z,1;INDIC_IL,L,Z,2;UNIT,L,Z,3;INDICATORS,C,Z,4;&zSelection=DS-053406AGE,TOTAL;DS-053406INDIC_IL,MED_E;DS-053406UNIT,EUR;DS-053406INDICATORS,OBS_FLAG;DS-053406SEX,T;&rankName1=INDIC-IL_1_2_-1_2&rankName2=UNIT_1_2_-1_2&rankName3=AGE_1_2_-1_2&rankName4=INDICATORS_1_2_-1_2&rankName5=SEX_1_2_-1_2&rankName6=TIME_1_0_0_0&rankName7=GEO_1_2_0_1&sortC=ASC_-1_FIRST&rStp=&cStp=&rDCh=&cDCh=&rDM=true&cDM=true&footnes=false&empty=false&wai=false&time_mode=ROLLING&time_most_recent=false&lang=EN&cfo=%23%23%23%2C%23%23%23.%23%23%231_FIRST&rStp=&cStp=&rDCh=&cDCh=&rDM=true&cDM=true&footnes=false&empty=false&wai=false&time_mode=ROLLING&time_most_recent=false&lang=EN&cfo=%23%23%23%2C%23%23%23.%23%23%23&lang=en

## Zasnova podatkovnega modela

Zbral bom podatke po povprečni plači posameznih držav. V prvem stolpcu tabele bodo naštete države, v drugem in tretjem bruto in neto povprečne plače, v četrtem pa sprememba višine plač glede na prejšnje leto. V tabelo bom prav tako vključil podatke o povprečni starosti prebivalstva in podatke o višini BDP na prebivalca za posamezno državo. Z analizo bom poizkušal ugotoviti kakšne so povezave med analiziranimi spremenljivkami z višino povprečnih plač.

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
