library(knitr)
library(rvest)
library(gsubfn)
library(tidyr)
library(shiny)
library(tidyverse)
library(eurostat)
library(ggplot2)

options(gsubfn.engine="R")

# Uvozimo funkcije za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r", encoding="UTF-8")
