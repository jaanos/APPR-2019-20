# 2. faza: Uvoz podatkov

#klic knjižnic
source("../lib/libraries.r", encoding="UTF-8")

## 1) TABELE IGRALCEV  - imena, narodnost, datumi rojstev, izvor

uvoz2021i <- function(Tabela_igralci20_21) {
  link <- "https://en.wikipedia.org/wiki/2020%E2%80%9321_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_igralci20_21 <- stran %>% html_nodes(xpath = "//table[@class='wikitable']") %>%
    .[[1]] %>% html_table(dec=".",fill = TRUE)
  Tabela_igralci20_21 <- Tabela_igralci20_21[ ,c("Player", "Nationality","Date of birth", "Signed from")]
  names(Tabela_igralci20_21) <- c("Igralec", "Narodnost", "Datum rojstva", "Izvor")
  Tabela_igralci20_21<-Tabela_igralci20_21[!(Tabela_igralci20_21$Igralec=="Goalkeepers" | Tabela_igralci20_21$Igralec=="Defenders" | Tabela_igralci20_21$Igralec=="Midfielders" | Tabela_igralci20_21$Igralec=="Forwards"),]
  return(Tabela_igralci20_21)
}
igralci2021 <- uvoz2021i() # tabela igralcev, sezona 2020/21

uvoz1920i <- function(Tabela_igralci19_20) {
  link <- "https://en.wikipedia.org/wiki/2019%E2%80%9320_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_igralci19_20 <- stran %>% html_nodes(xpath = "//table[@class='wikitable']") %>%
    .[[1]] %>% html_table(dec=".",fill = TRUE)
  Tabela_igralci19_20 <- Tabela_igralci19_20[ ,c("Name", "Nationality","Date of birth", "Signed from")]
  names(Tabela_igralci19_20) <- c("Igralec", "Narodnost", "Datum rojstva", "Izvor")
  Tabela_igralci19_20<-Tabela_igralci19_20[!(Tabela_igralci19_20$Igralec=="Goalkeepers" | Tabela_igralci19_20$Igralec=="Defenders" | Tabela_igralci19_20$Igralec=="Midfielders" | Tabela_igralci19_20$Igralec=="Forwards"),]
  return(Tabela_igralci19_20)
}
igralci1920 <- uvoz1920i() # tabela igralcev, sezona 2019/20

uvoz1819i <- function(Tabela_igralci18_19) {
  link <- "https://en.wikipedia.org/wiki/2018%E2%80%9319_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_igralci18_19 <- stran %>% html_nodes(xpath = "//table[@class='wikitable']") %>%
    .[[1]] %>% html_table(dec=".",fill = TRUE)
  Tabela_igralci18_19 <- Tabela_igralci18_19[ ,c("Name", "Nationality", "Date of Birth", "Signed From")]
  names(Tabela_igralci18_19) <- c("Igralec", "Narodnost", "Datum rojstva", "Izvor")
  Tabela_igralci18_19<-Tabela_igralci18_19[!(Tabela_igralci18_19$Igralec=="Goalkeepers" | Tabela_igralci18_19$Igralec=="Defenders" | Tabela_igralci18_19$Igralec=="Midfielders" | Tabela_igralci18_19$Igralec=="Forwards"),]
  return(Tabela_igralci18_19)
}
igralci1819 <- uvoz1819i() # tabela igralcev, sezona 2018/19

uvoz1718i <- function(Tabela_igralci17_18) {
  link <- "https://en.wikipedia.org/wiki/2017%E2%80%9318_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_igralci17_18 <- stran %>% html_nodes(xpath = "//table[@class='wikitable']") %>%
    .[[1]] %>% html_table(dec=".",fill = TRUE)
  Tabela_igralci17_18 <- Tabela_igralci17_18[ ,c("Name", "Nationality","Date of birth", "Signed from")]
  names(Tabela_igralci17_18) <- c("Igralec", "Narodnost", "Datum rojstva", "Izvor")
  Tabela_igralci17_18<-Tabela_igralci17_18[!(Tabela_igralci17_18$Igralec=="Goalkeepers" | Tabela_igralci17_18$Igralec=="Defenders" | Tabela_igralci17_18$Igralec=="Midfielders" | Tabela_igralci17_18$Igralec=="Forwards"),]
  return(Tabela_igralci17_18)
}
igralci1718 <- uvoz1718i() # tabela igralcev, sezona 2017/18

uvoz1718i <- function(Tabela_igralci17_18) {
  link <- "https://en.wikipedia.org/wiki/2017%E2%80%9318_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_igralci17_18 <- stran %>% html_nodes(xpath = "//table[@class='wikitable']") %>%
    .[[1]] %>% html_table(dec=".",fill = TRUE)
  Tabela_igralci17_18 <- Tabela_igralci17_18[ ,c("Name", "Nationality","Date of birth", "Signed from")]
  names(Tabela_igralci17_18) <- c("Igralec", "Narodnost", "Datum rojstva", "Izvor")
  Tabela_igralci17_18<-Tabela_igralci17_18[!(Tabela_igralci17_18$Igralec=="Goalkeepers" | Tabela_igralci17_18$Igralec=="Defenders" | Tabela_igralci17_18$Igralec=="Midfielders" | Tabela_igralci17_18$Igralec=="Forwards"),]
  return(Tabela_igralci17_18)
}
igralci1718 <- uvoz1718i() # tabela igralcev, sezona 2017/18

uvoz1617i <- function(Tabela_igralci16_17) {
  link <- "https://en.wikipedia.org/wiki/2016%E2%80%9317_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_igralci16_17 <- stran %>% html_nodes(xpath = "//table[@class='wikitable']") %>%
    .[[1]] %>% html_table(dec=".",fill = TRUE)
  Tabela_igralci16_17 <- Tabela_igralci16_17[ ,c("Name", "Nationality","Date of Birth", "Signed from")]
  names(Tabela_igralci16_17) <- c("Igralec", "Narodnost", "Datum rojstva", "Izvor")
  Tabela_igralci16_17<-Tabela_igralci16_17[!(Tabela_igralci16_17$Igralec=="Goalkeepers" | Tabela_igralci16_17$Igralec=="Defenders" | Tabela_igralci16_17$Igralec=="Midfielders" | Tabela_igralci16_17$Igralec=="Forwards"),]
  return(Tabela_igralci16_17)
}
igralci1617 <- uvoz1617i() # tabela igralcev, sezona 2016/17

## 2) TABELA UVRSTITEV PO TEKMOVANJIH - tekmovanja, kon?na uvrstitev, odigrane tekme, zmage, remiji, porazi

uvoz2021r <- function(Tabela_pregled20_21) {
  link <- "https://en.wikipedia.org/wiki/2020%E2%80%9321_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_pregled20_21 <- stran %>% html_nodes(xpath = "//table[@class='wikitable']") %>%
    .[[2]] %>% html_table(dec=".",fill = TRUE)
  Tabela_pregled20_21 <- Tabela_pregled20_21[-c(1),] #enak format kot za pretekle sezone
  names(Tabela_pregled20_21) <- c("Tekmovanje", "Datum prve tekme", "Datum zadnje tekme", "Zacetni krog", "Koncna uvrstitev", "Odigrane tekme", "Zmage", "Remiji", "Porazi", "Dani goli", "Prejeti goli", "Gol razlika", "Procent zmag")
  Tabela_pregled20_21 <- Tabela_pregled20_21[ ,c("Tekmovanje", "Odigrane tekme", "Zmage", "Remiji", "Porazi", "Gol razlika")]
  Tabela_pregled20_21[, c(2,3,4,5)] <- sapply(Tabela_pregled20_21[, c(2,3,4,5)], as.numeric) #class numeric za ?tevilo odigranih tekem
  return(Tabela_pregled20_21)
}
rezultati2021 <- uvoz2021r() #pregled sezone 2020/21

uvoz1920r <- function(Tabela_pregled19_20) {
  link <- "https://en.wikipedia.org/wiki/2019%E2%80%9320_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_pregled19_20 <- stran %>% html_nodes(xpath = "//table[@class='wikitable']") %>%
    .[[3]] %>% html_table(dec=".",fill = TRUE)
  Tabela_pregled19_20 <- Tabela_pregled19_20[-c(1),] #enak format kot za pretekle sezone
  names(Tabela_pregled19_20) <- c("Tekmovanje", "Odigrane tekme", "Zmage", "Remiji", "Porazi", "Dani goli", "Prejeti goli", "Gol razlika", "Procent zmag")
  Tabela_pregled19_20 <- Tabela_pregled19_20[ ,c("Tekmovanje", "Odigrane tekme", "Zmage", "Remiji", "Porazi", "Gol razlika")]
  Tabela_pregled19_20[, c(2,3,4,5)] <- sapply(Tabela_pregled19_20[, c(2,3,4,5)], as.numeric) #class numeric za ?tevilo odigranih tekem
  return(Tabela_pregled19_20)
}
rezultati1920 <- uvoz1920r() #pregled sezone 2019/20

uvoz1819r <- function(Tabela_pregled18_19) {
  link <- "https://en.wikipedia.org/wiki/2018%E2%80%9319_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_pregled18_19 <- stran %>% html_nodes(xpath = "//table[@class='wikitable']") %>%
    .[[3]] %>% html_table(dec=".",fill = TRUE)
  Tabela_pregled18_19 <- Tabela_pregled18_19[-c(1),] #enak format kot za pretekle sezone
  names(Tabela_pregled18_19) <- c("Tekmovanje", "Odigrane tekme", "Zmage", "Remiji", "Porazi", "Dani goli", "Prejeti goli", "Gol razlika", "Procent zmag")
  Tabela_pregled18_19 <- Tabela_pregled18_19[ ,c("Tekmovanje", "Odigrane tekme", "Zmage", "Remiji", "Porazi", "Gol razlika")]
  Tabela_pregled18_19[, c(2,3,4,5)] <- sapply(Tabela_pregled18_19[, c(2,3,4,5)], as.numeric) #class numeric za ?tevilo odigranih tekem
  return(Tabela_pregled18_19)
} 
rezultati1819 <- uvoz1819r() #pregled sezone 2018/19

uvoz1718r <- function(Tabela_pregled17_18) {
  link <- "https://en.wikipedia.org/wiki/2017%E2%80%9318_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_pregled17_18 <- stran %>% html_nodes(xpath = "//table[@class='wikitable']") %>%
    .[[3]] %>% html_table(dec=".",fill = TRUE)
  Tabela_pregled17_18 <- Tabela_pregled17_18[-c(1),] #enak format kot za pretekle sezone
  names(Tabela_pregled17_18) <- c("Tekmovanje", "Odigrane tekme", "Zmage", "Remiji", "Porazi", "Dani goli", "Prejeti goli", "Gol razlika", "Procent zmag")
  Tabela_pregled17_18 <- Tabela_pregled17_18[ ,c("Tekmovanje", "Odigrane tekme", "Zmage", "Remiji", "Porazi", "Gol razlika")]
  Tabela_pregled17_18[, c(2,3,4,5)] <- sapply(Tabela_pregled17_18[, c(2,3,4,5)], as.numeric) #class numeric za ?tevilo odigranih tekem
  return(Tabela_pregled17_18)
}
rezultati1718 <- uvoz1718r() #pregled sezone 2017/18

uvoz1617r <- function(Tabela_pregled16_17) {
  link <- "https://en.wikipedia.org/wiki/2016%E2%80%9317_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_pregled16_17 <- stran %>% html_nodes(xpath = "//table[@class='wikitable']") %>%
    .[[3]] %>% html_table(dec=".",fill = TRUE)
  Tabela_pregled16_17 <- Tabela_pregled16_17[-c(1),] #enak format kot za pretekle sezone
  names(Tabela_pregled16_17) <- c("Tekmovanje", "Odigrane tekme", "Zmage", "Remiji", "Porazi", "Dani goli", "Prejeti goli", "Gol razlika", "Procent zmag")
  Tabela_pregled16_17 <- Tabela_pregled16_17[ ,c("Tekmovanje", "Odigrane tekme", "Zmage", "Remiji", "Porazi", "Gol razlika")]
  Tabela_pregled16_17[, c(2,3,4,5)] <- sapply(Tabela_pregled16_17[, c(2,3,4,5)], as.numeric) #class numeric za ?tevilo odigranih tekem
  return(Tabela_pregled16_17)
}
rezultati1617 <- uvoz1617r() #pregled sezone 2016/17

## 3) TABELA NASTOPOV

uvoz1920n <- function(Tabela_nastopi19_20) {
  link <- "https://en.wikipedia.org/wiki/2019%E2%80%9320_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_nastopi19_20 <- stran %>% html_nodes(xpath = "//table[@class='wikitable sortable']") %>%
    .[[4]] %>% html_table(dec=".",fill = TRUE)
  names(Tabela_nastopi19_20) <- c("Stevilka dresa", "Igralno mesto", "Narodnost", "Ime", "PL - vse tekme", "PL - prva postava", "FA pokal - vse tekme", "FA pokal - prva postava", "EFL pokal - vse tekme", "EFL pokal - prva postava",
                                  "Liga prvakov - vse tekme", "Liga prvakov - prva postava", "Drugo - vse tekme", "Drugo - prva postava", "Skupaj vse tekme", "Skupaj prva postava")
  Tabela_nastopi19_20 <- Tabela_nastopi19_20[-c(1),]
  Tabela_nastopi19_20 <- Tabela_nastopi19_20[,c("Igralno mesto", "Ime", "PL - vse tekme", "PL - prva postava", "FA pokal - vse tekme", "FA pokal - prva postava", "EFL pokal - vse tekme", "EFL pokal - prva postava",
                                                "Liga prvakov - vse tekme", "Liga prvakov - prva postava", "Drugo - vse tekme", "Drugo - prva postava", "Skupaj vse tekme", "Skupaj prva postava")]
  Tabela_nastopi19_20[, c(3:14)] <- sapply(Tabela_nastopi19_20[, c(3:14)], as.numeric) #class numeric
  Tabela_nastopi19_20 <- Tabela_nastopi19_20[(Tabela_nastopi19_20$"Igralno mesto"=="GK" | Tabela_nastopi19_20$"Igralno mesto"=="DF" | Tabela_nastopi19_20$"Igralno mesto"=="MF" | Tabela_nastopi19_20$"Igralno mesto"=="FW"),]
  return(Tabela_nastopi19_20)
}
nastopi1920 <- uvoz1920n()



## 4) DISCIPLINARY RECORD

uvoz.4 <- function(Tabela_kartoni20_21) {
  link <- "https://en.wikipedia.org/wiki/2020%E2%80%9321_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_kartoni20_21 <- stran %>% html_nodes(xpath = "//table[@class='wikitable sortable']") %>%
    .[[8]] %>% html_table(dec=".",fill = TRUE)
  Tabela_kartoni20_21 <- na.omit(Tabela_kartoni20_21)   #izbriÅ¡emo vrstice, ki imajo vrednost NA
  #Tabela_igralci20_21 <- Tabela_igralci20_21[ ,c("Player", "Date of birth", "Signed from")]
  #names(Tabela_igralci20_21) <- c("Igralec", "Datum rojstva", "Izvor")
  #Tabela_igralci20_21<-Tabela_igralci20_21[!(Tabela_igralci20_21$Igralec=="Goalkeepers" | Tabela_igralci20_21$Igralec=="Defenders" | Tabela_igralci20_21$Igralec=="Midfielders" | Tabela_igralci20_21$Igralec=="Forwards"),]
  #Tabela_starost[, c(2)] <- sapply(Tabela_starost[, c(2)], as.numeric) #popravimo, da ima 2. stolpec class numeric
  return(Tabela_kartoni20_21)
}

tabela4 <- uvoz.4()

## 5) UVRSTITVE PO SEZONAH

uvozsezone <- function(tabela_uvrstitev) {
  link <- "https://www.anfield-online.co.uk/stats/alltimeleaguepositions.htm"
  stran <- html_session(link) %>% read_html()
  tabela_uvrstitev <- stran %>% html_nodes(xpath = "//table[@class='myregulartable']") %>%
    .[[1]] %>% html_table(dec=".",fill = TRUE)
  tabela_uvrstitev <- tabela_uvrstitev[ ,c("Season", "Division", "Pts", "Pos")]
  tabela_uvrstitev <- tabela_uvrstitev[!(tabela_uvrstitev$Division!="PR"),] #opazujem le Premier ligo
  tabela_uvrstitev <- tabela_uvrstitev[,c("Season", "Pts", "Pos")]
  names(tabela_uvrstitev) <- c("Sezona", "Tocke", "Uvrstitev")
  return(tabela_uvrstitev)
}
zgodovina_uvrstitev <- uvozsezone() #tocke in uvrstitve so ze numeric


uvozFPL1617 <- read_csv("../podatki/players_raw1617.csv",TRUE, locale=locale(encoding="UTF-8"))
uvozFPL1617 <- uvozFPL1617 %>% select("team", "red_cards", "yellow_cards")



