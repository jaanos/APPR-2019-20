# 3. faza: Izdelava zemljevida

# Uvozimo zemljevid.
zemljevid <- uvozi.zemljevid("http://e-prostor.gov.si/fileadmin/BREZPLACNI_POD/RPE/OB.zip",
                             "OB/OB", encoding = "Windows-1250")

# Preuredimo podatke, da jih bomo lahko izrisali na zemljevid.
druzine <- preuredi(druzine, zemljevid, "OB_UIME", c("Ankaran", "Mirna"))

# Izračunamo povprečno velikost družine.
druzine$povprecje <- apply(druzine[1:4], 1, function(x) sum(x*(1:4))/sum(x))
min.povprecje <- min(druzine$povprecje, na.rm=TRUE)
max.povprecje <- max(druzine$povprecje, na.rm=TRUE)
