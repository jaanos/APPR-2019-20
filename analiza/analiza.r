# 4. faza: Analiza podatkov

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

