# Uvoz s spletne strani

library(XML)
library(httr)

# Vrne vektor nizov z odstranjenimi začetnimi in končnimi "prazninami" (whitespace)
# iz vozlišč, ki ustrezajo podani poti.
stripByPath <- function(x, path) {
  unlist(xpathApply(x, path,
                    function(y) gsub("^\\s*(.*?)\\s*$", "\\1", xmlValue(y))))
}

uvozi.obcine <- function() {
  url.obcine <- "http://sl.wikipedia.org/wiki/Seznam_ob%C4%8Din_v_Sloveniji"
  doc.obcine <- htmlTreeParse(GET(url.obcine), asText=TRUE, useInternalNodes=TRUE)
  
  tabela <- readHTMLTable(doc.obcine, which=2,
      colClasses = c("character", rep("FormattedNumber", 5), rep("character", 3)),
                          elFun = function(x) {
                            s <- gsub("[*]", "", xmlValue(x))
                            return(ifelse(s %in% c("", "-"), NA, s))
                          })
  
  # Imena stolpcev matrike dobimo iz celic (<th>) glave (prve vrstice) prve tabele
  colnames(tabela) <- gsub("\n", " ", colnames(tabela))
  
  # Prvi stolpec vzamemo za imena in ga nato odstranimo
  rownames(tabela) <- tabela[,1]
  tabela <- tabela[-1]
  
  # Podatke iz matrike spravimo v razpredelnico
  return(tabela)
}