# 3. faza: Vizualizacija podatkov

# Zemljevid

#map <- shapefile("podatki/gadm36_DEU_1.shp")
map <- uvozi.zemljevid("https://biogeo.ucdavis.edu/data/gadm3.6/shp/gadm36_DEU_shp.zip",
                       "gadm36_DEU_1", encoding="UTF-8")
map$NAME_1 <- tabela1$Regija
osma <- map$NAME_1[8]
deveta <- map$NAME_1[9]
map$NAME_1[8] <- deveta
map$NAME_1[9] <- osma

# Zdruzimo manjše regije z večjimi, ki prve vsebujejo
# indeksi
# Berlin in Brandenburg sta 3 in 4
# Hamburg in S-H sta 6 in 15
# Bremen in Lower Sax sta 5 in 8
blend <- tabela1 %>% mutate(`Pop/area` = Populacija/Povrsina)
blend$`Pop/area`[3] <- (blend$Populacija[3] + blend$Populacija[4])/(blend$Povrsina[3] + blend$Povrsina[4])
blend$`Pop/area`[4] <- (blend$Populacija[3] + blend$Populacija[4])/(blend$Povrsina[3] + blend$Povrsina[4])
blend$`Pop/area`[6] <- (blend$Populacija[6] + blend$Populacija[15])/(blend$Povrsina[6] + blend$Povrsina[15])
blend$`Pop/area`[15] <- (blend$Populacija[6] + blend$Populacija[15])/(blend$Povrsina[6] + blend$Povrsina[15])
blend$`Pop/area`[5] <- (blend$Populacija[5] + blend$Populacija[8])/(blend$Povrsina[5] + blend$Povrsina[8])
blend$`Pop/area`[8] <- (blend$Populacija[5] + blend$Populacija[8])/(blend$Povrsina[5] + blend$Povrsina[8])

# Vizualizacije tabele 3


p1 <- ggplot(tabela2, aes(x = Namen, fill = Ocena)) +
  geom_bar() + theme(text = element_text(size = 9))

p2 <- ggplot(tabela2, aes(x = Zaposlitev, fill = Ocena)) +
  geom_bar()

p3 <- ggplot(tabela2, aes(x = `Velikost kredita`)) +
  geom_density(fill="#69b3a2", color="#e9ecef", alpha=0.8)

p4 <- ggplot(tabela2, aes(x = Trajanje)) +
  geom_density(fill="#69b3a2", color="#e9ecef", alpha=0.8)

p5 <- ggplot(tabela2, aes(x = Nastanitev, fill = Ocena)) +
  geom_bar()

p6 <- ggplot(tabela2, aes(x = Prihranki, fill = Ocena)) +
  geom_bar()

p7 <- ggplot(tabela2 %>% filter(!is.na(Prihranki))) +
  geom_jitter(aes(x = Prihranki, y = Nastanitev, shape = Ocena, color = Ocena))


  

# tm_shape(merge(zemljevid, povprecja, by.x="OB_UIME", by.y="obcina")) +
#   tm_polygons("povprecje", title="Povprečje") +
#   tm_layout(title="Povprečno število otrok v družini")
# 
# # Uvozimo zemljevid.
# zemljevid <- uvozi.zemljevid("http://baza.fmf.uni-lj.si/OB.zip", "OB",
#                              pot.zemljevida="OB", encoding="Windows-1250")

