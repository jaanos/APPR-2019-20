library(readr)
library(dplyr)

# netoMigracija <- read_csv("podatki/migrant_stock.csv") %>% 
#   select(-"1961", -"1962", -"1963") # to maš še ful za zbrisat

migracija <- read_csv("podatki/migracija.csv") %>%
  select(-"Migration by Gender Code", -"Country Origin Code", -"Country Dest Code")