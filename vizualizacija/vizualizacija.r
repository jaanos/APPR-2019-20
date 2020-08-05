# 3. faza: Vizualizacija podatkov

#DNEVNO STEVILO TESTIRANJ

dnevno_stevilo_testiranj_linija <- ggplot(rutinsko.testiranje, aes(x=dnevno.stevilo.testiranj,y=datum)) +
  geom_line() + ggtitle("Dnevno število testiranj")


#skupno stevilo testiranj



#MOŠKI VS ŽENSKE DNEVNO okuženi

dnevno_stevilo_okuzenih_moskivszenske <- ggplot(podatki, aes(x=datum,y=moski)) +
  geom_smooth(fill="blue", colour="blue", size=1)+
  geom_line(color="blue")+geom_line(y=podatki$zenske)+
  geom_smooth(fill="red", colour="red", size=1)+
  ggtitle("Dnevno okuženih moški proti ženskam")


#skupno stevilo moskih vs skupno stevilo zensk




#Dnevno testiranih vikend vs delovni dan

dnevno_stevilo_testiranj_tocke <- ggplot(podatki, aes(x=datum, y=rutinsko.dnevno, col = delovni.dan)) +
  geom_line() + ggtitle("Delovni dan?")


#procent okuzenih
Odstotek <- (podatki$moski+podatki$zenske) / podatki$rutinsko.dnevno
procent_okuzenih_dnevno <- ggplot(podatki, aes(x=datum, y = Odstotek ))+
  geom_line(col="blue")+
  geom_smooth(fill="lightblue")+
  ggtitle("Odstotek dnevno okuženih")

#Število dni okuženih 0-5, 5-10, 10-15....
frekvenca_stevila_okuzb <- hist(podatki$moski+podatki$zenske,,main = "Frekvenca števila okužb", xlab = "število okuženih",border = "yellow" ,col="darkmagenta")
