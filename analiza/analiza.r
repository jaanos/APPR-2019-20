# 4. faza: Analiza podatkov

# Uvozimo funkcijo za uvoz spletne strani.
source("analiza/xml.r")

# Preberemo spletno stran v razpredelnico.
tabela <- preuredi(uvozi.obcine(), obcine)

# Narišemo graf v datoteko PDF.
pdf("slike/naselja.pdf")
plot(tabela[[1]], tabela[[4]],
     main = "Število naselij glede na površino občine",
     xlab = "Površina (km^2)",
     ylab = "Št. naselij")
dev.off()