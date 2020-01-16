# 2. faza: Uvoz podatkov

source("lib/libraries.r", encoding = "UTF-8")

sl <- locale("sl", decimal_mark=",", grouping_mark=".") 


# Funkcija, ki uvozi kolicina alkohola per capita-2010 iz Wikipedije
uvozi.kolicina_pc <- function() {
  
  link <- "https://en.wikipedia.org/wiki/List_of_countries_by_alcohol_consumption_per_capita"
  page <- html_session(link) %>% read_html()
  table <- page %>% html_nodes(xpath="//table[@class='wikitable nowrap sortable mw-datatable']") %>% .[[1]] %>%
    html_table(dec=".")
  

  #for (i in 1:ncol(table())) {
   # if (is.character(table[[i]])) {
   #   Encoding(table[[i]]) <- "UTF-8"
   # }
  #}
  
  colnames(table) <- c("Countries", "Total alcohol", "Recorded consumption", "Unrecorded consumption", "Beer(%)",
                        "Wine(%)", "Spirits(%)", "Other(%)", "2015 projection")
  
  table$`2015 projection`<- NULL
  table$`Recorded consumption` <- NULL
  table$`Unrecorded consumption`<- NULL
  
  # for (col in c("Beer", "Wine", "Spirits", "Other", "Total alcohol")) {
  #   if (is.character(table[[col]])) {
  #     table[[col]] <- parse_number(table[[col]], na=c("0", "0.0", ""))
  #   }
  # }
  return(table)
}
kolicina_pc <- uvozi.kolicina_pc()


# Funkcija, ki uvozi podatke iz datoteke prices.csv
uvozi_cene <- function() {
  
  col <- c("Year", "Country", "Unit", "Type", "Value", "Comments")
  cene <- read_csv("podatki/prices.csv", locale=locale(encoding="cp1250"),
                   col_names = col, skip=1, na=c(":", ""," ", "-")) %>% select(-"Comments", -"Unit")

  cene <- cene[c(2,1,3,4)] 
  cene[2] <- lapply(cene[2], as.integer)
  
  cene$Country <- gsub("European Union - 28 countries", "EU", 
                       gsub("^Germany.*", "Germany",
                            gsub("Former Yugoslav Republic of Macedonia, the", "Macedonia", cene$Country)))
  
  return(cene)
}
cene <- uvozi_cene()



# Funkcija, ki uvozi podatke iz datoteke production_imports_exports.csv
uvoz_proizvodnja <- function(){
  
  col <- c("Indicators", "Country", "Code", "Type of alcohol", "Year", "Value", "Footnotes")
  
  production <- read_csv("podatki/production_imports_exports.csv",
                          locale = locale(encoding = "cp1250"), col_names = col, skip=1, na=c(":", ""," ", "-", "0"))
  
  production$Footnotes <- NULL
  production$Code <- NULL
  production <- production[c(2, 4, 1, 3, 5)] %>% spread(Indicators, Value)
  production$Year <- gsub("Jan.-Dec. ", "", production$Year)
  
  
  names(production)[4] = "Exports"
  names(production)[5] = "Imports"
  names(production)[6] = "Production"
  production[c(2,4,5,6)] <- lapply(production[c(2,4,5,6)], as.integer)
  
  return(production)
}
production <- uvoz_proizvodnja()

# Funkcija, ki uvozi podatke iz datoteke consumption_sex&age.csv
uvoz_kolicina_sex_age <- function(){
  col = c("Frequency", "Country", "Year", "Degree of urbanisation", 
                "Sex", "Age", "Unit", "Value", "Comment")

  consumption <- read_csv("podatki/consumption_sex&age.csv", col_names = col, locale=locale(encoding = "cp1250"), 
                          skip=1, na=c(":", ""," ", "-")) %>% select(-"Unit", -"Comment", -"Year", -"Degree of urbanisation")

  #not working: consumption %>% gsub("European Union - 28 countries", "EU", 
                              #gsub("^Germany.*", "Germany", consumption$Country)))
  
  consumption <- consumption[c(2, 4, 1, 3, 5)] %>% spread(Age, Value)
  
  return(consumption)
}
kolicina <- uvoz_kolicina_sex_age()

uvoz_gdp_per_capita <- function(){
  gdp_per_capita <- read_csv2("podatki/gdp_per_capita.csv", col_names=c("Country", "Year", "Value"), skip=1, na=c(":", "", " ", "-"))
  gdp_per_capita <- gdp_per_capita[-1,]
  gdp_per_capita <- gdp_per_capita[-1,]
  
  gdp_per_capita[c(2,3)] <- lapply(gdp_per_capita[c(2,3)], as.integer)

  return(gdp_per_capita)
}
gdp_per_capita <- uvoz_gdp_per_capita()
