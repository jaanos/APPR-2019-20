library(knitr)
library(rvest)
library(gsubfn)
library(tidyr)
library(shiny)
library(readr)
library(dplyr)
library(stringr)
library(XML)
library(ggplot2)
library(tmap)

# Uvozimo funkcije za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r", encoding="UTF-8")
