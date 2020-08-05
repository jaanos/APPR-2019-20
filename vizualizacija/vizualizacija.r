# 3. faza: Vizualizacija podatkov
# 1. Št žensk na dan, Št moških na dan (posebi)
# 2. skupno število na dan
# 3.število testiranj moški ženske posebaj
# 4.število testiranj skupaj

#DNEVNO STEVILO TESTIRANJ

dnevno_stevilo_testiranj_tocke <- ggplot(rutinsko.testiranje, aes(x=datum.prijave,y=dnevno.stevilo.testiranj)) +
         geom_point()+geom_smooth(fill="red", colour="red", size=2)
dnevno_stevilo_testiranj_linija <- ggplot(rutinsko.testiranje, aes(x=dnevno.stevilo.testiranj,y=datum.prijave)) +
  geom_line()



#MOŠKI VS ŽENSKE DNEVNO okuženi

dnevno_stevilo_testiranj_moskivszenske <- ggplot(podatki, aes(x=datum.prijave,y=moski)) +
  geom_smooth(fill="blue", colour="blue", size=1)+
  geom_line(color="blue")+geom_line(y=podatki$zenske)+
  geom_smooth(fill="red", colour="red", size=1)
