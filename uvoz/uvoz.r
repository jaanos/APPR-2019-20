# 2. faza: Uvoz podatkov
source("lib/libraries.r", encoding="UTF-8")




#Funkcija, ki uvozi excel tabelo za plače

uvoz.place <- function(Tabela_place) {
  Tabela_place <- read_csv2("podatki/earn_nt_net.csv", col_names = TRUE, na=":", locale=locale(encoding="Windows-1250"))
  Tabela_place <- Tabela_place[ -c(31:43), ]
  Tabela_place[Tabela_place == "Czechia"] <- "Czech Republic"   #ročno popravimo imena držav, ki so drugače zapisana
  colnames(Tabela_place)[1] <- "Drzava"  #spremenimo ime prvega stolpca
  Tabela_place <- na.omit(Tabela_place)   #držav, za katere nimamo vseh podatkov, ne bomo preučevali
  return(Tabela_place)
}

#Funkcija, ki uvozi excel tabelo za BDP per capita

uvoz.BDP <- function(Tabela_BDP) {
  Tabela_BDP <- read_xlsx("podatki/BDP_pc.xlsx", na="-")
  Tabela_BDP <- Tabela_BDP[ -c(31:35), ]
  Tabela_BDP[Tabela_BDP == "Czechia"] <- "Czech Republic"   #ročno popravimo imena držav, ki so drugače zapisana
  colnames(Tabela_BDP)[1] <- "Drzava"
  Tabela_BDP<-Tabela_BDP[!(Tabela_BDP$Drzava=="Cyprus" | Tabela_BDP$Drzava=="Croatia"),]  # za ti dve državi nimamo podatkov o plačah
  return(Tabela_BDP)
}

#Funkcija, ki uvozi excel tabelo za davke

uvoz.davki <- function(Tabela_davki) {
  Tabela_davki <- read_xls("podatki/earn_nt_taxrate.xls", na=":")
  Tabela_davki <- na.omit(Tabela_davki)   #držav, za katere nimamo vseh podatkov, ne bomo preučevali
  Tabela_davki[Tabela_davki == "Czechia"] <- "Czech Republic"   #ročno popravimo imena držav, ki so drugače zapisana
  colnames(Tabela_davki)[1] <- "Drzava"
  return(Tabela_davki)
}

#Funkcija, ki uvozi povprečno starost iz wikipedije

uvoz.starost <- function(Tabela_starost) {
  link_starost <- "https://en.wikipedia.org/wiki/List_of_countries_by_median_age"
  stran_starost <- session(link_starost) %>% read_html()
  Tabela_starost <- stran_starost %>% html_nodes(xpath = "//table[@class='wikitable sortable plainrowheaders']") %>%
    .[[1]] %>% html_table(dec=".",fill = TRUE)
  Tabela_starost <- Tabela_starost[ ,c("Country/Territory", "Median ages in years")]
  names(Tabela_starost) <- c("Drzava", "Povprecna.starost")
  Tabela_starost[, c(2)] <- sapply(Tabela_starost[, c(2)], as.numeric) #popravimo, da ima 2. stolpec class numeric
  return(Tabela_starost)
}

#Funkcija, ki uvozi datume samostojnosti iz wikipedije

uvoz.samostojnost <- function(Tabela_samostojnost) {
  link_samostojnost <- "https://en.wikipedia.org/wiki/List_of_national_independence_days"
  stran_samostojnost <- session(link_samostojnost) %>% read_html()
  Tabela_samostojnost <- stran_samostojnost %>% html_nodes(xpath = "//table[@class='wikitable sortable']") %>%
    .[[1]] %>% html_table(dec=".", fill = TRUE)
  Tabela_samostojnost <- Tabela_samostojnost[ ,c("Country", "Year of event")]
  names(Tabela_samostojnost) <- c("Drzava", "Leto.osamosvojitve")
  Tabela_samostojnost[, c(2)] <- sapply(Tabela_samostojnost[, c(2)], as.numeric) #popravimo, da ima 2. stolpec class numeric
  Tabela_samostojnost[78, 2] = 1871  #ročno dodamo leto združitve
  Tabela_samostojnost[186, 2] = 1492 #ročno dodamo leto ustanovitve
  Tabela_samostojnost[97, 2] = 1870 #ročno dodamo leto združitve
  Tabela_samostojnost[120, 2] = 1867 #ročno dodamo leto ustanovitve
  Tabela_samostojnost[56, 2] = 1849 #ročno dodamo leto ustanovitve
  Tabela_samostojnost <- na.omit(Tabela_samostojnost) #ostalih ne bomo potrebovali
  Tabela_samostojnost <- Tabela_samostojnost[!duplicated(Tabela_samostojnost$Drzava), ]  #če ima država več vnosov, obdržimo prvega
  Tabela_samostojnost[Tabela_samostojnost == "Netherlands, The"] <- "Netherlands"
  Tabela_samostojnost <- rbind(Tabela_samostojnost, c('United Kingdom',1000))  #zmislimo si leto združitve UK, za potrebe nadaljne analize;dodamo vrstico
  return(Tabela_samostojnost)
}

#Funkcija, ki uvozi velikost držav iz wikipedije

uvoz.velikost <- function(Tabela_velikost) {
  link_velikost <- "https://en.wikipedia.org/wiki/List_of_countries_and_dependencies_by_area"
  stran_velikost <- session(link_velikost) %>% read_html()
  Tabela_velikost <- stran_velikost %>% html_nodes(xpath = "//table[@class='wikitable sortable']") %>%
    .[[1]] %>% html_table(dec=".",fill = TRUE)
  Tabela_velikost <- Tabela_velikost[ ,c(2,3)]
  Tabela_velikost[Tabela_velikost == "Kingdom of Denmark"] <- "Denmark"   #ročno popravimo imena držav, ki so drugače zapisana
  Tabela_velikost[Tabela_velikost == "France (metropolitan)"] <- "France"
  Tabela_velikost[Tabela_velikost == "Norway (mainland)"] <- "Norway"
  return(Tabela_velikost)
}

#Funkcija, ki uvozi stopnjo kriminala iz strani numbeo

uvoz.kriminal <- function(Tabela_kriminal) {
  link_kriminal <- "https://www.numbeo.com/crime/rankings_by_country.jsp?title=2018&region=150"
  stran_kriminal <- session(link_kriminal) %>% read_html()
  Tabela_kriminal <- stran_kriminal %>% html_nodes(xpath = "//table[@class='stripe row-border order-column compact']") %>%
    .[[1]] %>% html_table(dec=".",fill = TRUE)
  Tabela_kriminal <- Tabela_kriminal[ ,c(2,3)]
  names(Tabela_kriminal) <- c("Drzava", "Stopnja.kriminala")
  return(Tabela_kriminal)
}

#Funkcija, ki uvozi življenske stroške iz strani numbeo

uvoz.stroski <- function(Tabela_stroski) {
  link_stroski <- "https://www.numbeo.com/cost-of-living/rankings_by_country.jsp?title=2018&region=150"
  stran_stroski <- session(link_stroski) %>% read_html()
  Tabela_stroski <- stran_stroski %>% html_nodes(xpath = "//table[@class='stripe row-border order-column compact']") %>%
    .[[1]] %>% html_table(dec=".",fill = TRUE)
  Tabela_stroski <- Tabela_stroski[ ,c(2,3)]
  names(Tabela_stroski) <- c("Drzava", "Zivljenski.stroski")
  return(Tabela_stroski)
}


Tabela_place <- uvoz.place()
Tabela_BDP <- uvoz.BDP()
Tabela_davki <- uvoz.davki()
Tabela_starost <- uvoz.starost()
Tabela_samostojnost <- uvoz.samostojnost()
Tabela_velikost <- uvoz.velikost()
Tabela_kriminal <- uvoz.kriminal()
Tabela_stroski <- uvoz.stroski()

#Odstranimo podatke v miljah

Tabela_velikost <- Tabela_velikost %>% # Tako strukturo naredi paket DPLYR
  mutate(povrsina_neociscena = .[[2]], # sprememba imen obeh stolpcev, da se lažje sklicujemo na njih
         Drzava = .[[1]]) %>%
  select(Drzava, povrsina_neociscena) %>% # Ohranimo samo še nova dva stolpca
  mutate(Povrsina = gsub("\\([^()]*\\)", "", povrsina_neociscena)) %>% # Tukaj se zbrišejo oklepaji (milje)
  mutate(Povrsina = gsub(",", "", Povrsina)) %>% # Zbrišemo vejice pri tisočicah
  select(Drzava, Povrsina) # Zavržemo stolpec povrsina_neociscena
Tabela_velikost$Povrsina <- as.numeric(as.character(Tabela_velikost$Povrsina)) #popravimo, da ima 2. stolpec class numeric
Tabela_velikost <- Tabela_velikost[!duplicated(Tabela_velikost$Drzava), ]  #če ima država več vnosov, obdržimo prvega






Tabela_place2018 <- Tabela_place[,c(1,12) ]  #za nekatere analize bomo potrebovali samo leto 2018
names(Tabela_place2018) <- c("Drzava", "Placa")

Tabela_BDP2018 <- Tabela_BDP[,c(1,12) ]  #za nekatere analize bomo potrebovali samo leto 2018
names(Tabela_BDP2018) <- c("Drzava", "BDP")

Tabela_davki2018 <- Tabela_davki[,c(1,12) ]  #za nekatere analize bomo potrebovali samo leto 2018
names(Tabela_davki2018) <- c("Drzava", "Davki")



Tabela_skupna <- Tabela_place2018 %>% inner_join(uvoz.stroski(), "Drzava"="Drzava") %>%
  inner_join(uvoz.starost(), "Drzava"="Drzava") %>%
  inner_join(uvoz.kriminal(), "Drzava"="Drzava") %>%
  inner_join(uvoz.samostojnost(), "Drzava" = "Drzava") %>%
  inner_join(uvoz.starost(), "Drzava" = "Drzava") %>%
  inner_join(Tabela_BDP2018, "Drzava"="Drzava") %>%
  inner_join(Tabela_velikost, "Drzava"="Drzava") %>%
  inner_join(Tabela_davki2018, "Drzava"="Drzava")


