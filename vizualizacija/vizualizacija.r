# Probamo uskladiti imena različnih podatkov
primerjava <- data.frame()


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

# primerjava izseljevanja v Afganistanu glede na spol (igranje)

afganistan <- filter(poSpolih, origin_country == "Afghanistan")
afMoski <- filter(afganistan, gender == "Male") %>%
  select(-"origin_country", -"gender") %>%
  group_by(decade) %>% summarise(number=sum(number, na.rm=TRUE))

afZenske <- filter(afganistan, gender == "Female") %>%
  select(-"origin_country", -"gender") %>%
  group_by(decade) %>% summarise(number=sum(number, na.rm=TRUE))

afmf <- ggplot(data=afMoski, aes(x=decade, y=number)) + geom_point() +
  geom_step(data=afZenske)



# ZEMLJEVIDI
# sploh rabim grafe, ki niso zemljevidi?

svet <- uvozi.zemljevid("http://thematicmapping.org/downloads/TM_WORLD_BORDERS-0.3.zip", "TM_WORLD_BORDERS-0.3")
tm_shape(svet) + tm_polygons()
data("World") #če ne ne dela

sve <- World %>% rename(country = name) %>%
  inner_join(neto, by=c("country"))

tm_shape(sve) + tm_polygons("izhod")

eu <- World %>% filter(continent == "Europe") %>%
  rename(country = name) %>%
  inner_join(neto, by=c("country"))

tm_shape(eu) + tm_polygons("izhod")


# # 3. faza: Vizualizacija podatkov
# 
# # Uvozimo zemljevid.
# zemljevid <- uvozi.zemljevid("http://baza.fmf.uni-lj.si/OB.zip", "OB",
#                              pot.zemljevida="OB", encoding="Windows-1250")
# levels(zemljevid$OB_UIME) <- levels(zemljevid$OB_UIME) %>%
#   { gsub("Slovenskih", "Slov.", .) } %>% { gsub("-", " - ", .) }
# zemljevid$OB_UIME <- factor(zemljevid$OB_UIME, levels=levels(obcine$obcina))
# zemljevid <- fortify(zemljevid)
# 
# # Izračunamo povprečno velikost družine
# povprecja <- druzine %>% group_by(obcina) %>%
#   summarise(povprecje=sum(velikost.druzine * stevilo.druzin) / sum(stevilo.druzin))

