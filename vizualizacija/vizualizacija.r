# 3. faza: Vizualizacija podatkov
Odstotek <- (podatki$moski+podatki$zenske) / podatki$rutinsko.dnevno
Aktivne_okuzbe <- cumsum(podatki$moski+podatki$zenske)
Aktivne_okuzbe[15:154] = Aktivne_okuzbe[15:154]- Aktivne_okuzbe[1:140]
CCA_aktivne_okuzbe <- cumsum((podatki$moski+podatki$zenske) / podatki$rutinsko.dnevno * 1000)
CCA_aktivne_okuzbe[15:154] = CCA_aktivne_okuzbe[15:154]- CCA_aktivne_okuzbe[1:140]
#DNEVNO STEVILO TESTIRANJ

dnevno_stevilo_testiranj_linija <- ggplot(rutinsko.testiranje, aes(x=dnevno.stevilo.testiranj,y=datum)) +
  geom_line() + ggtitle("Dnevno število testiranj")


#skupno stevilo okuzenih

stevilo_okuzenih_nekonstantnovskonstantno <- ggplot(podatki %>% group_by(datum) %>%
         summarise(stevilo=sum(moski)+sum(zenske)) %>%
         arrange(datum) %>%
         mutate(skupno.stevilo=cumsum(stevilo)),
       aes(x=datum, y=skupno.stevilo)) +
       geom_line(col="red")+
       geom_line(y=cumsum((podatki$moski+podatki$zenske) / podatki$rutinsko.dnevno * 1000),  col = "blue")+
       ggtitle("Okuženi: konstanto in realno testiranje")

#skupno stevilo testiranj 
stevilo_testiranj <- ggplot(podatki %>% group_by(datum) %>%
                              summarise(stevilo=sum(rutinsko.dnevno)) %>%
                              arrange(datum) %>%
                              mutate(skupno.stevilo=cumsum(stevilo)),
                            aes(x=datum, y=skupno.stevilo)) +
  geom_col()+
  ggtitle("Število testiranj")

#MOŠKI VS ŽENSKE DNEVNO okuženi

dnevno_stevilo_okuzenih_moskivszenske <- ggplot(podatki, aes(x=datum,y=moski)) +
  geom_smooth(fill="blue", colour="blue", size=1)+
  geom_line(color="blue")+geom_line(y=podatki$zenske)+
  geom_smooth(fill="red", colour="red", size=1)+
  ggtitle("Dnevno okuženih moški proti ženskam")



#Dnevno testiranih vikend vs delovni dan

dnevno_stevilo_testiranj_tocke <- ggplot(podatki, aes(x=datum, y=rutinsko.dnevno, col = delovni.dan)) +
  geom_line() + ggtitle("Delovni dan?")


#procent okuzenih
procent_okuzenih_dnevno <- ggplot(podatki, aes(x=datum, y = Odstotek ))+
  geom_line(col="blue")+
  geom_smooth(fill="lightblue")+
  ggtitle("Odstotek dnevno okuženih")

#Število dni okuženih 0-5, 5-10, 10-15....
frekvenca_stevila_okuzb <- hist(podatki$moski+podatki$zenske,,main = "Frekvenca števila okužb", xlab = "število okuženih",border = "yellow" ,col="darkmagenta")

#CCA aktivni

aktivne_okuzbe_realnevsCCA <- ggplot(podatki, aes(x=datum, y = Aktivne_okuzbe ))+
  geom_line(col="blue")+
  geom_line(y=CCA_aktivne_okuzbe)
  ggtitle("Groba ocena števila aktivnih okužb")


