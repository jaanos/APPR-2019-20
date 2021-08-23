# 3. faza: Vizualizacija podatkov
source("lib/libraries.r", encoding="UTF-8")

Place_ <- gather(Tabela_place,key='Leto',value='Place',2:12)  #vse damo v tri stolpce; Drzava,leto,plače (zapis za risanje grafov)
BDP_ <- gather(Tabela_BDP,key='Leto',value='BDP',2:12)
Davki_ <- gather(Tabela_davki,key='Leto',value='Davki',2:12)

graf_place <- ggplot(Place_, aes(x=Leto, y= Place, colour=Drzava, group=Drzava)) +
  geom_line() +  #povežemo podatke iz istih držav
  geom_point() +
  ggtitle("Gibanje neto plač v posameznih državah 2008-2018") +
  ylab("Višina Plače")

graf_BDP <- ggplot(BDP_, aes(x=Leto, y= BDP, colour=Drzava, group=Drzava)) +  #'group Drzava' pove funkciji, da poveže podatke za isto državo z eno črto
  geom_line() +
  geom_point() +
  ggtitle("Gibanje vrednosti BDP v posameznih državah 2008-2018") +
  ylab("Vrednost BDP")

graf_davki <- ggplot(Davki_, aes(x=Leto, y= Davki, colour=Drzava, group=Drzava)) +
  geom_line() +
  geom_point() +
  ggtitle("Gibanje višine davkov v posameznih državah 2008-2018") +
  ylab("Višina davkov")
#tukaj vidimo da višina davkov močno niha, zato grafa ne bom vključil v samo poročilo


#podrobneje si poglejmo podatke za državo, ki ima najvišjo povprečno plačo (Islandija), najnižjo plačo (Bolgarija) in Slovenijo.

#Islandija
Place_Isl <- Place_[Place_$Drzava == 'Iceland', ]
BDP_Isl <- BDP_[BDP_$Drzava == 'Iceland', ] 

graf_Islandija <- ggplot() +
  #plače
  geom_point(data=Place_Isl, aes(x=Leto, y=Place),colour='red') +
  #BDP
  geom_point(data=BDP_Isl, aes(x=Leto, y=BDP),colour='blue') +
  ggtitle("Islandija") +
  xlab("Leto") + ylab("Plače/BDP")

#Bolgarija
Place_Bul <- Place_[Place_$Drzava == 'Bulgaria', ]
BDP_Bul <- BDP_[BDP_$Drzava == 'Bulgaria', ] 

graf_Bolgarija <- ggplot() +
  #plače
  geom_point(data=Place_Bul, aes(x=Leto, y=Place),colour='red') +
  #BDP
  geom_point(data=BDP_Bul, aes(x=Leto, y=BDP),colour='blue') +
  ggtitle("Bolgarija") +
  xlab("Leto") + ylab("Plače/BDP")

#Slovenija
Place_Slo <- Place_[Place_$Drzava == 'Slovenia', ]
BDP_Slo <- BDP_[BDP_$Drzava == 'Slovenia', ] 

graf_Slovenija <- ggplot() +
  #plače
  geom_point(data=Place_Slo, aes(x=Leto, y=Place),colour='red') +
  #BDP
  geom_point(data=BDP_Slo, aes(x=Leto, y=BDP),colour='blue') +
  ggtitle("Slovenija") +
  xlab("Leto") + ylab("Plače/BDP")



data("World")  #iz tmap dobimo zemljevid sveta


zemljevid_plac <- function(){
  Evropa <- World
  place <- Tabela_place %>% select('Drzava', '2018')  #vzamemo samo leto 2018
  stevila <- merge(y = place,x = Evropa, by.x= 'sovereignt', by.y = 'Drzava')  #vzamemo stolpec sovereignt, da se imena ujemajo
  Evropa <- tm_shape(stevila) + tm_polygons('2018') 
  tmap_mode('view')
  return(Evropa)
}
zemljevid_plac()

zemljevid_davkov <- function(){
  Evropa <- World
  davki <- Tabela_davki %>% select('Drzava', '2018')
  stevila <- merge(y = davki,x = Evropa, by.x= 'sovereignt', by.y = 'Drzava')
  Evropa <- tm_shape(stevila) + tm_polygons('2018') 
  tmap_mode('view')
  return(Evropa)
}
zemljevid_davkov()

zemljevid_BDP <- function(){
  Evropa <- World
  BDP <- Tabela_BDP %>% select('Drzava', '2018')
  stevila <- merge(y = BDP,x = Evropa, by.x= 'sovereignt', by.y = 'Drzava')
  Evropa <- tm_shape(stevila) + tm_polygons('2018') 
  tmap_mode('view')
  return(Evropa)
}
zemljevid_BDP()
