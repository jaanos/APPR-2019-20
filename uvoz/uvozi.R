library(readr)
library(dplyr)

# UREJANJE GLAVNE TABELE O MIGRACIJI
migracija <- read_csv("podatki/migracija.csv", n_max = 160776, na = c("..")) %>%
  select(-"Migration by Gender Code", -"Country Origin Code", -"Country Dest Code")

colnames(migracija) <- c("origin_country", "migration_gender", "dest_country", "1960-1969", "1970-1979", "1980-1989", "1990-1999", "2000-2010")





# BDP podatki iz wikipedije
# neto migracija iz fajla ali izracunano?