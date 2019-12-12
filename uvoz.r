# 2. faza: Uvoz podatkov
#poskusna
link <- "https://www.sofascore.com/api/v1/unique-tournament/8/season/24127/statistics?filters=position.in.G&fields=saves%2CcleanSheet%2CpenaltySave%2CsavedShotsFromInsideTheBox%2CrunsOut%2Crating&group=goalkeeper&accumulation=total&order=-rating&limit=50&_=1575537091"
data <- GET(link) %>% content()
igralec <- sapply(data$results, . %>% { .$player$name })
ekipa <- sapply(data$results, . %>% { .$team$slug })
stolpci <- c("saves", "cleanSheet", "penaltySave", "savedShotsFromInsideTheBox", "runsOut", "rating")
podatki <- data.frame(igralec, ekipa, sapply(stolpci, function(s) sapply(data$results, . %>% .[[s]])))
#vratarji/nastopi/tekme brez 

link1 <- "https://www.sofascore.com/event/7828254/event/json?_=157613722"
data <- GET(link1) %>% content()
