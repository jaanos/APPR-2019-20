# 3. faza: Vizualizacija podatkov

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source("../lib/libraries.r", encoding="UTF-8")

# UVOD: UVRSTITVE LIVERPOOLA V PREMIER LIGI, OBDOBJE JURGENA KLOPPA

sezone_Klopp <- zgodovina_uvrstitev %>% 
  filter(Sezona %in%  c("2016-17","2017-18","2018-19","2019-20","2020-21"))

zgodovina_uvrstitev_graf <- ggplot(data = zgodovina_uvrstitev, aes(x=Sezona, y=Uvrstitev, group=1)) +
  geom_point() + geom_line() + scale_y_reverse(breaks = 1*1:8) +
  theme(axis.text.x = element_text(angle = 90)) + geom_point(data=sezone_Klopp, aes(x=Sezona,y=Uvrstitev),color='red') +
  geom_line(data=sezone_Klopp, aes(x=Sezona,y=Uvrstitev),color='red') + ggtitle("Ligaske uvrstitve Liverpoola v Premier ligi (polne sezone Jurgena Kloppa rdece)")
print(zgodovina_uvrstitev_graf)
uvrstitve_Klopp <- sezone_Klopp$Uvrstitev

# ANALIZA USPESNOSTI V LIGI GLEDE NA DODATNE TEKME

vse_tekme <- c(last(rezultati2021$`Odigrane tekme`),last(rezultati1920$`Odigrane tekme`),last(rezultati1819$`Odigrane tekme`),
               last(rezultati1718$`Odigrane tekme`),last(rezultati1617$`Odigrane tekme`))
ligaske_tekme <- c(38,38,38,38,38) #v ligi je 20 mostev, torej vsako sezono po 38 tekem
st_dodatnih_tekem <- vse_tekme - ligaske_tekme #neligaske tekme - to bo x os
tocke <- c(rezultati2021$Zmage[1]*3 + rezultati2021$Remiji[1],rezultati1920$Zmage[1]*3 + rezultati1920$Remiji[1],
           rezultati1819$Zmage[1]*3 + rezultati1819$Remiji[1],rezultati1718$Zmage[1]*3 + rezultati1718$Remiji[1],
           rezultati1617$Zmage[1]*3 + rezultati1617$Remiji[1]) #to bo y os

plot(st_dodatnih_tekem,tocke, ,xlim = c(8,22), xlab = "Neligaske tekme", ylab = "tocke v ligi", main = "Uspesnost v ligi glede na dodatne tekme")
points(st_dodatnih_tekem, tocke, col="red", pch = 16)
grid()
for (i in 1:length(ligaske_tekme))
  {
  text(st_dodatnih_tekem[i]+0.5,tocke[i]+0.5, uvrstitve_Klopp[i])
  text(st_dodatnih_tekem[i]+0.70,tocke[i]-0.15, ".,")
  text(st_dodatnih_tekem[i]+1.55,tocke[i]+0.5, sezone_Klopp$Sezona[i])
}

# OBREMENJOST POZICIJ
vratarji <- nastopi1920 %>% 
  filter(nastopi1920$`Igralno mesto` ==  "GK")

branilci <- nastopi1920 %>% 
  filter(nastopi1920$`Igralno mesto` ==  "DF")

vezisti <- nastopi1920 %>% 
  filter(nastopi1920$`Igralno mesto` ==  "MF")

napadalci <- nastopi1920 %>% 
  filter(nastopi1920$`Igralno mesto` ==  "FW")

prikaz_obremenjenosti <- ggplot(data=nastopi1920, aes(x=Igralec, y=nastopi1920$"Skupaj vse tekme")) +
  theme(axis.text.x = element_text(angle = 90)) +
  geom_point(data=vratarji, aes(Igralec, vratarji$`Skupaj vse tekme`), color="blue") +
  geom_point(data=branilci, aes(Igralec, branilci$`Skupaj vse tekme`), color="red") +
  geom_point(data=vezisti, aes(Igralec, vezisti$`Skupaj vse tekme`), color="black") +
  geom_point(data=napadalci, aes(Igralec, napadalci$`Skupaj vse tekme`), color="green")
print(prikaz_obremenjenosti)

#izboljsava: tiste z manj kot 5 zacetimi tekmami vrzemo ven
nastopi1920mod <- nastopi1920 %>% filter(nastopi1920$`Skupaj prva postava` >= 5) #mod - modifikacija
nastopi1920mod <- nastopi1920mod[order(nastopi1920mod$`Igralno mesto`), ]
vratarjimod <- nastopi1920mod %>% filter(nastopi1920mod$`Igralno mesto` ==  "GK")
branilcimod <- nastopi1920mod %>% filter(nastopi1920mod$`Igralno mesto` ==  "DF")
vezistimod <- nastopi1920mod %>% filter(nastopi1920mod$`Igralno mesto` ==  "MF")
napadalcimod <- nastopi1920mod %>% filter(nastopi1920mod$`Igralno mesto` ==  "FW")

prikaz_obremenjenosti_mod <- ggplot(data=nastopi1920mod, aes(x=Igralec, y=nastopi1920mod$`Skupaj vse tekme`)) +
  theme(axis.text.x = element_text(angle = 90)) +
  scale_x_discrete(limits=nastopi1920mod$Igralec) +
  geom_point(data=vratarjimod, aes(Igralec, vratarjimod$`Skupaj vse tekme`), color="blue") +
  geom_point(data=branilcimod, aes(Igralec, branilcimod$`Skupaj vse tekme`), color="red") +
  geom_point(data=vezistimod, aes(Igralec, vezistimod$`Skupaj vse tekme`), color="black") +
  geom_point(data=napadalcimod, aes(Igralec, napadalcimod$`Skupaj vse tekme`), color="green") +
  geom_point(data=vratarjimod, aes(Igralec, vratarjimod$`Skupaj prva postava`), color="blue", pch=2) +
  geom_point(data=branilcimod, aes(Igralec, branilcimod$`Skupaj prva postava`), color="red", pch=2) +
  geom_point(data=vezistimod, aes(Igralec, vezistimod$`Skupaj prva postava`), color="black", pch=2) +
  geom_point(data=napadalcimod, aes(Igralec, napadalcimod$`Skupaj prva postava`), color="green", pch=2) + 
  ggtitle("Pregled nastopov v sezoni 2019-20") + xlab("Igralci") + ylab("Stevilo odigranih tekem")
print(prikaz_obremenjenosti_mod)


#####################################
## ZEMLJEVID ZASTOPANOSTI DRZAV V SAMPIONSKI SEZONI 2019/20

igralci1920$Igralec[6] <- "Virgil van Dijk"
igralci1920$Igralec[17] <- "Georginio Wijnaldum"
igralci1920$Igralec[18] <- "James Milner"
igralci1920$Igralec[20] <- "Jordan Henderson"
igralci1920$Narodnost[4] <- "Ireland"

uk <- function(niz){
  if (niz == "Scotland" || niz == "Wales" || niz == "England" || niz == "Northern Ireland"){
    niz = "United Kingdom"
  }
  return(niz)
}
igralci2021$Narodnost <- sapply(igralci2021$Narodnost,uk)
igralci1920$Narodnost <- sapply(igralci1920$Narodnost,uk)
igralci1819$Narodnost <- sapply(igralci1819$Narodnost,uk)
igralci1718$Narodnost <- sapply(igralci1718$Narodnost,uk)
igralci1617$Narodnost <- sapply(igralci1617$Narodnost,uk)

#data("World")
#igralci1920$igralcidrzave <- igralci1920$Narodnost
#Pri vsaki drzavi naredim vektor igralcev - narediti s funkcijo:, ki preisce 
#drzave v tabeli igralci1920 in doda v nov stolpec igralce iste drzave. 
#sleparim, ker take funkcije ne znam narediti - naredim rocno samo za brazilijo
#NE DELA: tmp3 <- aggregate(label~igralci1920$Narodnost, sample, paste, collapse=" ")
#igralci1920$igralcidrzave[1] <- "Alisson, Fabinho, Roberto Firmino"
#igralci1920$igralcidrzave[16] <- "Alisson, Fabinho, Roberto Firmino"
#igralci1920$igralcidrzave[26] <- "Alisson, Fabinho, Roberto Firmino"
#tmp1 <- igralci1920 %>% select('Narodnost', 'igralcidrzave')
#tmp2 <- merge(y = tmp1,x = World, by.x= 'sovereignt', by.y = 'Narodnost')

#data("World")
#tmap_mode('view')
#zemljevid_1920 <- function(){
#  World <- tm_shape(tmp2) + tm_fill('sovereignt', popup.vars="igralcidrzave", legend.show=FALSE)
  #v tm_shape vzamemo tmp2, da obarva le izbrane drzave
#  return(World)
#}
#data("World")
#tmap_mode('view')
#zemljevid_1920 <- function(){
#  tmp1 <- igralci1920 %>% select('Narodnost', 'Igralec')
#  tmp2 <- merge(y = tmp1,x = World, by.x= 'sovereignt', by.y = 'Narodnost')
#  World <- tm_shape(tmp2) + tm_fill('sovereignt', popup.vars=c("Igralec"), legend.show=FALSE)
  #v tm_shape vzamemo tmp2, da obarva le izbrane drzave
#  return(World)
#}
#print(zemljevid_1920())
########################################

# KARTONI - PRIMERJAVA LIVERPOOL IN LIGA PO SEZONAH
kartoni_sezona <- c(sezone_Klopp$Sezona)
rumeni_liverpool <- c(last(kartoni1617$Rumeni),last(kartoni1718$Rumeni),last(kartoni1819$Rumeni),
                last(kartoni1920$Rumeni),last(kartoni2021$Rumeni))
rdeci_liverpool <- c(last(kartoni1617$Rdeci),last(kartoni1718$Rdeci),last(kartoni1819$Rdeci),
                      last(kartoni1920$Rdeci),last(kartoni2021$Rdeci))
rumeni_liga <- c(sum(liga_kartoni1617$yellow_cards)/20,sum(liga_kartoni1718$yellow_cards)/20,
                 sum(liga_kartoni1819$yellow_cards)/20,sum(liga_kartoni1920$yellow_cards)/20,
                 sum(liga_kartoni2021$yellow_cards)/20)
rdeci_liga <- c(sum(liga_kartoni1617$red_cards)/20,sum(liga_kartoni1718$red_cards)/20,
                 sum(liga_kartoni1819$red_cards)/20,sum(liga_kartoni1920$red_cards)/20,
                 sum(liga_kartoni2021$red_cards)/20)
razpredelnica_kartoni <- data.frame(kartoni_sezona,rumeni_liverpool, rdeci_liverpool,rumeni_liga,rdeci_liga)
kartoni_graf <- ggplot(data = razpredelnica_kartoni, aes(x=kartoni_sezona, y=rumeni_liverpool,group=1)) +
  geom_point(color="gold1") + geom_line(color="gold1") + geom_point(aes(x=kartoni_sezona, y=rdeci_liverpool),color="red") + 
  geom_line(aes(x=kartoni_sezona, y=rdeci_liverpool),color="red") + 
  geom_point(aes(x=kartoni_sezona, y=rumeni_liga),color="goldenrod4") +
  geom_line(aes(x=kartoni_sezona, y=rumeni_liga),color="goldenrod4") + 
  geom_point(aes(x=kartoni_sezona, y=rdeci_liga),color="darkorchid4") + 
  geom_line(aes(x=kartoni_sezona, y=rdeci_liga),color="darkorchid4") + 
  ggtitle("Pregled kartonov po sezonah") + labs(x = "Sezona", y = "Stevilo kartonov")
print(kartoni_graf)