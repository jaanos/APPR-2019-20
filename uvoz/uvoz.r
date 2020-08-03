# 2. faza: Uvoz podatkov

sl <- locale("sl", decimal_mark=",", grouping_mark=".")

# Pomozne funkcije za ciscenje

# Popravek stolpca 'Populacija'
# Spremenimo iz 11,11 v 1111
spremeniDecimalke <- function(stevilo){
  M <- unlist(strsplit(stevilo, ""))
  M <- M[!grepl("\\,", M)]
  return(as.numeric(paste(M, collapse = "")))
}

# Popravek stolpca 'Povrsina' in 'GDP'
# spremenimo iz 12.34 v 1234
spremeniZapis <- function(stevilo) {
  M <- unlist(strsplit(as.character(stevilo), ""))
  M <- M[!grepl("\\.", M)]
  return(as.numeric(paste(M, collapse = "")))
}

# Prvemu in tretjemu stolpcu zbrisemo nemški prevod
# Bavaria(Bayern) => Bavaria
spremeniPrevod <- function(beseda) {
  M <- unlist(strsplit(beseda, ""))
  i <- grepl("\\(", M)
  if (sum(i) == 0) {
    return(beseda)
  } else {
    i <- grep("\\(", M)
    M <- M[1:(i - 1)]
    novaBeseda <- paste(M, collapse = "")
    return(novaBeseda)
  }
}

###

# Tabela 1
# Uvoz regij Nemčije iz Wikipedije

uvozi.tabela1 <- function() {
  link <- "https://en.wikipedia.org/wiki/States_of_Germany"
  stran <- html_session(link) %>% read_html()
  tabela1 <- stran %>% html_nodes(xpath="//table[@class='sortable wikitable']") %>%
    .[[1]] %>% html_table(dec=",")
  
  tabela1 <- tabela1[, c(3, 4, 5, 10, 11, 15)]
  imenaStolpcev <- c("Regija", "Leto", "Glavno mesto", "Povrsina", "Populacija", "GDP na prebivalca")
  colnames(tabela1) <- imenaStolpcev
  
  tabela1$Leto[c(1, 3)] <- c(1952, 1990)
  tabela1$Leto <- as.numeric(tabela1$Leto)
  tabela1$`Glavno mesto`[c(3, 6)] <- c("Berlin", "Hamburg")

  populacija <- lapply(tabela1$Populacija, spremeniDecimalke)
  tabela1$Populacija <- unlist(populacija)

  povrsina <- lapply(tabela1$Povrsina, spremeniZapis)
  tabela1$Povrsina <- unlist(povrsina)
  gdp <- lapply(tabela1$`GDP na prebivalca`, spremeniZapis)
  tabela1$`GDP na prebivalca` <- unlist(gdp)

  tabela1$Regija <- unlist(lapply(tabela1$Regija, spremeniPrevod))
  tabela1$`Glavno mesto` <- unlist(lapply(tabela1$`Glavno mesto`, spremeniPrevod))

  # Spremenimo se stolpec GDP na prebivalca v stolpec GDP
  tabela1 <- tabela1 %>% mutate(GDP = round((tabela1$`GDP na prebivalca`*tabela1$Populacija)/10^6, 2))
  tabela1$`GDP na prebivalca` <- NULL
  return(tabela1)
}
#tabela1 <- apply(tabela1, 2, as.character)
#write.csv(tabela1, "podatki/tabela1.csv")
#sapply(tabela1, class)
#tabela1 %>% View

tabela1 <- uvozi.tabela1()


# Pomozne funkcije za ciscenje in uvoz tabele 2

# Prevodi vrednosti
prevediSpol <- function(beseda) {
  if (beseda == 'male') {
    return("moški")
  } else {
    return("ženska")
  }
}
prevediNastanitev <- function(beseda) {
  if (beseda == "own") {
    return("lastno")
  } else if (beseda == "rent") {
    return("najem")
  } else {
    return("drugo")
  }
}
prevediPrihranki <- function(beseda) {
  if (is.na(beseda)) {
    return(NA)
  } else if (beseda == "little") {
    return("malo")
  } else if (beseda == "moderate") {
    return("srednje")
  } else if(beseda == "rich") {
    return("veliko")
  } else if(beseda == "quite rich") {
    return("zelo veliko")
  }
}
prevediOcena <- function(beseda) {
  if (beseda == "good") {
    return("dober")
  } else {
    return("slab")
  }
}

# Tabela 2
# Uvoz kreditinih podatkov iz CSV datoteke

uvozi.tabela2 <- function() {
  creditData <- read.csv("podatki/german_credit_data.csv", encoding = "UTF-8")
  
  # Izbrišemo nepotrebni stolpec "checking account" in preimenovanje stolpcev
  creditData$Checking.account <- NULL
  colnames(creditData) <- c("ID", "Starost", "Spol", "Zaposlitev", "Nastanitev", "Prihranki", "Velikost kredita", "Trajanje", "Namen", "Ocena")
  
  # Pretvorba iz nemških mark v evre
  # 1 DEM = 0.51 €
  creditData$`Velikost kredita` <- unlist(lapply(creditData$`Velikost kredita`, function(x) as.integer(x*0.51)))
  
  seznamNem <- unique(creditData$Namen)
  seznamSlo <- c("radio/TV", "izobrazba", "pohištvo/oprema", "avto", "posel", "gospodinjski aparati", "popravila", "potovanje/drugo")
  for (k in 1:length(seznamNem)) {
    lokacije <- which(creditData$Namen %in% seznamNem[k])
    creditData$Namen[lokacije] <- seznamSlo[k]
  }
  rm(seznamNem, seznamSlo)
  
  creditData$Spol <- unlist(lapply(creditData$Spol, prevediSpol))
  creditData$Nastanitev <- unlist(lapply(creditData$Nastanitev, prevediNastanitev))
  creditData$Prihranki <- unlist(lapply(creditData$Prihranki, prevediPrihranki))
  creditData$Ocena <- unlist(lapply(creditData$Ocena, prevediOcena))
  return(creditData)
}

tabela2 <- uvozi.tabela2()


# Preliminarna analiza

steviloDobrih <- tabela2 %>% group_by(Spol) %>% summarise(Stevilo = count(Ocena))
nMoskih <- tabela2 %>% filter(Spol == "moški") %>% count()
nZenskih <- tabela2 %>% filter(Spol == "ženska") %>% count()
delezM <- round(steviloDobrih$Stevilo[1]/nMoskih, 2)
delezZ <- round(steviloDobrih$Stevilo[2]/nZenskih, 2)

