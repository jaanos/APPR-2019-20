# 4. faza: Analiza podatkov

# Narišemo graf v datoteko PDF.
cat("Rišem graf...\n")
barve <- rainbow(length(levels(obcine[[7]])))
names(barve) <- levels(obcine[[7]])
pdf("slike/naselja_povrsina.pdf")
plot(obcine[[1]], obcine[[4]],
     main = "Število naselij glede na površino občine",
     xlab = "Površina (km^2)",
     ylab = "Št. naselij",
     col = barve[obcine[[7]]])
legend("topright", legend = names(barve), col = barve, pch = 1, cex = 0.7)
dev.off()