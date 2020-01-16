# lahko združiš podatke o državah v eno samo tabelo 
# poišči še podatke o izobrazbi!


# UREJANJE GLAVNE TABELE O MIGRACIJI
migracija <- read_csv("podatki/migracija.csv", n_max = 160776, na = c("..")) %>%
  select(-"Migration by Gender Code", -"Country Origin Code", -"Country Dest Code")

colnames(migracija) <- c("origin_country", "gender", "dest_country", 
                         "1960-1969", "1970-1979", "1980-1989", "1990-1999", "2000-2010")

skupno <- migracija %>% filter(gender=="Total") %>% select(-"gender") %>% 
  gather(decade, number, "1960-1969", "1970-1979", "1980-1989", "1990-1999", "2000-2010") %>%
  arrange(origin_country)

poSpolih <- migracija %>% filter(gender=="Female" | gender=="Male" ) %>%
  gather(decade, number, "1960-1969", "1970-1979", "1980-1989", "1990-1999", "2000-2010") %>%
  arrange(origin_country)
poSpolih <- poSpolih[c(1,3,2,4,5)]


# BDP podatki iz wikipedije
url <- "https://en.wikipedia.org/wiki/List_of_countries_by_past_and_projected_GDP_(PPP)"
stran <- read_html(url)

bdpji <- stran %>%
  html_nodes(xpath = "//table[@class='sortable wikitable']//td") %>%
  html_text() %>% str_replace_all(',', '')

bdp <- as.data.frame(matrix(bdpji, ncol = 11, byrow = TRUE))
bdp <- data.frame(lapply(bdp, as.character), stringsAsFactors=FALSE)
bdp <- bdp[1:768, ]
bdp[bdp==""] <- NA
bdp[, 2:11] <- sapply(bdp[, 2:11], as.numeric)

osemdeseta <- bdp[1:192,]
colnames(osemdeseta) <- c("country", 1980:1989)
devetdeseta <- bdp[193:384,]
colnames(devetdeseta) <- c("country", 1990:1999)
dvatisoca <- bdp[385:576,]
colnames(dvatisoca) <- c("country", 2000:2009)
dvadeseta <- bdp[577:768,]
colnames(dvadeseta) <- c("country", 2010:2019)

osemdeseta <- osemdeseta %>% gather(leto, BDP, "1980":"1989")
devetdeseta <- devetdeseta %>% gather(leto, BDP, "1990":"1999")
dvatisoca <- dvatisoca %>% gather(leto, BDP, "2000":"2009")
dvadeseta <- dvadeseta %>% gather(leto, BDP, "2010":"2019")

bdp <- rbind(osemdeseta, devetdeseta, dvatisoca, dvadeseta)
bdp$BDP <- bdp$BDP * 1000
bdp[, 2] <- sapply(bdp[, 2], as.numeric)


# POPULACIJA
pop <- read.csv2("podatki/populacija.csv", skip = 16) %>% 
  filter(Type=="Country/Area") %>%
  select(-"Index", -"Variant", -"Notes", -"Country.code", -"Parent.code", -"Type") 
  
colnames(pop) <- c("country", 1950:2020)
pop[, 2:72] <- as.data.frame(apply(pop[, 2:72],2,function(x)gsub('\\s+', '',x)))
pop[, 1:72] <- sapply(pop[, 1:72], as.character)
pop[, 2:72] <- sapply(pop[, 2:72], as.numeric)
pop <- arrange(pop, country)
pop <- pop[, c(1, 12:62)]
pop <- pop %>% gather(leto, populacija, "1960":"2010")
pop$populacija <- pop$populacija * 1000


# RELIGIJE
relig <- read.csv("podatki/religije.csv") %>%
  rename(country = name) %>%
  select(-"pop2019") 
relig[, 1] <- sapply(relig[, 1], as.character)

rm(devetdeseta, dvadeseta, dvatisoca, migracija, osemdeseta, stran, bdpji, url)


# popravljanje imen držav (to lahko bolje napišeš)
bdp$country <- standardize.countrynames(bdp$country, suggest = "auto", print.changes = FALSE)
pop$country <- standardize.countrynames(pop$country, suggest = "auto", print.changes = FALSE)
poSpolih$origin_country <- standardize.countrynames(poSpolih$origin_country, suggest = "auto", print.changes = FALSE)
poSpolih$dest_country <- standardize.countrynames(poSpolih$dest_country, suggest = "auto", print.changes = FALSE)
relig$country <- standardize.countrynames(relig$country, suggest = "auto", print.changes = FALSE)


# # 2. faza: Uvoz podatkov
# 
# sl <- locale("sl", decimal_mark=",", grouping_mark=".")
# 
# # Funkcija, ki uvozi občine iz Wikipedije
# uvozi.obcine <- function() {
#   link <- "http://sl.wikipedia.org/wiki/Seznam_ob%C4%8Din_v_Sloveniji"
#   stran <- html_session(link) %>% read_html()
#   tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
#     .[[1]] %>% html_table(dec=",")
#   for (i in 1:ncol(tabela)) {
#     if (is.character(tabela[[i]])) {
#       Encoding(tabela[[i]]) <- "UTF-8"
#     }
#   }
#   colnames(tabela) <- c("obcina", "povrsina", "prebivalci", "gostota", "naselja",
#                         "ustanovitev", "pokrajina", "regija", "odcepitev")
#   tabela$obcina <- gsub("Slovenskih", "Slov.", tabela$obcina)
#   tabela$obcina[tabela$obcina == "Kanal ob Soči"] <- "Kanal"
#   tabela$obcina[tabela$obcina == "Loški potok"] <- "Loški Potok"
#   for (col in c("povrsina", "prebivalci", "gostota", "naselja", "ustanovitev")) {
#     if (is.character(tabela[[col]])) {
#       tabela[[col]] <- parse_number(tabela[[col]], na="-", locale=sl)
#     }
#   }
#   for (col in c("obcina", "pokrajina", "regija")) {
#     tabela[[col]] <- factor(tabela[[col]])
#   }
#   return(tabela)
# }
# 
# # Funkcija, ki uvozi podatke iz datoteke druzine.csv
# uvozi.druzine <- function(obcine) {
#   data <- read_csv2("podatki/druzine.csv", col_names=c("obcina", 1:4),
#                     locale=locale(encoding="Windows-1250"))
#   data$obcina <- data$obcina %>% strapplyc("^([^/]*)") %>% unlist() %>%
#     strapplyc("([^ ]+)") %>% sapply(paste, collapse=" ") %>% unlist()
#   data$obcina[data$obcina == "Sveti Jurij"] <- iconv("Sveti Jurij ob Ščavnici", to="UTF-8")
#   data <- data %>% gather(`1`:`4`, key="velikost.druzine", value="stevilo.druzin")
#   data$velikost.druzine <- parse_number(data$velikost.druzine)
#   data$obcina <- parse_factor(data$obcina, levels=obcine)
#   return(data)
# }
# 
# # Zapišimo podatke v razpredelnico obcine
# obcine <- uvozi.obcine()
# 
# # Zapišimo podatke v razpredelnico druzine.
# druzine <- uvozi.druzine(levels(obcine$obcina))
# 
# # Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# # potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# # datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# # 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# # fazah.