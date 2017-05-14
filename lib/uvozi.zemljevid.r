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
# obcine <- uvozi.zemljevid("http://baza.fmf.uni-lj.si/OB.zip",
#                           "OB/OB", encoding = "Windows-1250")

# Funkcija pretvori.zemljevid(podatki, zemljevid, stolpec, novi = NULL)
#
# Funkcija pretvori zemljevid v obliko, ki jo lahko uporabimo pri risanju z ggplot2.
#
# Parametri:
#   * zemljevid       Zemljevid, ki ga pretvarjami.
#
# Vrača:
#   * razpredelnico s podatki iz zemljevida, ki jo lahko uporabimo z ggplot2
pretvori.zemljevid <- function(zemljevid) {
  fo <- fortify(zemljevid)
  data <- zemljevid@data
  data$id <- as.character(0:(nrow(data)-1))
  return(inner_join(fo, data, by="id"))
}
