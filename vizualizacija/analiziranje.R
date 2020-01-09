# Izračun neto migracije za posamezne države skozi čas

neto <- skupno %>% group_by(origin_country) %>%
  summarise(neto_izhod=sum(number, na.rm=TRUE)) # to je treba razdrobiti po desetletjih

# tudi zemljevid sveta in to