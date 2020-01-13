---
  title: "Poročilo pri predmetu Analiza podatkov s programom R"
author: "Tim Kalan"
output:
  html_document: default
pdf_document:
  includes:
  in_header: lib/styles.sty
latex_engine: xelatex
# runtime: shiny
---
  
  ```{r setup, echo=FALSE, results='hide', message=FALSE, warning=FALSE}
# Če želimo nastaviti pisave v PDF-ju, odkomentiramo
# in sledimo navodilom v programu.
#source("fontconfig.r", encoding="UTF-8")

# Uvoz vseh potrebnih knjižnic
source("lib/libraries.r", encoding="UTF-8")
```

```{r rstudio, echo=FALSE, results='asis'}
# Izris povezave do RStudia na Binderju
source("lib/rstudio.r", encoding="UTF-8")
```

# Izbira teme

Spodaj je prikazanih nekaj podatkov o migraciji po svetu.
