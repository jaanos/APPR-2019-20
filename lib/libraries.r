library(knitr)
library(rvest)
library(gsubfn)
library(tidyr)
library(shiny)
library(readr)
library(dplyr)
library(stringr)
library(ggplot2)
library(tmap)
library(StandardizeText)

# Uvozimo funkcije za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r", encoding="UTF-8")

options(gsubfn.engine="R")