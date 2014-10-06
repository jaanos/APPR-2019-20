# 3. faza: Izdelava zemljevida

# Uvozimo funkcijo za pobiranje in uvoz zemljevida.
source("zemljevid/uvozi.zemljevid.r")

# Uvozimo zemljevid.
obcine <- uvozi.zemljevid("http://e-prostor.gov.si/fileadmin/BREZPLACNI_POD/RPE/OB.zip",
                          "obcine", "OB/OB.shp", mapa = "zemljevid",
                          encoding = "Windows-1250")

# Funkcija, ki podatke preuredi glede na vrstni red v zemljevidu
preuredi <- function(podatki, zemljevid) {
  nove.obcine <- c("Ankaran", "Koper", "Mirna")
  manjkajo <- ! nove.obcine %in% rownames(podatki)
  M <- as.data.frame(matrix(nrow=sum(manjkajo), ncol=length(podatki)))
  names(M) <- names(podatki)
  row.names(M) <- nove.obcine[manjkajo]
  podatki <- rbind(podatki, M)
  
  out <- data.frame(podatki[order(rownames(podatki)), ])[rank(levels(zemljevid$OB_UIME)[rank(zemljevid$OB_UIME)]), ]
  if (ncol(podatki) == 1) {
    out <- data.frame(out)
    names(out) <- names(podatki)
    rownames(out) <- rownames(podatki)
  }
  return(out)
}

# Preuredimo podatke, da jih bomo lahko izrisali na zemljevid.
druzine <- preuredi(druzine, obcine)

# Izračunamo povprečno velikost družine.
druzine$povprecje <- apply(druzine[1:4], 1, function(x) sum(x*(1:4))/sum(x))
min.povprecje <- min(druzine$povprecje, na.rm=TRUE)
max.povprecje <- max(druzine$povprecje, na.rm=TRUE)

# Narišimo zemljevid v PDF.
pdf("slike/povprecna_druzina.pdf")

n = 100
barve = topo.colors(n)[1+(n-1)*(druzine$povprecje-min.povprecje)/(max.povprecje-min.povprecje)]
plot(obcine, col = barve)

dev.off()