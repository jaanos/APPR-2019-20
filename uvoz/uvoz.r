# 2. faza: Uvoz podatkov

sl <- locale("sl", decimal_mark=",", grouping_mark=".")

# Funkcija, ki uvozi občine iz Wikipedije
uvozi.obcine <- function() {
  link <- "http://sl.wikipedia.org/wiki/Seznam_ob%C4%8Din_v_Sloveniji"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
    .[[1]] %>% html_table(dec=",")
  for (i in 1:ncol(tabela)) {
    if (is.character(tabela[[i]])) {
      Encoding(tabela[[i]]) <- "UTF-8"
    }
  }
  colnames(tabela) <- c("obcina", "povrsina", "prebivalci", "gostota", "naselja",
                        "ustanovitev", "pokrajina", "regija", "odcepitev")
  tabela$obcina <- gsub("Slovenskih", "Slov.", tabela$obcina)
  tabela$obcina[tabela$obcina == "Kanal ob Soči"] <- "Kanal"
  tabela$obcina[tabela$obcina == "Loški potok"] <- "Loški Potok"
  for (col in c("povrsina", "prebivalci", "gostota", "naselja", "ustanovitev")) {
    if (is.character(tabela[[col]])) {
      tabela[[col]] <- parse_number(tabela[[col]], na="-", locale=sl)
    }
  }
  for (col in c("obcina", "pokrajina", "regija")) {
    tabela[[col]] <- factor(tabela[[col]])
  }
  return(tabela)
}

# Funkcija, ki uvozi podatke iz datoteke druzine.csv
uvozi.druzine <- function(obcine) {
  data <- read_csv2("podatki/druzine.csv", col_names=c("obcina", 1:4),
                    locale=locale(encoding="windows-1250"))
  data$obcina <- data$obcina %>% strapplyc("^([^/]*)") %>% unlist() %>%
    strapplyc("([^ ]+)") %>% sapply(paste, collapse=" ") %>% unlist()
  data$obcina[data$obcina == "Sveti Jurij"] <- "Sveti Jurij ob Ščavnici"
  data <- data %>% gather(`1`:`4`, key="velikost.druzine", value="stevilo.druzin")
  data$velikost.druzine <- parse_number(data$velikost.druzine)
  data$obcina <- parse_factor(data$obcina, levels=obcine)
  return(data)
}

# Zapišimo podatke v razpredelnico obcine
obcine <- uvozi.obcine()

# Zapišimo podatke v razpredelnico druzine.
druzine <- uvozi.druzine(levels(obcine$obcina))


uvoz.place <- function(Tabela_place) {
  Tabela_place <- read_csv2("podatki/earn_nt_net .csv", col_names = TRUE, na=":", locale=locale(encoding="Windows-1250"))
  Tabela_place <- Tabela_place[ -c(31:43), ]
  return(Tabela_place)
}

uvoz.BDP <- function(Tabela_BDP) {
  Tabela_BDP <- read_xlsx("podatki/BDP_pc.xlsx", na="-")
  Tabela_BDP <- Tabela_BDP[ -c(31:35), ]
  return(Tabela_BDP)
}

uvoz.davki <- function(Tabela_davki) {
  Tabela_davki <- read_xls("podatki/earn_nt_taxrate.xls", na=":")
  return(Tabela_davki)
}

uvoz.starost <- function(Tabela_starost) {
  link_starost <- "https://en.wikipedia.org/wiki/List_of_countries_by_median_age"
  stran_starost <- html_session(link_starost) %>% read_html()
  Tabela_starost <- stran_starost %>% html_nodes(xpath = "//table[@class='wikitable sortable']") %>%
    .[[1]] %>% html_table(dec=".")
  Tabela_starost <- Tabela_starost[ ,c("Country/Territory", "Median(Years)")]
  return(Tabela_starost)
}

Tabela_place <- uvoz.place()
Tabela_BDP <- uvoz.BDP()
Tabela_davki <- uvoz.davki()
Tabela_starost <- uvoz.starost()

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.
