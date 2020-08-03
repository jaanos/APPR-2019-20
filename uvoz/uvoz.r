# 2. faza: Uvoz podatkov

# preberemo podatke

podatki <- read_excel("podatki/stevilo_pimerov_SLO.xlsx", sheet = "Potrjeni primeri", skip = 1, col_names = TRUE)

# izbrišemo nepotrebne stolpce

podatki <- podatki[,-c(3,5,8:11)]

colnames(podatki) <- c("datum.prijave", "rutinsko.dnevno", "raziskava.dnevno", "moski", "zenske")



# spremenimo obliko datumov kot so v excelu

datumi <- podatki[2:nrow(podatki),]$datum.prijave

novi.datumi <- as.Date(as.numeric(datumi), origin = "1899-12-30")

podatki[2:nrow(podatki),1] <- as.character(novi.datumi)



rutinsko.testiranje <- podatki[,c(1,2)]

colnames(rutinsko.testiranje) <- c("datum.prijave", "dnevno.stevilo.testiranj")



nacionalna.raziskava <- podatki[,c(1,3)]

colnames(nacionalna.raziskava) <- c("datum.prijave", "dnevno.stevilo.testiranj")



# lahko pa obe tabeli skupaj

testiranje <- podatki[,1:3]

colnames(testiranje) <- c("datum.prijave", "rutinsko.testiranje", "nacionalna.raziskava")

testiranje <- gather(testiranje, key = "tip", value = "dnevno.stevilo", - datum.prijave)



potrjeni.primeri.dnevno <- podatki[2:nrow(podatki),c(1,4:5)]

colnames(potrjeni.primeri.dnevno) <- c("datum.prijave", "moski", "zenske")

potrjeni.primeri.dnevno <- gather(potrjeni.primeri.dnevno, key = "spol", value = "dnevno.stevilo", - datum.prijave)
sl <- locale("sl", decimal_mark=",", grouping_mark=".")




# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.


