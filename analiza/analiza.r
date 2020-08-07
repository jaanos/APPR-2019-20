# 4. faza: Analiza podatkov

#############################################################################
#SAMO TRENUTNO ZA POMOČ
#SELECT...
select(podatki_svet, continent)
select(podatki_svet, 1:4)

#FILTER
filter(podatki_svet, new_cases > 10000)
filter(podatki_svet, total_cases > 100000, continent=="Asia")

#Arrange
arrange(podatki_svet, total_cases)
arrange(podatki_svet, -total_cases)
arrange(podatki_svet, total_cases,total_deaths)

#Mutate
a <- mutate(podatki_svet, nova_sprem= total_cases / total_deaths)
a <- mutate(a, nova_nova=nova_sprem*10)

#Summarise
summarise(podatki_svet, najvec_obolelih = max(new_cases),najmanj_obolelih=min(new_cases))

#GROUP_BY
group_by(podatki_svet, date)
#če temu dodaš summarise lahko dobiš ven podatke, ki se ločujejo po datumih
group_by(podatki_svet, date, location)

#Pipe operator (beri in potem) :  %>%
podatki_svet %>% group_by(date) 
#Tole zgori je isto kot: group_by(podatki_svet, date)
podatki_svet %>% group_by(location) %>% summarise(median_daily = median(new_cases)) 

############################################################################################


death_rate_life_expectancy <-podatki_svet %>%
  mutate(death_rate = total_deaths_per_million/total_cases_per_million) %>%
  select(location,continent,death_rate,life_expectancy,extreme_poverty) %>%
  group_by(location,continent) %>% 
  summarise(najvisji_death_rate = max(death_rate),life_expectancy = max(life_expectancy), revscina = max(extreme_poverty))

ggplot(death_rate_life_expectancy,aes(x=life_expectancy,y=najvisji_death_rate,col=continent))+
  geom_point()+
  ggtitle("Death rate glede na pricakovano zivljensko dobo") 

ggplot(death_rate_life_expectancy,aes(x=revscina,y=najvisji_death_rate,col=continent))+
  geom_point()+
  ggtitle("Death rate glede na revscino") 

#dodej pol še populacijo continentov

zbrisi_NA <- function(stolpec){
  for(i in 1:length(stolpec)){
    if(is.na(stolpec[i])== TRUE){
      stolpec[i] = 0
    }
  }
}

podatki_svet_brez_NA <- podatki_svet
podatki_svet_brez_NA$new_cases <- zbrisi_NA(podatki_svet_brez_NA$new_cases)

  svetovno_testiranje_po_dnevih <-podatki_svet_brez_NA %>% 
  mutate(dan_v_tednu= weekdays(podatki_svet$date)) %>%
  select(dan_v_tednu,new_tests,continent) %>%
  group_by(dan_v_tednu,continent)%>%
  summarise(stevilo_testov_po_dnevih=sum(new_tests))
for(i in 1:7){
  svetovno_testiranje_po_dnevih$continent[7*i] <- "International"
}

