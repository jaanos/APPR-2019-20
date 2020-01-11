# Izračun neto migracije za posamezne države skozi čas 

izhod <- skupno %>% group_by(origin_country, decade) %>%
  summarise(izhod=sum(number, na.rm=TRUE)) %>%
  rename(country = origin_country)

prihod <- skupno %>% group_by(dest_country, decade) %>%
  summarise(prihod=sum(number, na.rm=TRUE)) %>%
  rename(country = dest_country)

# to zdaj ni tidy data
neto <- inner_join(izhod, prihod, by = c("country", "decade")) %>%
  mutate(neto_imigracija = prihod - izhod)

# kot zgoraj, samo razdeljeno po spolih
izhodS <- poSpolih %>% group_by(origin_country, decade, gender) %>%
  summarise(izhod=sum(number, na.rm=TRUE)) %>%
  rename(country = origin_country)

prihodS <- poSpolih %>% group_by(dest_country, decade, gender) %>%
  summarise(prihod=sum(number, na.rm=TRUE)) %>%
  rename(country = dest_country)

netoSpoli <- inner_join(izhodS, prihodS, by = c("country", "decade", "gender")) %>%
  mutate(neto_imigracija = prihod - izhod)


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

sve <- World %>% rename(country = name) %>%
  inner_join(neto, by=c("country"))

tm_shape(sve) + tm_polygons("izhod")

eu <- World %>% filter(continent == "Europe") %>%
  rename(country = name) %>% 
  inner_join(neto, by=c("country"))

tm_shape(eu) + tm_polygons("izhod")
