library(readr)
library(dplyr)
library(tidyr)
library(rvest)
library(XML)
library(gsubfn)

# UREJANJE GLAVNE TABELE O MIGRACIJI
migracija <- read_csv("podatki/migracija.csv", n_max = 160776, na = c("..")) %>%
  select(-"Migration by Gender Code", -"Country Origin Code", -"Country Dest Code")

colnames(migracija) <- c("origin_country", "gender", "dest_country", 
                         "1960-1969", "1970-1979", "1980-1989", "1990-1999", "2000-2010")

skupno <- migracija %>% filter(gender=="Total") %>% select(-"gender") %>% 
  gather(decade, number, "1960-1969", "1970-1979", "1980-1989", "1990-1999", "2000-2010") %>%
  arrange(origin_country)

poSpolih <- migracija %>% filter(gender=="Female" | gender=="Male" ) %>%
  gather(decade, number, "1960-1969", "1970-1979", "1980-1989", "1990-1999", "2000-2010") %>%
  arrange(origin_country)
poSpolih <- poSpolih[c(1,3,2,4,5)]

# BDP podatki iz wikipedije
url <- "https://en.wikipedia.org/wiki/List_of_countries_by_past_and_projected_GDP_(PPP)"
stran <- read_html(url)

drzave <- stran %>% 
  html_nodes(xpath = "//table[@class = 'sortable wikitable jquery-tablesorter']") %>%
  html_text





# neto migracija iz fajla ali izracunano?