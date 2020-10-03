# 4. faza: Analiza podatkov

############################################################################################
#CCA aktivni Slovenija + napoved s pomocjo linearne regresije
akt <- data.frame("Aktivne_okuzbe"=c(Aktivne_okuzbe,CCA_aktivne_okuzbe) ,
                  "Realno stanje ali stanje pri konstantem testiranju"=
                    c(rep("realno testiranje",length(Aktivne_okuzbe)),
                      rep("konstanto testiranje",length(CCA_aktivne_okuzbe))),
                  "datum"=c(podatki$datum,podatki$datum))
aktivne_okuzbe_realnevsCCA <- ggplot(akt, aes(x=datum, y = Aktivne_okuzbe,col=Realno.stanje.ali.stanje.pri.konstantem.testiranju))+
  geom_line()+
  ylab("Aktivne okužbe")+
ggtitle("Groba ocena števila aktivnih okužb v Sloveniji")

#CCA AKTIVNI SVET + napoved s pomocjo linearne regresije
okuzeni_svet <- podatki_svet %>% group_by(date) %>% summarise(vsi_okuzeni = sum(total_cases),na.rm = TRUE)
CCA_okuzeni_svet <- podatki_svet %>% group_by(date) %>% summarise(vsi_okuzeni = sum(total_cases,na.rm = TRUE))
CCA_okuzeni_svet[15:219,2]<- CCA_okuzeni_svet[15:219,2] - CCA_okuzeni_svet[1:205,2]

#+ stat_smooth(method = "lm", col = "red")

Vsi_okuzeni_proti_aktivni <- ggplot()+
  geom_line(data= CCA_okuzeni_svet, aes(x=date, y=vsi_okuzeni/10^3), col="purple")+
  geom_line(data= okuzeni_svet, aes(x=date, y=vsi_okuzeni/10^3), col="red")+
  ylab("Okuženi v tisočih")+
  ggtitle("Primerjava aktivnih okuženih in vseh okuženih")

#############################################################################################
death_rate_life_expectancy <-podatki_svet %>%
  mutate(death_rate = total_deaths_per_million/total_cases_per_million) %>%
  select(location,continent,death_rate,life_expectancy,extreme_poverty) %>%
  group_by(location,continent) %>% 
  summarise(najvisji_death_rate = max(death_rate),life_expectancy = max(life_expectancy), revscina = max(extreme_poverty))

Death_rate_life_expectancy <- ggplot(death_rate_life_expectancy,aes(x=life_expectancy,y=najvisji_death_rate,col=continent))+
  geom_point()+
  ylab("Death rate")+
  ggtitle("Death rate glede na pricakovano zivljensko dobo") 

Death_rate_poverty <- ggplot(death_rate_life_expectancy,aes(x=revscina,y=najvisji_death_rate,col=continent))+
  geom_point()+
  ylab("Death rate")+
  ggtitle("Death rate glede na revscino") 

#########################################################################################################

dnevi.v.tednu <- as.Date(0:6, origin="1900-01-01") %>% weekdays()

svetovno_testiranje_po_dnevih <-podatki_svet %>%
  
  mutate(dan_v_tednu=weekdays(date) %>% factor(levels=dnevi.v.tednu, ordered=TRUE)) %>%
  
  group_by(dan_v_tednu, continent) %>%
  
  summarise(stevilo_testov_po_dnevih=sum(new_tests, na.rm=TRUE)) %>%
  
  drop_na(continent)

svetovno_testiranje_po_dnevih <- merge(svetovno_testiranje_po_dnevih, population_by_continent, by="continent")
test_po_dnevih_svet <- ggplot(svetovno_testiranje_po_dnevih,
       aes(x=as.numeric(dan_v_tednu), y=stevilo_testov_po_dnevih, color=continent,size = population_continent)) +
  geom_line() +
  scale_x_continuous(breaks=1:7, labels=dnevi.v.tednu)+
  xlab("")+
  ylab("Skupno število testov")+
  ggtitle("Primerjava skupnega števila testov po dnevih glede na kontinent") 
##########################################
#zemljevid % vseh pozitivnih testov
testi_po_drzavah = podatki_svet %>% group_by(iso_code,location) %>% summarise(vsi_testi = sum(new_tests,na.rm=TRUE))
okuzeni_po_drzavah = podatki_svet %>% group_by(iso_code,location) %>% summarise(vsi_okuzeni=max(total_cases,na.rm=TRUE))
testi_po_drzavah = testi_po_drzavah %>% filter(is.na(iso_code)==FALSE)
okuzeni_po_drzavah  = okuzeni_po_drzavah %>% filter(is.na(iso_code)==FALSE)
testi_okuzeni_po_drzavah = merge(testi_po_drzavah,okuzeni_po_drzavah,by=c("iso_code","location"))
testi_okuzeni_po_drzavah  = testi_okuzeni_po_drzavah  %>% filter(vsi_testi>0,vsi_testi>vsi_okuzeni)
testi_okuzeni_po_drzavah["odstotek_pozitivnih_testov"]<-100* testi_okuzeni_po_drzavah$vsi_okuzeni/testi_okuzeni_po_drzavah$vsi_testi 
zemljevid_odstotka_pozitivnih_testov<- tm_shape(merge(World, testi_okuzeni_po_drzavah, by.x="iso_a3", by.y="iso_code")) +
  tm_polygons("odstotek_pozitivnih_testov")  
##########################################
#Od vseh držav z več kot milijon prebivalci zračunej polinomski trend 3-je stopnje, poglej kdo ima na zadnji dan najbolj navpično
drzave = unique(podatki_svet$location)
trend=c()
datum = c()
for(drzava in drzave){
  podatki_za_Drzavo=((podatki_svet %>% filter(location==drzava))[,c(3,4,7)]) %>% filter(is.na(total_cases_per_million)==FALSE)
  if(nrow(podatki_za_Drzavo)>0){
  podatki_za_Drzavo$total_cases_per_million= c(podatki_za_Drzavo$total_cases_per_million[1], diff(podatki_za_Drzavo$total_cases_per_million))
  #total cases so sedaj new cases
  datum = c(datum,as.character(podatki_za_Drzavo$date[nrow(podatki_za_Drzavo)]))
  x=c(1,cumsum(as.integer(diff(podatki_za_Drzavo$date))))
  y=podatki_za_Drzavo$total_cases_per_million 
  model <- lm(y ~ poly(x,3))
  zadnji_dan =max(x)
  # 3*a3* x^2+a2*2*x+a1
  trend = c(trend,(predict(model)[[length(predict(model))]]-predict(model)[[length(predict(model))-1]])/(x[length(x)]-x[length(x)-1]))
  }
  else{
    drzave=drzave[drzave != drzava]
  }
}
datum = as.Date(datum, format="%Y-%m-%d")    
trend_drzav = data.frame("date"=datum,
                "trend"=trend,
                "location"=drzave)
zemljevid_trendov<- tm_shape(merge(World, trend_drzav, by.x="name", by.y="location")) +
  tm_polygons("trend",midpoint = NA) 
################################################################3


