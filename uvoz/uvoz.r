# 2. faza: Uvoz podatkov

# preberemo podatke

#podatki <- read_excel("podatki/stevilo_pimerov_SLO.xlsx", sheet = "Potrjeni primeri", skip = 1, col_names = TRUE)
podatki <- read_excel("podatki/korona_statistika_SLO.xlsx", sheet = "Potrjeni primeri", skip = 1, col_names = TRUE)
# izbrišemo nepotrebne stolpce

podatki <- podatki[,-c(3,5,8:11)]
#zrihtani datumi


podatki[,1] <- seq(as.Date("2020-03-03"), as.Date("2020-08-03"), by="days")
#podatki$datum.prijave <- as.Date(podatki$datum.prijave,"%Y-%m-%d")

#Ročno olajšanje dela
podatki[62,3]<- NA
podatki[1,4] <- 0
podatki[1,5] <- 0


#Ali gre za delovni dan?
podatki["Delovni dan"] <- c(TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,TRUE)


colnames(podatki) <- c("datum", "rutinsko.dnevno", "raziskava.dnevno", "moski", "zenske","delovni.dan")
podatki$raziskava.dnevno <- as.integer(podatki$raziskava.dnevno)


# spremenimo obliko datumov kot so v excelu

#datumi <- podatki[2:nrow(podatki),]$datum.prijave

#novi.datumi <- as.Date(as.numeric(datumi), origin = "1899-12-30")

#podatki[2:nrow(podatki),1] <- as.character(novi.datumi)



rutinsko.testiranje <- podatki[,c(1,2)]

colnames(rutinsko.testiranje) <- c("datum", "dnevno.stevilo.testiranj")



nacionalna.raziskava <- podatki[,c(1,3)]

colnames(nacionalna.raziskava) <- c("datum", "dnevno.stevilo.testiranj")



# lahko pa obe tabeli skupaj

testiranje <- podatki[,1:3]

colnames(testiranje) <- c("datum", "rutinsko.testiranje", "nacionalna.raziskava")

testiranje <- gather(testiranje, key = "tip", value = "dnevno.stevilo", - datum)



potrjeni.primeri.dnevno <- podatki[2:nrow(podatki),c(1,4:5)]

colnames(potrjeni.primeri.dnevno) <- c("datum", "moski", "zenske")

potrjeni.primeri.dnevno <- gather(potrjeni.primeri.dnevno, key = "spol", value = "dnevno.stevilo", - datum)
sl <- locale("sl", decimal_mark=",", grouping_mark=".")

###################################################################################################

podatki_svet <- read_csv("podatki/korona_po svetu_csv.csv",
                         
                         col_types=cols(.default=col_number(),
                                        
                                        iso_code=col_character(),
                                        
                                        continent=col_character(),
                                        
                                        location=col_character(),
                                        
                                        date=col_date(),
                                        
                                        tests_units=col_character()))
podatki_svet<- podatki_svet[,c(1:5,7,9,11,13,29,36)]

###################################################################################################

population_by_continent <- htmltab("https://en.wikipedia.org/wiki/List_of_continents_by_population",1)

population_by_continent <-population_by_continent[c(2:7),c(2,3)]

colnames(population_by_continent)<- c("continent","population_continent")

population_by_continent$population_continent <- gsub(",","",population_by_continent$population_continent)

population_by_continent$population_continent <- as.numeric(as.character(population_by_continent$population_continent))

