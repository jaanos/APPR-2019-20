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

#########################################################################################################
population_by_continent <- htmltab("https://en.wikipedia.org/wiki/List_of_continents_by_population",1)
population_by_continent <-population_by_continent[c(2:7),c(2,3)]
colnames(population_by_continent)<- c("continent","population_continent")
population_by_continent$population_continent <- gsub(",","",population_by_continent$population_continent)
population_by_continent$population_continent <- as.numeric(as.character(population_by_continent$population_continent))

dnevi.v.tednu <- as.Date(0:6, origin="1900-01-01") %>% weekdays()

svetovno_testiranje_po_dnevih <-podatki_svet %>%
  
  mutate(dan_v_tednu=weekdays(date) %>% factor(levels=dnevi.v.tednu, ordered=TRUE)) %>%
  
  group_by(dan_v_tednu, continent) %>%
  
  summarise(stevilo_testov_po_dnevih=sum(new_tests, na.rm=TRUE)) %>%
  
  drop_na(continent)

svetovno_testiranje_po_dnevih <- merge(svetovno_testiranje_po_dnevih, population_by_continent, by="continent")
ggplot(svetovno_testiranje_po_dnevih,
       
       aes(x=as.numeric(dan_v_tednu), y=stevilo_testov_po_dnevih, color=continent,size = population_continent)) +
  
  geom_line() + scale_x_continuous(breaks=1:7, labels=dnevi.v.tednu)
##########################################3


