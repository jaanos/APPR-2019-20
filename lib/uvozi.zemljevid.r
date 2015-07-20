# Uvoz potrebnih knjižnic
library(sp)
library(maptools)
library(digest)
gpclibPermit()

# Funkcija uvozi.zemljevid(url, ime.zemljevida, pot.zemljevida,
#                         encoding = "Windows-1250", force = FALSE)
#
# Funkcija najprej preveri, ali zemljevid na podani lokaciji že obstaja. Če
# ne obstaja ali če je parameter force nastavljen na TRUE, pobere arhiv z
# navedenega naslova in ga razširi. Nato uvozi zemljevid in ga vrne.
#
# Parametri:
#   * url             Naslov URL, iz katerega naj dobimo arhiv z zemljevidom.
#   * pot.zemljevida  Pot do datoteke SHP, kakršna je v pobranem arhivu,
#                     brez končnice.
#   * mapa            Pot do mape, kamor naj se shrani zemljevid (privzeto
#                     mapa "../zemljevid")
#   * encoding        Kodiranje znakov v zemljevidu (privzeta vrednost
#                     "Windows-1250").
#   * force           Ali naj se zemljevid v vsakem primeru pobere z navedenega
#                     naslova (privzeta vrednost FALSE).
#
# Vrača:
#   * zemljevid (SpatialPolygonsDataFrame) iz pobranega arhiva
uvozi.zemljevid <- function(url, pot.zemljevida, mapa = "../zemljevidi",
                            encoding = "UTF-8", force = FALSE) {
  ime.zemljevida <- digest(url, algo = "sha1")
  map <- paste0(mapa, "/", ime.zemljevida)
  pot <- paste0(map, "/", pot.zemljevida)
  shp <- paste0(pot, ".shp")
  zip <- paste0(map, "/", ime.zemljevida, ".zip")
  if (force || !file.exists(shp)) {
    if (!file.exists(map)) {
      dir.create(map, recursive = TRUE)
    }
    download.file(url, zip)
    unzip(zip, exdir = map)
  }
  re <- paste0("^", gsub("\\.", "\\.", pot.zemljevida), "\\.")
  files <- grep(paste0(re, "[a-z0-9.]*$"),
                grep(paste0(re, ".*$"), dir(map, recursive = TRUE), value = TRUE),
                value = TRUE, invert = TRUE)
  file.rename(paste0(map, "/", files),
              paste0(map, "/", sapply(strsplit(files, "\\."),
                                      function(x)
                                        paste(c(x[1], tolower(x[2:length(x)])),
                                              collapse = "."))))
  zemljevid <- readShapeSpatial(shp)

  for (col in names(zemljevid)) {
    if (is.factor(zemljevid[[col]])) {
      zemljevid[[col]] <- factor(iconv(zemljevid[[col]], encoding))
    }
  }
  
  return(zemljevid)
}

# Primer uvoza zemljevida (slovenske občine)
#obcine <- uvozi.zemljevid("http://e-prostor.gov.si/fileadmin/BREZPLACNI_POD/RPE/OB.zip",
#                          "OB/OB", encoding = "Windows-1250")

# Funkcija preuredi(podatki, zemljevid, stolpec, novi = NULL)
#
# Funkcija preuredi vrstice oziroma elemente podatkov glede na imena vrstic oziroma
# imena tako, da ta ustrezajo imenom v danem stolpcu zemljevida, če oboje uredimo.
# Tako dobljene podatke lahko potem narišemo na zemljevid, tudi če nimamo popolnega
# ujemanja imen.
#
# Parametri:
#   * podatki         Razpredelnica z imeni vrstic ali vektor z imeni.
#   * zemljevid       Zemljevid, za katerega urejamo.
#   * stolpec         Ime stolpca v zemljevidu, glede na katerega urejamo.
#   * novi            Imena, ki morda manjkajo v podatkih (privzeta vrednost NULL)
#                     za zapolnitev z NA.
#
# Vrača:
#   * razpredelnico z istimi stolpci in preurejenimi vrsticami, če so bili podatki
#     v razpredelnici, ali
#   * vektor s preurejenimi elementi, če so bili podatki v vektorju.
preuredi <- function(podatki, zemljevid, stolpec, novi = NULL) {
  vec <- is.vector(podatki)
  if (vec) {
    podatki <- data.frame(podatki)
  }
  manjkajo <- ! novi %in% rownames(podatki)
  M <- as.data.frame(matrix(nrow=sum(manjkajo), ncol=length(podatki)))
  names(M) <- names(podatki)
  row.names(M) <- novi[manjkajo]
  podatki <- rbind(podatki, M)
  ord <- order(rownames(podatki))[rank(levels(zemljevid[[stolpec]])[rank(zemljevid[[stolpec]])])]
  out <- data.frame(podatki)[ord, ]
  if (ncol(podatki) == 1) {
    if (vec) {
      names(out) <- rownames(podatki)[ord]
    } else {
      out <- data.frame(out)
      names(out) <- names(podatki)
      rownames(out) <- rownames(podatki)[ord]
    }
  }
  return(out)
}
