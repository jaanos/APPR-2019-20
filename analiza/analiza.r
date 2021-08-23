# 4. faza: Analiza podatkov
source("lib/libraries.r", encoding="UTF-8")

#Grafi za leto 2018
Tabela_skupna$Drzava <- factor(Tabela_skupna$Drzava,levels=Tabela_skupna %>% arrange(Placa) %>% .$Drzava,
                              ordered = TRUE)  #razvrsti države glede na višino plače

#graf_starost <- ggplot(Tabela_skupna %>% select(Drzava, Placa), aes(x=Drzava, y=Placa))+
#  geom_point()

#graf povprečne starosti v odvisnosti od višine povprečne plače

graf_starost <- ggplot(Tabela_skupna, aes(x = Placa, y = Povprecna.starost)) +
  geom_point() +
  geom_smooth(method = loess) +  #priredi krivuljo, ki se najbolje prilega podatkom
  xlab("Višina plače") + ylab("Povprečna starost")

#graf življenskih stroškov v odvisnosti od povprečne plače

graf_stroski <- ggplot(Tabela_skupna, aes(x = Placa, y = Zivljenski.stroski)) +
  geom_point() +
  geom_smooth(method = loess) +
  xlab("Višina plače") + ylab("Indeks življenskih stroškov")

#graf stopnje kriminala v odvisnosti od povprečne plače

graf_osamosvojitev <- ggplot(Tabela_skupna, aes(x = Placa, y = Leto.osamosvojitve)) +
  geom_point() +
  geom_smooth(method = loess) +  #to tu ni možno ker so podatki preveč razpršeni
  xlab("Višina plače") + ylab("Leto osamosvojitve")

#graf vrednosti BDP posamezne države v odvisnosti od povprečne plače

graf_BDP <- ggplot(Tabela_skupna, aes(x = Placa, y = BDP)) +
  geom_point() +
  geom_smooth(method = loess) +
  xlab("Višina plače") + ylab("BDP")

#graf velikosti držav v odvisnosti od povprečne plače

graf_povrsina <- ggplot(Tabela_skupna, aes(x = Placa, y = Povrsina)) +
  geom_point() +
  geom_smooth(method = loess) +
  xlab("Višina plače") + ylab("Površina v km^2")

#graf obdavčitve v odvisnosti od povprečne plače

graf_davki <- ggplot(Tabela_skupna, aes(x = Placa, y = Davki)) +
  geom_point() +
  geom_smooth(method = loess) +
  xlab("Višina plače") + ylab("Obdavčitev v %")

graf_kriminal <- ggplot(Tabela_skupna, aes(x = Placa, y = Stopnja.kriminala)) +
  geom_point() +
  geom_smooth(method = loess) +
  xlab("Višina plače") + ylab("Stopnja kriminala")




