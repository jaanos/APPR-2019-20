# 4. faza: Analiza podatkov

# MINUTE BRITANSKIH in AKADEMIJSKIH IGRALCEV po sezonah

#LFC Academy po sezonah
akademija2021 <- igralci2021 %>% filter(Izvor == "LFC Academy")
akademija1920 <- igralci1920 %>% filter(Izvor == "LFC Academy")
akademija1819 <- igralci1819 %>% filter(Izvor == "LFC Academy")
akademija1718 <- igralci1718 %>% filter(Izvor == "LFC Academy")
akademija1617 <- igralci1617 %>% filter(Izvor == "LFC Academy")

akademija2021 <- merge(akademija2021,nastopi2021,by='Igralec')
akademija1920 <- merge(akademija1920,nastopi1920,by='Igralec')
akademija1819 <- merge(akademija1819,nastopi1819,by='Igralec')
akademija1718 <- merge(akademija1718,nastopi1718,by='Igralec')
akademija1617 <- merge(akademija1617,nastopi1617,by='Igralec')

#Koliko igralcev iz domace akademije je v povprecju nastopilo na tekmo
koefAcademy <- c(sum(akademija1617$'Skupaj vse tekme')/last(rezultati1617$`Odigrane tekme`),
                 sum(akademija1718$'Skupaj vse tekme')/last(rezultati1718$`Odigrane tekme`),
                 sum(akademija1819$'Skupaj vse tekme')/last(rezultati1819$`Odigrane tekme`),
                 sum(akademija1920$'Skupaj vse tekme')/last(rezultati1920$`Odigrane tekme`),
                 sum(akademija2021$'Skupaj vse tekme')/last(rezultati2021$`Odigrane tekme`))

#KOliko igralcev iz domace akademije je v povprecju zacelo tekmo
koefAcademy11 <- c(sum(akademija1617$'Skupaj prva postava')/last(rezultati1617$`Odigrane tekme`),
                   sum(akademija1718$'Skupaj prva postava')/last(rezultati1718$`Odigrane tekme`),
                   sum(akademija1819$'Skupaj prva postava')/last(rezultati1819$`Odigrane tekme`),
                   sum(akademija1920$'Skupaj prva postava')/last(rezultati1920$`Odigrane tekme`),
                   sum(akademija2021$'Skupaj prva postava')/last(rezultati2021$`Odigrane tekme`))

#HGN igralci po sezonah (homegrown) - po brexitu so tudi Irci HGN, zato so vključeni
hgn2021 <- igralci2021 %>% filter(Narodnost %in% c("United Kingdom", "Ireland", "Republic of Ireland"))
hgn1920 <- igralci1920 %>% filter(Narodnost %in% c("United Kingdom", "Ireland", "Republic of Ireland"))
hgn1819 <- igralci1819 %>% filter(Narodnost %in% c("United Kingdom", "Ireland", "Republic of Ireland"))
hgn1718 <- igralci1718 %>% filter(Narodnost %in% c("United Kingdom", "Ireland", "Republic of Ireland"))
hgn1617 <- igralci1617 %>% filter(Narodnost %in% c("United Kingdom", "Ireland", "Republic of Ireland"))

hgn2021 <- merge(hgn2021,nastopi2021,by='Igralec')
hgn1920 <- merge(hgn1920,nastopi1920,by='Igralec')
hgn1819 <- merge(hgn1819,nastopi1819,by='Igralec')
hgn1718 <- merge(hgn1718,nastopi1718,by='Igralec')
hgn1617 <- merge(hgn1617,nastopi1617,by='Igralec')

#Koliko homegrown igralcev je v povprecju igralo na tekmo
koefHGN <- c(sum(hgn1617$'Skupaj vse tekme')/last(rezultati1617$`Odigrane tekme`),
             sum(hgn1718$'Skupaj vse tekme')/last(rezultati1718$`Odigrane tekme`),
             sum(hgn1819$'Skupaj vse tekme')/last(rezultati1819$`Odigrane tekme`),
             sum(hgn1920$'Skupaj vse tekme')/last(rezultati1920$`Odigrane tekme`),
             sum(hgn2021$'Skupaj vse tekme')/last(rezultati2021$`Odigrane tekme`))

#Koliko homegrown igralcev je bilo v povprecju v prvih 11 
koefHGN11 <- c(sum(hgn1617$'Skupaj prva postava')/last(rezultati1617$`Odigrane tekme`),
               sum(hgn1718$'Skupaj prva postava')/last(rezultati1718$`Odigrane tekme`),
               sum(hgn1819$'Skupaj prva postava')/last(rezultati1819$`Odigrane tekme`),
               sum(hgn1920$'Skupaj prva postava')/last(rezultati1920$`Odigrane tekme`),
               sum(hgn2021$'Skupaj prva postava')/last(rezultati2021$`Odigrane tekme`))

tabela_napredna_analiza1 <- data.frame(sezone_Klopp$Sezona,koefAcademy,koefAcademy11,koefHGN,koefHGN11)

napredna_analiza_graf1 <- ggplot(data = tabela_napredna_analiza1, aes(x=sezone_Klopp.Sezona, y=koefAcademy, group=1)) +
  geom_point(col = "red") + geom_line(col = "red") +
  geom_point(data = tabela_napredna_analiza1, aes(x=sezone_Klopp.Sezona, y=koefAcademy11,group=1),col="green") + 
  geom_line(data = tabela_napredna_analiza1, aes(x=sezone_Klopp.Sezona, y=koefAcademy11,group=1),col="green") +
  geom_point(data = tabela_napredna_analiza1, aes(x=sezone_Klopp.Sezona, y=koefHGN,group=1)) + 
  geom_line(data = tabela_napredna_analiza1, aes(x=sezone_Klopp.Sezona, y=koefHGN,group=1)) +
  geom_point(data = tabela_napredna_analiza1, aes(x=sezone_Klopp.Sezona, y=koefHGN11,group=1),col="blue") + 
  geom_line(data = tabela_napredna_analiza1, aes(x=sezone_Klopp.Sezona, y=koefHGN11,group=1),col="blue") +
  ggtitle("Analiza doma vzgojenih in britanskih ter irskih (HGN) igralcev") +
  labs(x = "Sezona", y = "Koeficient")
print(napredna_analiza_graf1)

#DODATEK: priloznosti academy igralcem na pokalnih tekmah
pokali2021 <- sum(akademija2021$'FA pokal - vse tekme') + sum(akademija2021$'EFL pokal - vse tekme')
pokali1920 <- sum(akademija1920$'FA pokal - vse tekme') + sum(akademija1920$'EFL pokal - vse tekme')
pokali1819 <- sum(akademija1819$'FA pokal - vse tekme') + sum(akademija1819$'EFL pokal - vse tekme')
pokali1718 <- sum(akademija1718$'FA pokal - vse tekme') + sum(akademija1718$'EFL pokal - vse tekme')
pokali1617 <- sum(akademija1617$'FA pokal - vse tekme') + sum(akademija1617$'EFL pokal - vse tekme')
pokali <- c(pokali1617,pokali1718,pokali1819,pokali1920,pokali2021)

pokali11_2021 <- sum(akademija2021$'FA pokal - prva postava') + sum(akademija2021$'EFL pokal - prva postava')
pokali11_1920 <- sum(akademija1920$'FA pokal - prva postava') + sum(akademija1920$'EFL pokal - prva postava')
pokali11_1819 <- sum(akademija1819$'FA pokal - prva postava') + sum(akademija1819$'EFL pokal - prva postava')
pokali11_1718 <- sum(akademija1718$'FA pokal - prva postava') + sum(akademija1718$'EFL pokal - prva postava')
pokali11_1617 <- sum(akademija1617$'FA pokal - prva postava') + sum(akademija1617$'EFL pokal - prva postava')
pokali11 <- c(pokali11_1617,pokali11_1718,pokali11_1819,pokali11_1920,pokali11_2021)

vse_pokalne <- c(rezultati1617$'Odigrane tekme'[2]+rezultati1617$'Odigrane tekme'[3],
                 rezultati1718$'Odigrane tekme'[2]+rezultati1718$'Odigrane tekme'[3],
                 rezultati1819$'Odigrane tekme'[2]+rezultati1819$'Odigrane tekme'[3],
                 rezultati1920$'Odigrane tekme'[2]+rezultati1920$'Odigrane tekme'[3],
                 rezultati2021$'Odigrane tekme'[2]+rezultati2021$'Odigrane tekme'[3])

dodatek_pokali <- data.frame(sezone_Klopp$Sezona,pokali/vse_pokalne,pokali11/vse_pokalne)

dodatek_pokali_graf <- ggplot(data = tabela_napredna_analiza1, aes(x=sezone_Klopp.Sezona, y=koefAcademy, group=1)) +
  geom_point(col = "red") + geom_line(col = "red") +
  geom_point(data =dodatek_pokali, aes(x=sezone_Klopp.Sezona, y=pokali.vse_pokalne,group=1),col="red") + 
  geom_line(data =dodatek_pokali, aes(x=sezone_Klopp.Sezona, y=pokali.vse_pokalne,group=1),lty=2,col="red") +
  geom_point(data = tabela_napredna_analiza1, aes(x=sezone_Klopp.Sezona, y=koefAcademy11,group=1),col="green") + 
  geom_line(data = tabela_napredna_analiza1, aes(x=sezone_Klopp.Sezona, y=koefAcademy11,group=1),col="green") +
  geom_point(data =dodatek_pokali, aes(x=sezone_Klopp.Sezona, y=pokali11.vse_pokalne,group=1),col="green") + 
  geom_line(data =dodatek_pokali, aes(x=sezone_Klopp.Sezona, y=pokali11.vse_pokalne,group=1),lty=2,col="green") +
  geom_point(data = tabela_napredna_analiza1, aes(x=sezone_Klopp.Sezona, y=koefHGN,group=1)) + 
  geom_line(data = tabela_napredna_analiza1, aes(x=sezone_Klopp.Sezona, y=koefHGN,group=1)) +
  geom_point(data = tabela_napredna_analiza1, aes(x=sezone_Klopp.Sezona, y=koefHGN11,group=1),col="blue") + 
  geom_line(data = tabela_napredna_analiza1, aes(x=sezone_Klopp.Sezona, y=koefHGN11,group=1),col="blue") +
  ggtitle("Analiza doma vzgojenih in britanskih ter irskih (HGN) igralcev") +
  labs(x = "Sezona", y = "Koeficient")
print(dodatek_pokali_graf)

#napredna analiza 2 - starost po sezonah in projekcija
igralci2021$Igralec[5] <- "Virgil van Dijk"
igralci2021$Igralec[17] <- "Georginio Wijnaldum"
igralci2021$Igralec[19] <- "James Milner"
igralci2021$Igralec[21] <- "Jordan Henderson"

igralci1819$Igralec[5] <- "Virgil van Dijk"
igralci1819$Igralec[14] <- "Georginio Wijnaldum"
igralci1819$Igralec[15] <- "James Milner"
igralci1819$Igralec[17] <- "Jordan Henderson"

igralci1718$Igralec[15] <- "James Milner"
igralci1718$Igralec[17] <- "Jordan Henderson"
igralci1617$Igralec[6] <- "James Milner"
igralci1617$Igralec[15] <- "Jordan Henderson"

tabela_napredna_analiza2_2021 <- merge(igralci2021,nastopi2021,by='Igralec')
tabela_napredna_analiza2_1920 <- merge(igralci1920,nastopi1920,by='Igralec')
tabela_napredna_analiza2_1819 <- merge(igralci1819,nastopi1819,by='Igralec')
tabela_napredna_analiza2_1718 <- merge(igralci1718,nastopi1718,by='Igralec')
tabela_napredna_analiza2_1617 <- merge(igralci1617,nastopi1617,by='Igralec')

vektor_napredna_analiza2 <- c(sum(tabela_napredna_analiza2_1617$Starost*tabela_napredna_analiza2_1617$'PL - prva postava'),
                              sum(as.numeric(tabela_napredna_analiza2_1718$Starost)*tabela_napredna_analiza2_1718$'PL - prva postava'),
                              sum(tabela_napredna_analiza2_1819$Starost*tabela_napredna_analiza2_1819$'PL - prva postava' + 26), #napaka v wiki, vse tekme se
                              #sestejejo v 417 - rocno popravimo
                              sum(tabela_napredna_analiza2_1920$Starost*tabela_napredna_analiza2_1920$'PL - prva postava'),
                              sum(as.numeric(tabela_napredna_analiza2_2021$Starost)*tabela_napredna_analiza2_2021$'PL - prva postava'))
vektor_napredna_analiza2 <- vektor_napredna_analiza2/418 #418 = 38*11 - vse prve enajsterice

#starost na dan 23.5. tekoce sezone
tabela_napredna_analiza2 <- data.frame(sezone_Klopp$Sezona, vektor_napredna_analiza2)
napredna_analiza_graf2 <- ggplot(data=tabela_napredna_analiza2, aes(x=sezone_Klopp$Sezona, y=vektor_napredna_analiza2, group=1)) +
  geom_point() + geom_line() + geom_smooth(method="lm", formula=vektor_napredna_analiza2 ~ c(1:5)) + 
  ggtitle("Povprecna starost na ligaskih tekmah") +
  labs(x = "Sezona", y = "Starost")
print(napredna_analiza_graf2)
