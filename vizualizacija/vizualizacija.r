# 3. faza: Vizualizacija podatkov

source("lib/uvozi.zemljevid.r", encoding = "UTF-8")
source("lib/libraries.r", encoding = "UTF-8")
source("uvoz/uvoz.r", encoding = "UTF-8")
library(RColorBrewer)


#Primerjava cene in zivljenski standard v nekoliko drzavah
countries <- filter(cene, Country %in% c("Bulgaria", "Romania", "Finland", "Spain", "United Kingdom", "Switzerland"))
nb.cols <- 6
mycolours <- colorRampPalette(brewer.pal(20, "Paired"))(nb.cols)

graf_cene <- ggplot(mapping = aes(x=Year, y=Value, colour=Country)) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, size = 8)) +
  geom_line(linetype="solid", data=countries) +
  geom_line(linetype="dashed", data=gdp_per_capita) + 
  labs(x="Year", y="Prices", title="Prices 2008-2018 and GDP per capita", colour="Countries") +
  scale_x_discrete(limits=c(2008:2018))+
  scale_colour_manual(values = mycolours)

#Proizvodnja alkohola v EU
graf_proizvodnja <- ggplot(data=production, aes(x=Year, y=Production, fill=`Type of alcohol`)) +
  labs(x="Year", y="Production", title = "Production of alcohol in EU by category") + scale_color_manual(values = mycolours) +
  theme_minimal() +
  geom_bar(stat = "identity", position=position_dodge(), size=.3) +
  theme(axis.text.x = element_text(angle = 90, size = 8)) +
  scale_x_discrete(limits=c(2008:2018)) +
  scale_y_discrete(limits=seq(6, 2070000000, by=70000000)) +
  coord_flip()

#Zemljevid

#zemljevid <- uvozi.zemljevid("http://thematicmapping.org/downloads/TM_WORLD_BORDERS-0.3.zip", "TM_WORLD_BORDERS-0.3") + 
#tm_shape(zemljevid) + tm_polygons() 
  
zemljevid <- uvozi.zemljevid("https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
                               
                              "ne_50m_admin_0_countries",mapa="./zemljevidi") %>% fortify()
  
#Zemljevid: kolicina alkohola per capita
zemljevid_kolicina_alkohola <- ggplot() + geom_polygon(data=left_join(zemljevid, kolicina_pc %>% group_by(Countries) %>% summarise(`Total alcohol`), by=c("SOVEREIGNT"="Countries")),
                 aes(x=long, y=lat, group=group, fill=`Total alcohol`), size=0.1) +
  labs(x="", y="", fill="Total alcohol per capita") + ggtitle("Drzave glede na uporabene litre alkohola")

#Zemljevid: kolicina alkohola na mladi ljudi 
alcohol_young_people <-kolicina %>% filter(Sex=="Total") %>% filter(Frequency=="Every month") %>% group_by(Country) %>% summarise(Total)

zemljevid_kolicina_alkohola_mlade <- ggplot() + geom_polygon(data=left_join(zemljevid, alcohol_young_people, by=c("SOVEREIGNT"="Country")),
                                           aes(x=long, y=lat, group=group, fill=Total), size=0.1) +
  labs(x="", y="", fill="Total alcohol per young person") + ggtitle("Drzave glede na uporebene litre alkohola od mladi ljudi")
#not working: zemljevid_kolicina_alkohola_mlade + coord_cartesian(xlim=c(-100, 50), ylim=c(0, 100), expand = TRUE)                                                                                    

