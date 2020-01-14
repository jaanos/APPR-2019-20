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

# IzraÄŤunamo povpreÄŤno velikost druĹľine
#povprecja <- druzine %>% group_by(obcina) %>%
#  summarise(povprecje=sum(velikost.druzine * stevilo.druzin) / sum(stevilo.druzin))

######
ggplot(t1) + aes(x=igralec, y=cleanSheet) + geom_bar(stat="identity")
ggplot(t1) + aes(x=appearances, y=cleanSheet, color=drzava) + geom_point()+ geom_text(aes(label=igralec),hjust=0, vjust=0) + ggtitle("Tekme brez prejetega zadetka") + xlab("Število nastopov") + ylab("Tekme brez prejetega zadetka")
ggplot(t2) + aes(x=penaltyFaced, y=penaltySave, color=drzava) + geom_point() + geom_text(aes(label=igralec),hjust=0, vjust=0) + ggtitle("Posredovanje pri enajstmetrovkah") + xlab("Število enajstmetrovk") + ylab("Število obranjenih enajstmetrovk")
ggplot(t2) + aes(x=savedShotsFromInsideTheBox, y=goalsConcededInsideTheBox, color=drzava) + geom_point() + geom_text(aes(label=igralec),hjust=0, vjust=0) + ggtitle("Posredovanje pri strelih znotraj kazenskega prostora") + xlab("Obranjeni streli znotraj kazenskega prostora") + ylab("Prejeti zadetki znotraj kazenskega prostora")
ggplot(t2) + aes(x=savedShotsFromOutsideTheBox, y=goalsConcededOutsideTheBox, color=drzava) + geom_point() + geom_text(aes(label=igralec),hjust=0, vjust=0) + ggtitle("Posredovanje pri strelih izven kazenskega prostora") + xlab("Obranjeni streli izven kazenskega prostora") + ylab("Prejeti zadetki izven kazenskega prostora")
ggplot(t3) + aes(x=runsOut, y=successfulRunsOut, color=drzava) + geom_point() + geom_text(aes(label=igralec),hjust=0, vjust=0) + ggtitle("Iztekanja") + xlab("Število iztekov") + ylab("Število uspešnih iztekov")
ggplot(t3) + aes(x=highClaims, y=crossesNotClaimed, color=drzava) + geom_point() + geom_text(aes(label=igralec),hjust=0, vjust=0) + ggtitle("Posredovanje pri predložkih") + xlab("Število ujetih predložkov") + ylab("Število napak pri predložkih")
ggplot(t4) + aes(x=ekipa, y=totalPasses, size=accuratePassesPercentage, color=drzava) + geom_point() + geom_text(aes(label=igralec),hjust=0, vjust=0) + ggtitle("Podaje") + xlab("Ekipa") + ylab("Število podaj")
ggplot(t4) + aes(x=accurateLongBallsPercentage, y=accurateLongBalls, size=accurateLongBallsPercentage, color=drzava) + geom_point() + geom_text(aes(label=igralec),hjust=0, vjust=0) + ggtitle("Dolge Žoge") + xlab("Odstotek natančnosti pri dolgih žogah") + ylab("Število dolgih žog")

t5 <- t1 %>% group_by(drzava) %>% summarise(cleanSheet_drzava=sum(cleanSheet))
ggplot(t5) + aes(x=drzava, y=cleanSheet_drzava, fill=drzava) + geom_bar(stat="identity") + guides(fill=FALSE) + ggtitle("Tekme brez prejetega zadetka, glede na države") + xlab("") + ylab("Tekme brez prejetega zadetka")

t6 <- t2 %>% group_by(drzava) %>% summarise(penaltySave_drzava=sum(penaltySave))
ggplot(t6) + aes(x=drzava, y=penaltySave_drzava, fill=drzava) + geom_bar(stat="identity") + guides(fill=FALSE) + ggtitle("Obranjena enajstmetrovke, glede na države") + xlab("") + ylab("Število obranjenih enajstmetrovk")

t6.2 <- t2 %>% group_by(drzava) %>% summarise(penaltyFaced_drzava=sum(penaltyFaced))
penaltyFaced_drzava <- t6.2[[2]]
t6.3 <- cbind(t6, penaltyFaced_drzava)
ggplot(t6.3) + aes(x=penaltyFaced_drzava, y=penaltySave_drzava) + geom_point() + geom_text(aes(label=drzava),hjust=0, vjust=0) + ggtitle("Enajstmetrovke, glede na države")

t7 <- t2 %>% group_by(drzava) %>% summarise(goalsConcededOutsideTheBox_drzava=sum(goalsConcededOutsideTheBox))
ggplot(t7) + aes(x=drzava, y=goalsConcededOutsideTheBox_drzava, fill=drzava) + geom_bar(stat="identity") + guides(fill=FALSE)

t8 <- t2 %>% group_by(drzava) %>% summarise(goalsConcededInsideTheBox_drzava=sum(goalsConcededInsideTheBox))
ggplot(t8) + aes(x=drzava, y=goalsConcededInsideTheBox_drzava, fill=drzava) + geom_bar(stat="identity") + guides(fill=FALSE)

goalsConcededInsideTheBox_drzava<- t8[[2]]
t9 <- cbind(t7, goalsConcededInsideTheBox_drzava)

#zadetki <- recode(t9, `0` = "goalsConcededInsideTheBox_drzava", .default = "goalsConcededOutsideTheBox_drzava")
#ggplot(t9) + aes(x = drzava, fill = zadetki) + geom_bar(position = "fill")

#ggplot(t1, aes(x=cleanSheet)) + geom_histogram() +
#  ggtitle("Pogostost števila naselij") + xlab("Število naselij") + ylab("Število občin")

#ggplot(podatki_v_ap_cs_ita) + aes(x=igralec, y=cleanSheet, color=appearances) + geom_point()
#ggplot(podatki_v_ap_cs_ita) + aes(x=appearances, y=cleanSheet, color=igralec) + geom_point()


# #tortni diagram za ita, za cleansheete 
# bp<- ggplot(podatki_v_ap_cs_ita, aes(x="", y=cleanSheet, fill=igralec))+
#   geom_bar(width = 1, stat = "identity")
# bp
# pie <- bp + coord_polar("y", start=0)
# pie
#za vse
bp<- ggplot(t6, aes(x="", y=penaltySave_drzava, fill=drzava))+
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
  tm_polygons("cleanSheet") + ggtitle("Tekme brez prejetega zadetka, glede na države")

tm_shape(merge(zemljevid,
               t2 %>% group_by(drzava) %>% summarise(penaltySave=sum(penaltySave)),
               by.x="SOVEREIGNT", by.y="drzava")) +
  tm_polygons("penaltySave") + ggtitle("Obranjena enajstmetrovke, glede na države")




