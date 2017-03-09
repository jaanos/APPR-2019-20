library(knitr)
library(dplyr)
library(rvest)
library(gsubfn)
library(ggplot2)
library(reshape2)

# Uvozimo funkcije za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r", encoding = "UTF-8")