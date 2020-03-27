TABELA_VSEH_VALUT <- ggplot(tabela_starih_valut %>% group_by(currency) %>% summarise(max=max(values)) %>%
                              inner_join(tabela_starih_valut),
                            aes(x=time, y=values/max,col=currency))+geom_line()
