# 2. faza: Uvoz podatkov

#klic knjiznic
source("lib/libraries.r", encoding="UTF-8")

## 1) TABELE IGRALCEV  - imena, narodnost, datumi rojstev, izvor

uvoz2021i <- function() {
  link <- "https://en.wikipedia.org/wiki/2020%E2%80%9321_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_igralci20_21 <- stran %>% html_nodes(xpath = "//table[@class='wikitable']") %>%
    .[[1]] %>% html_table(dec=".",fill = TRUE)
  Tabela_igralci20_21 <- Tabela_igralci20_21[ ,c("Player", "Nationality","Date of birth", "Signed from")]
  names(Tabela_igralci20_21) <- c("Igralec", "Narodnost", "Starost", "Izvor")
  Tabela_igralci20_21<-Tabela_igralci20_21[!(Tabela_igralci20_21$Igralec=="Goalkeepers" | Tabela_igralci20_21$Igralec=="Defenders" | Tabela_igralci20_21$Igralec=="Midfielders" | Tabela_igralci20_21$Igralec=="Forwards"),]
  vektor_drzava <- stran %>% html_nodes(xpath = "//table[@class='wikitable']") %>%.[[1]]%>% html_nodes(xpath=".//span[@class='flagicon']")%>%html_nodes('a')%>% html_attr(., "title")
  vektor_drzava <- vektor_drzava[c(seq(1,length(vektor_drzava),2))]
  Tabela_igralci20_21$Narodnost <- vektor_drzava
  return(Tabela_igralci20_21)
}
igralci2021 <- uvoz2021i() # tabela igralcev, sezona 2020/21
igralci2021 <- igralci2021 %>%
  mutate('Starost' = gsub("\\(..........\\).[0-9]+.[A-Z][a-z]+.[0-9]+.\\([a-z]+.", "", Starost)) %>%
  mutate('Starost' = gsub("\\)", "", Starost))
igralci2021$Starost <- as.numeric(igralci2021$Starost)

#za potrebe povprecnih starosti, ker niso vedno vsi igralci
nv2021 <- c(Igralec = "Takumi Minamino", Narodnost = "Japan", Starost = 26, Izvor = "Red Bull Salzburg")
igralci2021 <- rbind(igralci2021,nv2021) 

uvoz1920i <- function() {
  link <- "https://en.wikipedia.org/wiki/2019%E2%80%9320_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_igralci19_20 <- stran %>% html_nodes(xpath = "//table[@class='wikitable']") %>%
    .[[1]] %>% html_table(dec=".",fill = TRUE)
  Tabela_igralci19_20 <- Tabela_igralci19_20[ ,c("Name", "Nationality","Date of birth", "Signed from")]
  names(Tabela_igralci19_20) <- c("Igralec", "Narodnost", "Starost", "Izvor")
  Tabela_igralci19_20<-Tabela_igralci19_20[!(Tabela_igralci19_20$Igralec=="Goalkeepers" | Tabela_igralci19_20$Igralec=="Defenders" | Tabela_igralci19_20$Igralec=="Midfielders" | Tabela_igralci19_20$Igralec=="Forwards"),]
  vektor_drzava <- stran %>% html_nodes(xpath = "//table[@class='wikitable']") %>%.[[1]]%>% html_nodes(xpath=".//span[@class='flagicon']")%>%html_nodes('a')%>% html_attr(., "title")
  vektor_drzava <- vektor_drzava[c(seq(1,length(vektor_drzava),2))]
  Tabela_igralci19_20$Narodnost <- vektor_drzava
  return(Tabela_igralci19_20)
}
igralci1920 <- uvoz1920i() # tabela igralcev, sezona 2019/20
igralci1920 <- igralci1920 %>%
  mutate('Starost' = gsub("\\(..........\\).?[0-9]+.[A-Z][a-z]+.[0-9]+.\\([a-z]+.", "", Starost)) %>%
  mutate('Starost' = gsub("\\)", "", Starost))
igralci1920$Starost <- as.numeric(igralci1920$Starost)

uvoz1819i <- function() {
  link <- "https://en.wikipedia.org/wiki/2018%E2%80%9319_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_igralci18_19 <- stran %>% html_nodes(xpath = "//table[@class='wikitable']") %>%
    .[[1]] %>% html_table(dec=".",fill = TRUE)
  Tabela_igralci18_19 <- Tabela_igralci18_19[ ,c("Name", "Nationality", "Date of Birth", "Signed From")]
  names(Tabela_igralci18_19) <- c("Igralec", "Narodnost", "Starost", "Izvor")
  Tabela_igralci18_19<-Tabela_igralci18_19[!(Tabela_igralci18_19$Igralec=="Goalkeepers" | Tabela_igralci18_19$Igralec=="Defenders" | Tabela_igralci18_19$Igralec=="Midfielders" | Tabela_igralci18_19$Igralec=="Forwards"),]
  vektor_drzava <- stran %>% html_nodes(xpath = "//table[@class='wikitable']") %>%.[[1]]%>% html_nodes(xpath=".//span[@class='flagicon']")%>%html_nodes('a')%>% html_attr(., "title")
  vektor_drzava <- vektor_drzava[c(seq(1,length(vektor_drzava),2))]
  Tabela_igralci18_19$Narodnost <- vektor_drzava
  return(Tabela_igralci18_19)
}
igralci1819 <- uvoz1819i() # tabela igralcev, sezona 2018/19
igralci1819 <- igralci1819 %>%
  mutate('Starost' = gsub("\\(..........\\).?[0-9]+.[A-Z][a-z]+.[0-9]+.\\([a-z]+.", "", Starost)) %>%
  mutate('Starost' = gsub("\\)", "", Starost))
igralci1819$Starost <- as.numeric(igralci1819$Starost)
#rocni popravki
igralci1819$Igralec[1] = "Alisson"

uvoz1718i <- function() {
  link <- "https://en.wikipedia.org/wiki/2017%E2%80%9318_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_igralci17_18 <- stran %>% html_nodes(xpath = "//table[@class='wikitable']") %>%
    .[[1]] %>% html_table(dec=".",fill = TRUE)
  Tabela_igralci17_18 <- Tabela_igralci17_18[ ,c("Name", "Nationality","Date of birth", "Signed from")]
  names(Tabela_igralci17_18) <- c("Igralec", "Narodnost", "Starost", "Izvor")
  Tabela_igralci17_18<-Tabela_igralci17_18[!(Tabela_igralci17_18$Igralec=="Goalkeepers" | Tabela_igralci17_18$Igralec=="Defenders" | Tabela_igralci17_18$Igralec=="Midfielders" | Tabela_igralci17_18$Igralec=="Forwards"),]
  vektor_drzava <- stran %>% html_nodes(xpath = "//table[@class='wikitable']") %>%.[[1]]%>% html_nodes(xpath=".//span[@class='flagicon']")%>%html_nodes('a')%>% html_attr(., "title")
  vektor_drzava <- vektor_drzava[c(seq(1,length(vektor_drzava),2))]
  Tabela_igralci17_18$Narodnost <- vektor_drzava
  return(Tabela_igralci17_18)
}
igralci1718 <- uvoz1718i() # tabela igralcev, sezona 2017/18
igralci1718 <- igralci1718 %>%
  mutate('Starost' = gsub("\\(..........\\).?[0-9]+.[A-Z][a-z]+.[0-9]+.\\([a-z]+.", "", Starost)) %>%
  mutate('Starost' = gsub("\\)", "", Starost))
igralci1718$Starost <- as.numeric(igralci1718$Starost)

#za potrebe povprecnih starosti, ker niso vedno vsi igralci
nv1718 <- c(Igralec = "Daniel Sturridge", Narodnost = "United Kingdom", Starost = 28, Izvor = "Chelsea")
igralci1718 <- rbind(igralci1718,nv1718) 

uvoz1617i <- function() {
  link <- "https://en.wikipedia.org/wiki/2016%E2%80%9317_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_igralci16_17 <- stran %>% html_nodes(xpath = "//table[@class='wikitable']") %>%
    .[[1]] %>% html_table(dec=".",fill = TRUE)
  Tabela_igralci16_17 <- Tabela_igralci16_17[ ,c("Name", "Nationality","Date of Birth", "Signed from")]
  names(Tabela_igralci16_17) <- c("Igralec", "Narodnost", "Starost", "Izvor")
  Tabela_igralci16_17<-Tabela_igralci16_17[!(Tabela_igralci16_17$Igralec=="Goalkeepers" | Tabela_igralci16_17$Igralec=="Defenders" | Tabela_igralci16_17$Igralec=="Midfielders" | Tabela_igralci16_17$Igralec=="Forwards"),]
  vektor_drzava <- stran %>% html_nodes(xpath = "//table[@class='wikitable']") %>%.[[1]]%>% html_nodes(xpath=".//span[@class='flagicon']")%>%html_nodes('a')%>% html_attr(., "title")
  vektor_drzava <- vektor_drzava[c(seq(1,length(vektor_drzava),2))]
  Tabela_igralci16_17$Narodnost <- vektor_drzava
  return(Tabela_igralci16_17)
}
igralci1617 <- uvoz1617i() # tabela igralcev, sezona 2016/17
igralci1617 <- igralci1617 %>%
  mutate('Starost' = gsub("\\(..........\\).?[0-9]+.[A-Z][a-z]+.[0-9]+.\\([a-z]+.", "", Starost)) %>%
  mutate('Starost' = gsub("\\)", "", Starost))
igralci1617$Starost <- as.numeric(igralci1617$Starost)

## 2) TABELA UVRSTITEV PO TEKMOVANJIH - tekmovanja, koncna uvrstitev, odigrane tekme, zmage, remiji, porazi

uvoz2021r <- function() {
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

uvoz1920r <- function() {
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

uvoz1819r <- function() {
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

uvoz1718r <- function() {
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

uvoz1617r <- function() {
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

uvoz2021n <- function() {
  link <- "https://en.wikipedia.org/wiki/2020%E2%80%9321_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_nastopi20_21 <- stran %>% html_nodes(xpath = "//table[@class='wikitable sortable']") %>%
    .[[5]] %>% html_table(dec=".",fill = TRUE)
  names(Tabela_nastopi20_21) <- c("Stevilka dresa", "Igralno mesto", "Narodnost", "Igralec", "PL - vse tekme", "PL - prva postava", "FA pokal - vse tekme", "FA pokal - prva postava", "EFL pokal - vse tekme", "EFL pokal - prva postava",
                                  "Liga prvakov - vse tekme", "Liga prvakov - prva postava", "Drugo - vse tekme", "Drugo - prva postava", "Skupaj vse tekme", "Skupaj prva postava")
  Tabela_nastopi20_21 <- Tabela_nastopi20_21[-c(1),]
  Tabela_nastopi20_21 <- Tabela_nastopi20_21[,c("Igralno mesto", "Igralec", "PL - vse tekme", "PL - prva postava", "FA pokal - vse tekme", "FA pokal - prva postava", "EFL pokal - vse tekme", "EFL pokal - prva postava",
                                                "Liga prvakov - vse tekme", "Liga prvakov - prva postava", "Drugo - vse tekme", "Drugo - prva postava", "Skupaj vse tekme", "Skupaj prva postava")]
  Tabela_nastopi20_21[, c(3:14)] <- sapply(Tabela_nastopi20_21[, c(3:14)], as.numeric) #class numeric
  Tabela_nastopi20_21 <- Tabela_nastopi20_21[(Tabela_nastopi20_21$"Igralno mesto"=="GK" | Tabela_nastopi20_21$"Igralno mesto"=="DF" | Tabela_nastopi20_21$"Igralno mesto"=="MF" | Tabela_nastopi20_21$"Igralno mesto"=="FW"),]
  return(Tabela_nastopi20_21)
}
nastopi2021 <- uvoz2021n()

uvoz1920n <- function() {
  link <- "https://en.wikipedia.org/wiki/2019%E2%80%9320_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_nastopi19_20 <- stran %>% html_nodes(xpath = "//table[@class='wikitable sortable']") %>%
    .[[4]] %>% html_table(dec=".",fill = TRUE)
  names(Tabela_nastopi19_20) <- c("Stevilka dresa", "Igralno mesto", "Narodnost", "Igralec", "PL - vse tekme", "PL - prva postava", "FA pokal - vse tekme", "FA pokal - prva postava", "EFL pokal - vse tekme", "EFL pokal - prva postava",
                                  "Liga prvakov - vse tekme", "Liga prvakov - prva postava", "Drugo - vse tekme", "Drugo - prva postava", "Skupaj vse tekme", "Skupaj prva postava")
  Tabela_nastopi19_20 <- Tabela_nastopi19_20[-c(1),]
  Tabela_nastopi19_20 <- Tabela_nastopi19_20[,c("Igralno mesto", "Igralec", "PL - vse tekme", "PL - prva postava", "FA pokal - vse tekme", "FA pokal - prva postava", "EFL pokal - vse tekme", "EFL pokal - prva postava",
                                                "Liga prvakov - vse tekme", "Liga prvakov - prva postava", "Drugo - vse tekme", "Drugo - prva postava", "Skupaj vse tekme", "Skupaj prva postava")]
  Tabela_nastopi19_20[, c(3:14)] <- sapply(Tabela_nastopi19_20[, c(3:14)], as.numeric) #class numeric
  Tabela_nastopi19_20 <- Tabela_nastopi19_20[(Tabela_nastopi19_20$"Igralno mesto"=="GK" | Tabela_nastopi19_20$"Igralno mesto"=="DF" | Tabela_nastopi19_20$"Igralno mesto"=="MF" | Tabela_nastopi19_20$"Igralno mesto"=="FW"),]
  return(Tabela_nastopi19_20)
}
nastopi1920 <- uvoz1920n()

uvoz1819n <- function() {
  link <- "https://en.wikipedia.org/wiki/2018%E2%80%9319_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_nastopi18_19 <- stran %>% html_nodes(xpath = "//table[@class='wikitable sortable']") %>%
    .[[4]] %>% html_table(dec=".",fill = TRUE)
  names(Tabela_nastopi18_19) <- c("Stevilka dresa", "Igralno mesto", "Narodnost", "Igralec", "PL - vse tekme", "PL - prva postava", "FA pokal - vse tekme", "FA pokal - prva postava", "EFL pokal - vse tekme", "EFL pokal - prva postava",
                                  "Liga prvakov - vse tekme", "Liga prvakov - prva postava", "Skupaj vse tekme", "Skupaj prva postava")
  Tabela_nastopi18_19 <- Tabela_nastopi18_19[-c(1),]
  Tabela_nastopi18_19 <- Tabela_nastopi18_19[,c("Igralno mesto", "Igralec", "PL - vse tekme", "PL - prva postava", "FA pokal - vse tekme", "FA pokal - prva postava", "EFL pokal - vse tekme", "EFL pokal - prva postava",
                                                "Liga prvakov - vse tekme", "Liga prvakov - prva postava", "Skupaj vse tekme", "Skupaj prva postava")]
  Tabela_nastopi18_19[, c(3:12)] <- sapply(Tabela_nastopi18_19[, c(3:12)], as.numeric) #class numeric
  Tabela_nastopi18_19 <- Tabela_nastopi18_19[(Tabela_nastopi18_19$"Igralno mesto"=="GK" | Tabela_nastopi18_19$"Igralno mesto"=="DF" | Tabela_nastopi18_19$"Igralno mesto"=="MF" | Tabela_nastopi18_19$"Igralno mesto"=="FW"),]
  return(Tabela_nastopi18_19)
}
nastopi1819 <- uvoz1819n()

uvoz1718n <- function() {
  link <- "https://en.wikipedia.org/wiki/2017%E2%80%9318_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_nastopi17_18 <- stran %>% html_nodes(xpath = "//table[@class='wikitable sortable']") %>%
    .[[4]] %>% html_table(dec=".",fill = TRUE)
  names(Tabela_nastopi17_18) <- c("Stevilka dresa", "Igralno mesto", "Narodnost", "Igralec", "PL - vse tekme", "PL - prva postava", "FA pokal - vse tekme", "FA pokal - prva postava", "EFL pokal - vse tekme", "EFL pokal - prva postava",
                                  "Liga prvakov - vse tekme", "Liga prvakov - prva postava", "Skupaj vse tekme", "Skupaj prva postava")
  Tabela_nastopi17_18 <- Tabela_nastopi17_18[-c(1),]
  Tabela_nastopi17_18 <- Tabela_nastopi17_18[,c("Igralno mesto", "Igralec", "PL - vse tekme", "PL - prva postava", "FA pokal - vse tekme", "FA pokal - prva postava", "EFL pokal - vse tekme", "EFL pokal - prva postava",
                                                "Liga prvakov - vse tekme", "Liga prvakov - prva postava", "Skupaj vse tekme", "Skupaj prva postava")]
  Tabela_nastopi17_18[, c(3:12)] <- sapply(Tabela_nastopi17_18[, c(3:12)], as.numeric) #class numeric
  Tabela_nastopi17_18 <- Tabela_nastopi17_18[(Tabela_nastopi17_18$"Igralno mesto"=="GK" | Tabela_nastopi17_18$"Igralno mesto"=="DF" | Tabela_nastopi17_18$"Igralno mesto"=="MF" | Tabela_nastopi17_18$"Igralno mesto"=="FW"),]
  return(Tabela_nastopi17_18)
}
nastopi1718 <- uvoz1718n()

uvoz1617n <- function() {
  link <- "https://en.wikipedia.org/wiki/2016%E2%80%9317_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_nastopi16_17 <- stran %>% html_nodes(xpath = "//table[@class='wikitable sortable']") %>%
    .[[4]] %>% html_table(dec=".",fill = TRUE)
  names(Tabela_nastopi16_17) <- c("Stevilka dresa", "Igralno mesto", "Narodnost", "Igralec", "PL","FA","EFL", "Total")
  Tabela_nastopi16_17 <- Tabela_nastopi16_17[-c(1),]
  Tabela_nastopi16_17 <- Tabela_nastopi16_17[,c("Igralno mesto", "Igralec", "PL","FA","EFL", "Total")]
  return(Tabela_nastopi16_17)
}
nastopi1617 <- uvoz1617n()

nastopi1617 <- nastopi1617 %>% 
  mutate('PL - prva postava' = gsub("\\([^()]*\\)", "", PL)) %>% #izbris oklepajev - v () na ""
  mutate('FA pokal - prva postava' = gsub("\\([^()]*\\)", "", FA)) %>% #izbris oklepajev
  mutate('EFL pokal - prva postava' = gsub("\\([^()]*\\)", "", EFL)) %>% #izbris oklepajev
  mutate('Skupaj prva postava' = gsub("\\([^()]*\\)", "", Total))# %>% #izbris oklepajev
nastopi1617[, c(7:10)] <- sapply(nastopi1617[, c(7:10)], as.numeric) #nastavimo numeric class

#POMOZNA kontrolira, ce niz vsebuje oklepaj oz. zaklepaj
pomozna <- function(niz){
  if (grepl("\\(", niz)){
  }
  else {
    niz = 0
  }
  return(niz)
}

# Liga
nastopi1617$PLtmp <- sapply(nastopi1617$PL, pomozna)
nastopi1617 <- nastopi1617 %>%
  mutate('PLtmp' = gsub("^[^()]*\\(", "", PLtmp))
nastopi1617 <- nastopi1617 %>%
  mutate('PLtmp' = gsub("\\)", "", PLtmp))
stevilskiPL <- as.numeric(nastopi1617$PLtmp)
nastopi1617$'PL - vse tekme' <- stevilskiPL + nastopi1617$'PL - prva postava'

# FA pokal
nastopi1617$FAtmp <- sapply(nastopi1617$FA, pomozna)
nastopi1617 <- nastopi1617 %>%
  mutate('FAtmp' = gsub("^[^()]*\\(", "", FAtmp))
nastopi1617 <- nastopi1617 %>%
  mutate('FAtmp' = gsub("\\)", "", FAtmp))
stevilskiFA <- as.numeric(nastopi1617$FAtmp)
nastopi1617$'FA pokal - vse tekme' <- stevilskiFA + nastopi1617$'FA pokal - prva postava'

# EFL pokal
nastopi1617$EFLtmp <- sapply(nastopi1617$EFL, pomozna)
nastopi1617 <- nastopi1617 %>%
  mutate('EFLtmp' = gsub("^[^()]*\\(", "", EFLtmp))
nastopi1617 <- nastopi1617 %>%
  mutate('EFLtmp' = gsub("\\)", "", EFLtmp))
stevilskiEFL <- as.numeric(nastopi1617$EFLtmp)
nastopi1617$'EFL pokal - vse tekme' <- stevilskiEFL + nastopi1617$'EFL pokal - prva postava'

# 2016 Skupaj
nastopi1617$Skupajtmp <- sapply(nastopi1617$Total, pomozna)
nastopi1617 <- nastopi1617 %>%
  mutate('Skupajtmp' = gsub("^[^()]*\\(", "", Skupajtmp))
nastopi1617 <- nastopi1617 %>%
  mutate('Skupajtmp' = gsub("\\)", "", Skupajtmp))
stevilskiSkupaj <- as.numeric(nastopi1617$Skupajtmp)
nastopi1617$'Skupaj vse tekme' <- stevilskiSkupaj + nastopi1617$'Skupaj prva postava'

#izbris odvecnih
nastopi1617 <- nastopi1617[,c("Igralno mesto", "Igralec", "PL - prva postava", "FA pokal - prva postava",
                              "EFL pokal - prva postava", "Skupaj prva postava", "PL - vse tekme",
                              "FA pokal - vse tekme", "EFL pokal - vse tekme", "Skupaj vse tekme")]

## 4) PREGLED KARTONOV v PL- LIVERPOOL

uvoz2021k <- function() {
  link <- "https://en.wikipedia.org/wiki/2020%E2%80%9321_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_kartoni20_21 <- stran %>% html_nodes(xpath = "//table[@class='wikitable sortable']") %>%
    .[[8]] %>% html_table(dec=".",fill = TRUE)
  Tabela_kartoni20_21 <- na.omit(Tabela_kartoni20_21)   #izbrisemo vrstice, ki imajo vrednost NA
  names(Tabela_kartoni20_21)[4] <- "Rumeni" #preimenovanje stolpcev glede na indeks
  names(Tabela_kartoni20_21)[5] <- "Rdeci"
  Tabela_kartoni20_21 <- Tabela_kartoni20_21[,c("Name","Rumeni","Rdeci")]
  names(Tabela_kartoni20_21)[names(Tabela_kartoni20_21) == "Name"] <- "Ime" #preimenovanje glede na ime
  return(Tabela_kartoni20_21)
}
kartoni2021 <- uvoz2021k() #kartoni EPL 2020-21

uvoz1920k <- function() {
  link <- "https://en.wikipedia.org/wiki/2019%E2%80%9320_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_kartoni19_20 <- stran %>% html_nodes(xpath = "//table[@class='wikitable sortable']") %>%
    .[[7]] %>% html_table(dec=".",fill = TRUE)
  Tabela_kartoni19_20 <- na.omit(Tabela_kartoni19_20)   #izbrisemo vrstice, ki imajo vrednost NA
  names(Tabela_kartoni19_20)[4] <- "Rumeni" #preimenovanje stolpcev glede na indeks
  names(Tabela_kartoni19_20)[5] <- "Rdeci"
  Tabela_kartoni19_20 <- Tabela_kartoni19_20[,c("Name","Rumeni","Rdeci")]
  names(Tabela_kartoni19_20)[names(Tabela_kartoni19_20) == "Name"] <- "Ime" #preimenovanje glede na ime
  return(Tabela_kartoni19_20)
}
kartoni1920 <- uvoz1920k() #kartoni EPL 2019-20

#SELE V SEZONI 2019-20 SO BILI UVEDENI TUDI KARTONI ZA TRENERJE - od tu naprej v tabelah ni Kloppa
uvoz1819k <- function() {
  link <- "https://en.wikipedia.org/wiki/2018%E2%80%9319_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_kartoni18_19 <- stran %>% html_nodes(xpath = "//table[@class='wikitable sortable']") %>%
    .[[7]] %>% html_table(dec=".",fill = TRUE)
  Tabela_kartoni18_19 <- na.omit(Tabela_kartoni18_19)   #izbrisemo vrstice, ki imajo vrednost NA
  names(Tabela_kartoni18_19)[4] <- "Rumeni" #preimenovanje stolpcev glede na indeks
  names(Tabela_kartoni18_19)[5] <- "Rdeci"
  Tabela_kartoni18_19 <- Tabela_kartoni18_19[,c("Name","Rumeni","Rdeci")]
  names(Tabela_kartoni18_19)[names(Tabela_kartoni18_19) == "Name"] <- "Ime" #preimenovanje glede na ime
  return(Tabela_kartoni18_19)
}
kartoni1819 <- uvoz1819k() #kartoni EPL 2018-19

uvoz1718k <- function() {
  link <- "https://en.wikipedia.org/wiki/2017%E2%80%9318_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_kartoni17_18 <- stran %>% html_nodes(xpath = "//table[@class='wikitable sortable']") %>%
    .[[5]] %>% html_table(dec=".",fill = TRUE)
  Tabela_kartoni17_18 <- na.omit(Tabela_kartoni17_18)   #izbrisemo vrstice, ki imajo vrednost NA
  names(Tabela_kartoni17_18)[4] <- "Rumeni" #preimenovanje stolpcev glede na indeks
  names(Tabela_kartoni17_18)[5] <- "Rdeci"
  Tabela_kartoni17_18 <- Tabela_kartoni17_18[,c("Name","Rumeni","Rdeci")]
  names(Tabela_kartoni17_18)[names(Tabela_kartoni17_18) == "Name"] <- "Ime" #preimenovanje glede na ime
  return(Tabela_kartoni17_18)
}
kartoni1718 <- uvoz1718k() #kartoni EPL 2018-19

uvoz1617k <- function() {
  link <- "https://en.wikipedia.org/wiki/2016%E2%80%9317_Liverpool_F.C._season"
  stran <- html_session(link) %>% read_html()
  Tabela_kartoni16_17 <- stran %>% html_nodes(xpath = "//table[@class='wikitable sortable']") %>%
    .[[5]] %>% html_table(dec=".",fill = TRUE)
  Tabela_kartoni16_17 <- na.omit(Tabela_kartoni16_17)   #izbrisemo vrstice, ki imajo vrednost NA
  names(Tabela_kartoni16_17)[4] <- "Rumeni" #preimenovanje stolpcev glede na indeks
  names(Tabela_kartoni16_17)[5] <- "Rdeci"
  Tabela_kartoni16_17 <- Tabela_kartoni16_17[,c("Name","Rumeni","Rdeci")]
  names(Tabela_kartoni16_17)[names(Tabela_kartoni16_17) == "Name"] <- "Ime" #preimenovanje glede na ime
  return(Tabela_kartoni16_17)
}
kartoni1617 <- uvoz1617k() #kartoni EPL 2016-17


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

## 6) KARTONI ZA VSO LIGO SKUPAJ (po sezonah)
liga_kartoni1617 <- read_csv("podatki/players_raw1617.csv",TRUE, locale=locale(encoding="UTF-8"))
liga_kartoni1617 <- liga_kartoni1617 %>% select("team", "red_cards", "yellow_cards")

liga_kartoni1718 <- read_csv("podatki/players_raw1718.csv",TRUE, locale=locale(encoding="UTF-8"))
liga_kartoni1718 <- liga_kartoni1718 %>% select("team", "red_cards", "yellow_cards")

liga_kartoni1819 <- read_csv("podatki/players_raw1819.csv",TRUE, locale=locale(encoding="UTF-8"))
liga_kartoni1819 <- liga_kartoni1819 %>% select("team", "red_cards", "yellow_cards")

liga_kartoni1920 <- read_csv("podatki/players_raw1920.csv",TRUE, locale=locale(encoding="UTF-8"))
liga_kartoni1920 <- liga_kartoni1920 %>% select("team", "red_cards", "yellow_cards")

liga_kartoni2021 <- read_csv("podatki/players_raw2021.csv",TRUE, locale=locale(encoding="UTF-8"))
liga_kartoni2021 <- liga_kartoni2021 %>% select("team", "red_cards", "yellow_cards")
#Iz neznanega razloga ima 3. West Hamov vratar, ki je prestopil ze avgusta v Valladolid, 
#same vrednosti NA, zato jih odstranimo kar rocno.
liga_kartoni2021 <- na.omit(liga_kartoni2021) 


