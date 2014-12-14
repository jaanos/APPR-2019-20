# 2. faza: Uvoz podatkov

source("lib/xml.r", encoding = "UTF-8")

# Funkcija, ki uvozi podatke iz datoteke druzine.csv
uvozi.druzine <- function() {
  return(read.table("podatki/druzine.csv", sep = ";", as.is = TRUE,
                      row.names = 1,
                      col.names = c("obcina", "en", "dva", "tri", "stiri"),
                      fileEncoding = "Windows-1250"))
}

# Zapišimo podatke v razpredelnico druzine.
cat("Uvažam podatke o družinah...\n")
druzine <- uvozi.druzine()

cat("Uvažam podatke o občinah...\n")
obcine <- uvozi.obcine()

cat("Rišem histogram...\n")
pdf("slike/naselja.pdf")
hist(obcine[,4], main = "Pogostost števila naselij",
     xlab = "Število naselij", ylab = "Število občin")
dev.off()

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.