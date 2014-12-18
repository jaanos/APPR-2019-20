# 3. faza: Izdelava zemljevida

# Uvozimo funkcijo za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r", encoding = "UTF-8")

# Uvozimo zemljevid.
cat("Uvažam zemljevid...\n")
zemljevid <- uvozi.zemljevid("http://e-prostor.gov.si/fileadmin/BREZPLACNI_POD/RPE/OB.zip",
                             "obcine", "OB/OB.shp", mapa = "zemljevid",
                             encoding = "Windows-1250")

# Preuredimo podatke, da jih bomo lahko izrisali na zemljevid.
druzine <- preuredi(druzine, zemljevid, "OB_UIME", c("Ankaran", "Mirna"))

# Izračunamo povprečno velikost družine.
druzine$povprecje <- apply(druzine[1:4], 1, function(x) sum(x*(1:4))/sum(x))
min.povprecje <- min(druzine$povprecje, na.rm=TRUE)
max.povprecje <- max(druzine$povprecje, na.rm=TRUE)

# Narišimo zemljevid v PDF.
cat("Rišem zemljevid...\n")
pdf("slike/povprecna_druzina.pdf")

n = 100
barve = topo.colors(n)[1+(n-1)*(druzine$povprecje-min.povprecje)/(max.povprecje-min.povprecje)]
plot(zemljevid, col = barve)
title("Povprečno število otrok v družini")

dev.off()
