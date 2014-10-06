library(XML)

# Vrne vektor nizov z odstranjenimi začetnimi in končnimi "prazninami" (whitespace)
# v iz vozlišč, ki ustrezajo podani poti.
stripByPath <- function(x, path) {
  unlist(xpathApply(x, path,
                    function(y) gsub("^\\s*(.*?)\\s*$", "\\1", xmlValue(y))))
}

url.gdp <- "http://data.worldbank.org/indicator/NY.GDP.PCAP.CD/countries/1W?display=default"
doc.gdp <- htmlTreeParse(url.gdp, useInternalNodes=TRUE)

# Poiščemo vse tabele v dokumentu
tabele <- getNodeSet(doc.gdp, "//table")

# Iz drugega otroka prve tabele (značka <tbody>) dobimo seznam vrstic (<tr>)
# neposredno pod trenutnim vozliščem
vrstice <- getNodeSet(tabele[[1]][[2]], "./tr")

# Seznam vrstic pretvorimo v seznam (znakovnih) vektorjev
# s porezanimi vsebinami celic (<td>) neposredno pod trenutnim vozliščem
seznam <- lapply(vrstice, stripByPath, "./td")

# Iz seznama vrstic naredimo matriko
matrika <- matrix(unlist(seznam), nrow=length(seznam), byrow=TRUE)

# Imena stolpcev matrike dobimo iz celic (<th>) glave (prvega otroka, <thead>) prve tabele
colnames(matrika) <- stripByPath(tabele[[1]][[1]], ".//th")

# Podatke iz matrike spravimo v razpredelnico
tabela <- data.frame(apply(gsub(",", "", matrika[,2:5]), 2, as.numeric),
                     row.names=matrika[,1])
