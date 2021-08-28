# 3. faza: Vizualizacija podatkov

# UVOD: UVRSTITVE LIVERPOOLA V PREMIER LIGI, OBDOBJE JURGENA KLOPPA

sezone_Klopp <- zgodovina_uvrstitev %>% 
  filter(Sezona %in%  c("2016-17","2017-18","2018-19","2019-20","2020-21"))

zgodovina_uvrstitev_graf <- ggplot(data = zgodovina_uvrstitev, aes(x=Sezona, y=Uvrstitev, group=1)) +
  geom_point() + geom_line() + scale_y_reverse(breaks = 1*1:8) +
  theme(axis.text.x = element_text(angle = 90)) + geom_point(data=sezone_Klopp, aes(x=Sezona,y=Uvrstitev),color='red') +
  geom_line(data=sezone_Klopp, aes(x=Sezona,y=Uvrstitev),color='red') + ggtitle("Ligaške uvrstitve Liverpoola v Premier ligi (polne sezone Jurgena Kloppa rdeèe)")
print(zgodovina_uvrstitev_graf)
uvrstitve_Klopp <- sezone_Klopp$Uvrstitev

# ANALIZA USPESNOSTI V LIGI GLEDE NA DODATNE TEKME

vse_tekme <- c(last(rezultati2021$"Odigrane tekme"),last(rezultati1920$"Odigrane tekme"),last(rezultati1819$"Odigrane tekme"),
               last(rezultati1718$"Odigrane tekme"),last(rezultati1617$"Odigrane tekme"))
ligaske_tekme <- c(38,38,38,38,38) #v ligi je 20 mostev, torej vsako sezono po 38 tekem
st_dodatnih_tekem <- vse_tekme - ligaske_tekme #neligaske tekme - to bo x os
tocke <- c(rezultati2021$"Zmage"[1]*3 + rezultati2021$"Remiji"[1],rezultati1920$"Zmage"[1]*3 + rezultati1920$"Remiji"[1],
           rezultati1819$"Zmage"[1]*3 + rezultati1819$"Remiji"[1],rezultati1718$"Zmage"[1]*3 + rezultati1718$"Remiji"[1],
           rezultati1617$"Zmage"[1]*3 + rezultati1617$"Remiji"[1]) #to bo y os

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
  filter(nastopi1920$"Igralno mesto" ==  "GK")

branilci <- nastopi1920 %>% 
  filter(nastopi1920$"Igralno mesto" ==  "DF")

vezisti <- nastopi1920 %>% 
  filter(nastopi1920$"Igralno mesto" ==  "MF")

napadalci <- nastopi1920 %>% 
  filter(nastopi1920$"Igralno mesto" ==  "FW")

prikaz_obremenjenosti <- ggplot(data=nastopi1920, aes(x=Ime, y=nastopi1920$"Skupaj vse tekme")) +
  theme(axis.text.x = element_text(angle = 90)) +
  geom_point(data=vratarji, aes(Ime, vratarji$"Skupaj vse tekme"), color="blue") +
  geom_point(data=branilci, aes(Ime, branilci$"Skupaj vse tekme"), color="red") +
  geom_point(data=vezisti, aes(Ime, vezisti$"Skupaj vse tekme"), color="black") +
  geom_point(data=napadalci, aes(Ime, napadalci$"Skupaj vse tekme"), color="green")
print(prikaz_obremenjenosti)

#izboljšava: tiste z manj kot 5 zaèetimi tekmami vržemo ven
nastopi1920mod <- nastopi1920 %>% filter(nastopi1920$"Skupaj prva postava" >= 5) #mod - modifikacija
nastopi1920mod <- nastopi1920mod[order(nastopi1920mod$"Igralno mesto"), ]
vratarjimod <- nastopi1920mod %>% filter(nastopi1920mod$"Igralno mesto" ==  "GK")
branilcimod <- nastopi1920mod %>% filter(nastopi1920mod$"Igralno mesto" ==  "DF")
vezistimod <- nastopi1920mod %>% filter(nastopi1920mod$"Igralno mesto" ==  "MF")
napadalcimod <- nastopi1920mod %>% filter(nastopi1920mod$"Igralno mesto" ==  "FW")

prikaz_obremenjenosti_mod <- ggplot(data=nastopi1920mod, aes(x=Ime, y=nastopi1920mod$"Skupaj vse tekme")) +
  theme(axis.text.x = element_text(angle = 90)) +
  scale_x_discrete(limits=nastopi1920mod$Ime) +
  geom_point(data=vratarjimod, aes(Ime, vratarjimod$"Skupaj vse tekme"), color="blue") +
  geom_point(data=branilcimod, aes(Ime, branilcimod$"Skupaj vse tekme"), color="red") +
  geom_point(data=vezistimod, aes(Ime, vezistimod$"Skupaj vse tekme"), color="black") +
  geom_point(data=napadalcimod, aes(Ime, napadalcimod$"Skupaj vse tekme"), color="green") +
  geom_point(data=vratarjimod, aes(Ime, vratarjimod$"Skupaj prva postava"), color="blue", pch=2) +
  geom_point(data=branilcimod, aes(Ime, branilcimod$"Skupaj prva postava"), color="red", pch=2) +
  geom_point(data=vezistimod, aes(Ime, vezistimod$"Skupaj prva postava"), color="black", pch=2) +
  geom_point(data=napadalcimod, aes(Ime, napadalcimod$"Skupaj prva postava"), color="green", pch=2) + 
  ggtitle("Pregled nastopov v sezoni 2019-20") + xlab("Igralci") + ylab("Stevilo odigranih tekem") + 
  labs(shape = "Odigrane tekme") + theme(legend.justification = "top", legend.text = "blabla")
print(prikaz_obremenjenosti_mod)

