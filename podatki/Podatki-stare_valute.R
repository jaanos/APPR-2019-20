tabela_starih_valut <- get_eurostat("ert_h_eur_a")
place_v_Evropi <- get_eurostat("tec00013") 
GDP_per_capita_in_PPS <- get_eurostat("tec00114")


TABELA_VSEH_VALUT <- ggplot(tabela_starih_valut %>% group_by(currency) %>% summarise(max=max(values)) %>%
         inner_join(tabela_starih_valut),
       aes(x=time, y=values/max,col=currency))+geom_line()
TABELA_SLO_IT_AT<-ggplot(tabela_starih_valut %>% group_by(currency) %>% summarise(max=max(values)) %>%
                     inner_join(tabela_starih_valut) %>% filter(currency==c("SIT","ATS","ITL")),
                    aes(x=time, y=values/max,col=currency))+geom_line()
TABELA_SLO_EUTOP <-ggplot(tabela_starih_valut %>% group_by(currency) %>% summarise(max=max(values)) %>%
inner_join(tabela_starih_valut) %>% filter(currency==c("SIT","FRF","ITL","ESP")),
                          aes(x=time, y=values/max,col=currency))+geom_line()
ggplot(GDP_per_capita_in_PPS ,aes(x=time, y=values,col=geo))+geom_line()












#ATS <- get_eurostat("ert_h_eur_a", filter= list(currency="ATS"))[,5]
#BEF <- get_eurostat("ert_h_eur_a", filter= list(currency="BEF"))[,5]
#CYP <- get_eurostat("ert_h_eur_a", filter= list(currency="CYP"))[,5]
#DEM <- get_eurostat("ert_h_eur_a", filter= list(currency="DEM"))[,5]
#EEK <- get_eurostat("ert_h_eur_a", filter= list(currency="EEK"))[,5]
#ESP <- get_eurostat("ert_h_eur_a", filter= list(currency="ESP"))[,5]
#FIM <- get_eurostat("ert_h_eur_a", filter= list(currency="FIM"))[,5]
#FRF <- get_eurostat("ert_h_eur_a", filter= list(currency="FRF"))[,5]
#GRD <- get_eurostat("ert_h_eur_a", filter= list(currency="GRD"))[,5]
#IEP <- get_eurostat("ert_h_eur_a", filter= list(currency="IEP"))[,5]
#ITL <- get_eurostat("ert_h_eur_a", filter= list(currency="ITL"))[,5]
#LTL <- get_eurostat("ert_h_eur_a", filter= list(currency="LTl"))[,5]
#LUF <- get_eurostat("ert_h_eur_a", filter= list(currency="LUF"))[,5]
#LVL <- get_eurostat("ert_h_eur_a", filter= list(currency="LVL"))[,5]
#MTL <- get_eurostat("ert_h_eur_a", filter= list(currency="MTL"))[,5]
#NLG <- get_eurostat("ert_h_eur_a", filter= list(currency="NLG"))[,5]
#PTE <- get_eurostat("ert_h_eur_a", filter= list(currency="PTE"))[,5]
#SIT <- get_eurostat("ert_h_eur_a", filter= list(currency="SIT"))[,5]
#SKK <- get_eurostat("ert_h_eur_a", filter= list(currency="SKK"))[,5]































#!!VPRAŠANJA!!
#kaj se to spodi obarva z rdečo
#kam naj shranjujem skripte
#ali so tabele ok
#kako skrajšam tabelo starih valut, da bo od 1990 naprej.
#kakšne grafe bi bilo smotrno narest iz teh podatkov
#če grem iz eurostata dol potegnt v csv obliki, mi da excelova daotetko
#kjer ločuje z vejcami,a to je kul?
#če to z libraryem ni kul, kako se pol sploh lotm "neurejen"
# Gross domestic product (GDP) is a measure for
#the economic activity. It is defined as the value of all g
#oods and services produced less the value of any goods or 
#services used in their creation. The volume index of GDP 
#per capita in Purchasing Power Standards (PPS) is expressed 
#in relation to the European Union (EU28) average set to equal 100.
#If the index of a country is higher than 100, this country's 
#level of GDP per head is higher than the EU average and vice versa.
#Basic figures are expressed in PPS, i.e. a common currency that 
#eliminates the differences in price levels between countries 
#allowing meaningful volume comparisons of GDP between countries. 
#Please note that the index, calculated from PPS figures and 
#expressed with respect to EU28 = 100, is intended 
#for cross-country comparisons rather than for temporal comparisons."
#place_v_evropi:
#PC_GDP-Percantage of gross domestic products
#CP_MEUR- Curremt prices, million Euro(bruto)
