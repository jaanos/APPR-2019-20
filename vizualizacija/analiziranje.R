# Izračun neto migracije za posamezne države skozi čas

neto <- skupno %>% group_by(origin_country) %>%
  summarise(neto_izhod=sum(number, na.rm=TRUE)) # to je treba razdrobiti po desetletjih

# GRAFI

# primerjava izseljevanja v Afganistanu glede na spol

afganistan <- filter(poSpolih, origin_country == "Afghanistan")
afMoski <- filter(afganistan, gender == "Male") %>%
  select(-"origin_country", -"gender") %>%
  group_by(decade) %>% summarise(number=sum(number, na.rm=TRUE))

afZenske <- filter(afganistan, gender == "Female") %>%
  select(-"origin_country", -"gender") %>%
  group_by(decade) %>% summarise(number=sum(number, na.rm=TRUE))

afmf <- ggplot(data=afMoski, aes(x=decade, y=number)) + geom_point() + 
  geom_step(data=afZenske)



# tudi zemljevid sveta in to

svet <- uvozi.zemljevid("http://thematicmapping.org/downloads/TM_WORLD_BORDERS-0.3.zip", "TM_WORLD_BORDERS-0.3")
tm_shape(svet) + tm_polygons()
