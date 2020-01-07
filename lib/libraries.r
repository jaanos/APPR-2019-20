library(knitr)
library(rvest)
library(gsubfn)
library(tidyr)
library(shiny)
library(httr)
library(ggplot2)
library(ggvis)

# Uvozimo funkcije za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r", encoding="UTF-8")
