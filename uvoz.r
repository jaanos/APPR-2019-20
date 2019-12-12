#poskusna
link <- "https://www.sofascore.com/api/v1/unique-tournament/8/season/24127/statistics?filters=position.in.G&fields=saves%2CcleanSheet%2CpenaltySave%2CsavedShotsFromInsideTheBox%2CrunsOut%2Crating&group=goalkeeper&accumulation=total&order=-rating&limit=50&_=1575537091"
data <- GET(link) %>% content()
igralec <- sapply(data$results, . %>% { .$player$name })
ekipa <- sapply(data$results, . %>% { .$team$slug })
stolpci <- c("saves", "cleanSheet", "penaltySave", "savedShotsFromInsideTheBox", "runsOut", "rating")
podatki <- data.frame(igralec, ekipa, sapply(stolpci, function(s) sapply(data$results, . %>% .[[s]])))


#vratarji/nastopi/tekme brez zadetka -ita

stolpci <- c("cleanSheet", "appearances")
stevilo <- 40
link <- sprintf("https://www.sofascore.com/api/v1/unique-tournament/23/season/17932/statistics?filters=appearances.GT.5%%2Cposition.in.G&fields=%s&accumulation=total&order=-rating&limit=%d&_=1576138130",
                paste(stolpci, collapse="%2C"), stevilo)
data <- GET(link) %>% content()
igralec <- sapply(data$results, . %>% { .$player$name })
ekipa <- sapply(data$results, . %>% { .$team$slug })
podatki_v_ap_cs_ita <- data.frame(igralec, ekipa, sapply(stolpci, function(s) sapply(data$results, . %>% .[[s]])))

#vratarji/nastopi/tekme brez zadetka -fra
stolpci <- c("cleanSheet", "appearances")
stevilo <- 40
link <- sprintf("https://www.sofascore.com/api/v1/unique-tournament/34/season/17279/statistics?filters=appearances.GT.5%%2Cposition.in.G&fields=%s&accumulation=total&order=-rating&limit=%d&_=1576138398",
                paste(stolpci, collapse="%2C"), stevilo)
data <- GET(link) %>% content()
igralec <- sapply(data$results, . %>% { .$player$name })
ekipa <- sapply(data$results, . %>% { .$team$slug })
podatki_v_ap_cs_fra <- data.frame(igralec, ekipa, sapply(stolpci, function(s) sapply(data$results, . %>% .[[s]])))


#vratarji/nastopi/tekme brez zadetka -ang
stolpci <- c("cleanSheet", "appearances")
stevilo <- 40
link <- sprintf("https://www.sofascore.com/api/v1/unique-tournament/17/season/17359/statistics?filters=appearances.GT.5%%2Cposition.in.G&fields=%s&accumulation=total&order=-rating&limit=%d&_=1576139010",
                paste(stolpci, collapse="%2C"), stevilo)
data <- GET(link) %>% content()
igralec <- sapply(data$results, . %>% { .$player$name })
ekipa <- sapply(data$results, . %>% { .$team$slug })
podatki_v_ap_cs_ang <- data.frame(igralec, ekipa, sapply(stolpci, function(s) sapply(data$results, . %>% .[[s]])))

#vratarji/nastopi/tekme brez zadetka -spa
stolpci <- c("cleanSheet", "appearances")
stevilo <- 40
link <- sprintf("https://www.sofascore.com/api/v1/unique-tournament/8/season/18020/statistics?filters=appearances.GT.5%%2Cposition.in.G&fields=%s&accumulation=total&order=-rating&limit=%d&_=1576139254",
                paste(stolpci, collapse="%2C"), stevilo)
data <- GET(link) %>% content()
igralec <- sapply(data$results, . %>% { .$player$name })
ekipa <- sapply(data$results, . %>% { .$team$slug })
podatki_v_ap_cs_spa <- data.frame(igralec, ekipa, sapply(stolpci, function(s) sapply(data$results, . %>% .[[s]])))

#vratarji/nastopi/tekme brez zadetka - nem
stolpci <- c("cleanSheet", "appearances")
stevilo <- 40
link <- sprintf("https://www.sofascore.com/api/v1/unique-tournament/35/season/17597/statistics?filters=appearances.GT.5%%2Cposition.in.G&fields=%s&accumulation=total&order=-rating&limit=%d&_=1576139623",
                paste(stolpci, collapse="%2C"), stevilo)
data <- GET(link) %>% content()
igralec <- sapply(data$results, . %>% { .$player$name })
ekipa <- sapply(data$results, . %>% { .$team$slug })
podatki_v_ap_cs_nem<- data.frame(igralec, ekipa, sapply(stolpci, function(s) sapply(data$results, . %>% .[[s]])))

#vratarji/zadetki znotraj 16/ odstotek, glede na obrambe / zadetki izven 16/ odstotek/ obranjene enajstmetrovke/ odstotek - ita
stolpci <- c("goalsConcededInsideTheBox", "savedShotsFromInsideTheBox", "goalsConcededOutsideTheBox", "savedShotsFromOutsideTheBox", "penaltySave", "penaltyFaced")
stevilo <- 40
link <- sprintf("https://www.sofascore.com/api/v1/unique-tournament/23/season/17932/statistics?filters=appearances.GT.5%%2Cposition.in.G&fields=%s&accumulation=total&order=-rating&limit=%d&_=1576140408",
                paste(stolpci, collapse="%2C"), stevilo)
data <- GET(link) %>% content()
igralec <- sapply(data$results, . %>% { .$player$name })
ekipa <- sapply(data$results, . %>% { .$team$slug })
podatki_v_zz16_oo_zi16_oo_o11_v11_ita <- data.frame(igralec, ekipa, sapply(stolpci, function(s) sapply(data$results, . %>% .[[s]])))


#inspect, network, potrdi, statistic, podvoji %, daj stolpce ven(%s), %d za število vrstic
