# 3. faza: Vizualizacija podatkov
# 1. Št žensk na dan, Št moških na dan (posebi)
# 2. skupno število na dan
# 3.število testiranj moški ženske posebaj
# 4.število testiranj skupaj

#DNEVNO STEVILO TESTIRANJ
#Kako bi lahko testiranja čez vikend obarval z drugo barvo?
dnevno_stevilo_testiranj_tocke <- ggplot(rutinsko.testiranje, aes(x=datum.prijave,y=dnevno.stevilo.testiranj)) +
         geom_point()
dnevno_stevilo_testiranj_linija <- ggplot(rutinsko.testiranje, aes(x=dnevno.stevilo.testiranj,y=datum.prijave)) +
  geom_line()
#MOŠKI DNEVNO TESTIRANJE
dnevno_stevilo_testiranj_moski <- ggplot(podatki, aes(x=datum.prijave,y=moski)) +
  geom_line(color="blue")
#ŽENSKE DNEVNO TESTIRANJE
dnevno_stevilo_testiranj_zenske <-ggplot(podatki, aes(x=datum.prijave,y=zenske)) +
  geom_line(color="red")

ggarrange(dnevno_stevilo_testiranj_moski,dnevno_stevilo_testiranj_zenske)