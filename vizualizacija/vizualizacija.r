# 3. faza: Vizualizacija podatkov
Odstotek <- (podatki$moski+podatki$zenske) / podatki$rutinsko.dnevno
Aktivne_okuzbe <- cumsum(podatki$moski+podatki$zenske)
Aktivne_okuzbe[15:154] = Aktivne_okuzbe[15:154]- Aktivne_okuzbe[1:140]
CCA_aktivne_okuzbe <- cumsum((podatki$moski+podatki$zenske) / podatki$rutinsko.dnevno * 1000)
CCA_aktivne_okuzbe[15:154] = CCA_aktivne_okuzbe[15:154]- CCA_aktivne_okuzbe[1:140]
US <- podatki_svet %>% filter(iso_code=="USA")
cases_cela_Evropa <- podatki_svet %>% group_by(date )%>% filter(continent== "Europe") %>% summarise(vsota_cela_EV = sum(total_cases_per_million/51,na.rm = TRUE))
#DNEVNO STEVILO TESTIRANJ

dnevno_stevilo_testiranj_linija <- ggplot(rutinsko.testiranje, aes(x=dnevno.stevilo.testiranj,y=datum)) +
  geom_line() + ggtitle("Dnevno število testiranj")


#skupno stevilo okuzenih

stevilo_okuzenih_nekonstantnovskonstantno <- ggplot(podatki %>% group_by(datum) %>%
         summarise(stevilo=sum(moski)+sum(zenske),na.rm = TRUE) %>%
         arrange(datum) %>%
         mutate(skupno.stevilo=cumsum(stevilo)),
       aes(x=datum, y=skupno.stevilo)) +
       geom_line(col="red")+
       geom_line(y=cumsum((podatki$moski+podatki$zenske) / podatki$rutinsko.dnevno * 1000),  col = "blue")+
       ggtitle("Okuženi: konstanto in realno testiranje")

#skupno stevilo testiranj 
stevilo_testiranj <- ggplot(podatki %>% group_by(datum) %>%
                              summarise(stevilo=sum(rutinsko.dnevno),na.rm = TRUE) %>%
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


  
  #Celoten svet cases/million
  cases_cel_svet <- podatki_svet %>% group_by(date)%>% summarise(vsota_cel_svet = sum(total_cases_per_million/212,na.rm = TRUE))
  stevilo_primerov_na_svetu_na_million <- ggplot(cases_cel_svet, aes(x=date,y=vsota_cel_svet)) + geom_line()+
    geom_smooth(fill="green", colour="green", size=1)+
    ggtitle("stevilo_primerov na svetu na million prebivalcev")
  
  #Europa (51 drzav)
  stevilo_primerov_v_Evropi_na_million <- ggplot(cases_cela_Evropa, aes(x=date,y=vsota_cela_EV)) + 
    geom_line()+
    geom_smooth(fill="red", colour="red", size=1)+
    ggtitle("stevilo primerov v Evropi na million prebivalcev")
  
  #USA
  stevilo_primerov_v_Zdruzenih_drzavah_Amerike_na_million <- ggplot(US, aes(x=date, y= total_cases_per_million))+
    geom_line()+
    geom_smooth(fill="yellow", colour="yellow", size=1)+
    ggtitle("stevilo primerov v Zdruzenih drzavah Amerike na million prebivalcev")
  
  
  #USA vs Europe
  USAvsEU <- ggplot()+
    geom_line( data = cases_cela_Evropa,aes(x=date,y=vsota_cela_EV), col= "red ") +
    geom_smooth(fill="red", colour="red", size=1)+
    geom_line(data = US,aes(x=date, y= total_cases_per_million), col= "blue")+
    geom_smooth(fill="blue", colour="blue", size=1)+
    ggtitle("Primerjava gostote okuženosti USA proti celotni Evropi")
  
  
  #CCA AKTIVNI SVET tole je narobe
  okuzeni_svet <- podatki_svet %>% group_by(date) %>% summarise(vsi_okuzeni = sum(total_cases),na.rm = TRUE)
  CCA_okuzeni_svet <- podatki_svet %>% group_by(date) %>% summarise(vsi_okuzeni = sum(total_cases,na.rm = TRUE))
  CCA_okuzeni_svet[15:219,2]<- CCA_okuzeni_svet[15:219,2] - CCA_okuzeni_svet[1:205,2]
  Vsi_okuzeni_proti_aktivni <- ggplot()+
    geom_line(data= CCA_okuzeni_svet, aes(x=date, y=vsi_okuzeni), col="purple")+
    geom_line(data= okuzeni_svet, aes(x=date, y=vsi_okuzeni), col="red")+
    ggtitle("Primerjava aktivnih okuženih in vseh okuženih")
  
  
  
  
  ################################################################
  #Zemljevid
  data("World")
  
  Zemljevid_cases_per_million <- tm_shape(merge(World, podatki_svet %>% filter(date == "2020-05-05"), by.x="iso_a3", by.y="iso_code")) +
    
    tm_polygons("total_cases_per_million")  
  
  
  
  
  
  
  
  
  
  
  
  
  