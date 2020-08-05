library(knitr)
library(rvest)
library(gsubfn)
library(tidyr)
library(tmap)
library(shiny)
library(readr)
library(dplyr)
library(mosaic)
library(farver)
library(tmaptools)
options(gsubfn.engine="R")
library("readxl")
library("openxlsx")
library(tmap)
library(ggplot2)
library(scales)



options(gsubfn.engine="R")

# Uvozimo funkcije za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r", encoding="UTF-8")
