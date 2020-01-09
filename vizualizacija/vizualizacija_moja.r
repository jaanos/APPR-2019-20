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

# IzraÄunamo povpreÄno velikost druÅ¾ine
#povprecja <- druzine %>% group_by(obcina) %>%
#  summarise(povprecje=sum(velikost.druzine * stevilo.druzin) / sum(stevilo.druzin))

######
ggplot(t1) + aes(x=igralec, y=cleanSheet) + geom_bar(stat="identity")
ggplot(t1) + aes(x=appearances, y=cleanSheet, color=drzava) + geom_point()+ geom_text(aes(label=igralec),hjust=0, vjust=0) + ggtitle("Tekme brez prejetega zadetka")
ggplot(t2) + aes(x=penaltyFaced, y=penaltySave, color=drzava) + geom_point() + geom_text(aes(label=igralec),hjust=0, vjust=0) + ggtitle("Posredovanje pri enajstmetrovkah")
ggplot(t2) + aes(x=savedShotsFromInsideTheBox, y=goalsConcededInsideTheBox, color=drzava) + geom_point() + geom_text(aes(label=igralec),hjust=0, vjust=0) + ggtitle("Posredovanje pri strelih znotraj kazenskega prostora")
ggplot(t2) + aes(x=savedShotsFromOutsideTheBox, y=goalsConcededOutsideTheBox, color=drzava) + geom_point() + geom_text(aes(label=igralec),hjust=0, vjust=0) + ggtitle("Posredovanje pri strelih izven kazenskega prostora")
ggplot(t3) + aes(x=runsOut, y=successfulRunsOut, color=drzava) + geom_point() + geom_text(aes(label=igralec),hjust=0, vjust=0) + ggtitle("Iztekanja")
ggplot(t3) + aes(x=highClaims, y=crossesNotClaimed, color=igralec, shape=drzava) + geom_point() + ggtitle("Posredovanje pri predloÅ¾kih")
ggplot(t4) + aes(x=igralec, y=totalPasses, size=accuratePassesPercentage) + geom_point() + ggtitle("Podaje")
ggplot(t4) + aes(x=igralec, y=accurateLongBalls, size=accurateLongBallsPercentage) + geom_point() + ggtitle("Dolge Å¾oge")

t5 <- t1 %>% group_by(drzava) %>% summarise(cleanSheet_drzava=sum(cleanSheet))
ggplot(t5) + aes(x=drzava, y=cleanSheet_drzava) + geom_bar(stat="identity")

t6 <- t2 %>% group_by(drzava) %>% summarise(penaltySave_drzava=sum(penaltySave))
ggplot(t6) + aes(x=drzava, y=penaltySave_drzava) + geom_bar(stat="identity")


#ggplot(t1, aes(x=cleanSheet)) + geom_histogram() +
#  ggtitle("Pogostost števila naselij") + xlab("Število naselij") + ylab("Število obèin")

#ggplot(podatki_v_ap_cs_ita) + aes(x=igralec, y=cleanSheet, color=appearances) + geom_point()
#ggplot(podatki_v_ap_cs_ita) + aes(x=appearances, y=cleanSheet, color=igralec) + geom_point()


# #tortni diagram za ita, za cleansheete 
# bp<- ggplot(podatki_v_ap_cs_ita, aes(x="", y=cleanSheet, fill=igralec))+
#   geom_bar(width = 1, stat = "identity")
# bp
# pie <- bp + coord_polar("y", start=0)
# pie
#za vse
bp<- ggplot(t1, aes(x="", y=cleanSheet, fill=igralec))+
 geom_bar(width = 1, stat = "identity")
bp
pie <- bp + coord_polar("y", start=0)
pie

#z <- ggplot(zemljevid, aes(x=long, y=lat))
# Uvozimo zemljevid.
zemljevid <- uvozi.zemljevid("https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/110m_cultural.zip",
                             "ne_110m_admin_0_countries", encoding="UTF-8")

tm_shape(merge(zemljevid,
               t1 %>% group_by(drzava) %>% summarise(cleanSheet=sum(cleanSheet)),
               by.x="SOVEREIGNT", by.y="drzava")) +
  tm_polygons("cleanSheet")

tm_shape(merge(zemljevid,
               t2 %>% group_by(drzava) %>% summarise(penaltySave=sum(penaltySave)),
               by.x="SOVEREIGNT", by.y="drzava")) +
  tm_polygons("penaltySave")




