library(ggplot2)
library(ggvis)
# 3. faza: Vizualizacija podatkov

# Uvozimo zemljevid.
#zemljevid <- uvozi.zemljevid("http://baza.fmf.uni-lj.si/OB.zip", "OB",
#                             pot.zemljevida="OB", encoding="Windows-1250")
#levels(zemljevid$OB_UIME) <- levels(zemljevid$OB_UIME) %>%
#  { gsub("Slovenskih", "Slov.", .) } %>% { gsub("-", " - ", .) }
#zemljevid$OB_UIME <- factor(zemljevid$OB_UIME, levels=levels(obcine$obcina))
#zemljevid <- fortify(zemljevid)

# Izračunamo povprečno velikost družine
#povprecja <- druzine %>% group_by(obcina) %>%
#  summarise(povprecje=sum(velikost.druzine * stevilo.druzin) / sum(stevilo.druzin))

######
ggplot(tabela_1) + aes(x=igralec, y=cleanSheet) + geom_point()
ggplot(tabela_1) + aes(x=appearances, y=cleanSheet, color=igralec) + geom_point()+ geom_text(aes(label=igralec),hjust=0, vjust=0) + ggtitle("Tekme brez prejetega zadetka")
ggplot(tabela_2) + aes(x=penaltyFaced, y=penaltySave, color=igralec) + geom_point() + ggtitle("Posredovanje pri enajstmetrovkah")
ggplot(tabela_2) + aes(x=savedShotsFromInsideTheBox, y=goalsConcededInsideTheBox, color=igralec) + geom_point() + ggtitle("Posredovanje pri strelih znotraj kazenskega prostora")
ggplot(tabela_2) + aes(x=savedShotsFromOutsideTheBox, y=goalsConcededOutsideTheBox, color=igralec) + geom_point() + ggtitle("Posredovanje pri strelih izven kazenskega prostora")
ggplot(tabela_3) + aes(x=runsOut, y=successfulRunsOut, color=igralec) + geom_point() + ggtitle("Iztekanja")
ggplot(tabela_3) + aes(x=highClaims, y=crossesNotClaimed, color=igralec) + geom_point() + ggtitle("Posredovanje pri predložkih")
ggplot(tabela_4) + aes(x=igralec, y=totalPasses, size=accuratePassesPercentage) + geom_point() + ggtitle("Podaje")
ggplot(tabela_4) + aes(x=igralec, y=accurateLongBalls, size=accurateLongBallsPercentage) + geom_point() + ggtitle("Dolge žoge")

ggplot(podatki_v_ap_cs_ita) + aes(x=igralec, y=cleanSheet, color=appearances) + geom_point()
ggplot(podatki_v_ap_cs_ita) + aes(x=appearances, y=cleanSheet, color=igralec) + geom_point()

#ggplot(podatki_v_ap_cs_ita) + aes(x=factor(1), fill=igralec) + geom_bar(width=1) +
 # coord_polar(theta="y") + xlab("") + ylab("")

#tortni diagram za ita, za cleansheete 
bp<- ggplot(podatki_v_ap_cs_ita, aes(x="", y=cleanSheet, fill=igralec))+
  geom_bar(width = 1, stat = "identity")
bp
pie <- bp + coord_polar("y", start=0)
pie
#za vse
bp<- ggplot(tabela_1, aes(x="", y=cleanSheet, fill=igralec))+
  geom_bar(width = 1, stat = "identity")
bp
pie <- bp + coord_polar("y", start=0)
pie

# Uvozimo zemljevid.
zemljevid <- uvozi.zemljevid("https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/110m_cultural.zip",
                             "ne_110m_admin_0_countries", encoding="UTF-8")
#z <- ggplot(zemljevid, aes(x=long, y=lat))

tm_shape(merge(zemljevid,
               t1 %>% group_by(drzava) %>% summarise(cleanSheet=sum(cleanSheet)),
               by.x="SOVEREIGNT", by.y="drzava")) +
  tm_polygons("cleanSheet")

tm_shape(merge(zemljevid,
               t2 %>% group_by(drzava) %>% summarise(penaltySave=sum(penaltySave)),
               by.x="SOVEREIGNT", by.y="drzava")) +
  tm_polygons("penaltySave")




