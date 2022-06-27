--- 
title: "DataScience1"
subtitle: Grundlagen der Prognosemodellierung 🔮🧰

author: "Sebastian Sauer"
date: "2022-06-27 22:49:00"
site: bookdown::bookdown_site
# output: bookdown::gitbook
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
description: "Grundlagen der Prognosemodellierung mit tidymodels"
github-repo: sebastiansauer/datascience1
# description: "Ein Kurs zu den Grundlagen des statistischen Lernens mit einem Fokus auf Prognosemodelle für hoch strukturierte Daten"
---





<!-- ```{r global-knitr-options, include=FALSE} -->
<!--   knitr::opts_chunk$set( -->
<!--   fig.pos = 'H', -->
<!--   fig.asp = 0.618, -->
<!--   fig.align='center', -->
<!--   fig.width = 5, -->
<!--   out.width = "70%", -->
<!--   fig.cap = "",  -->
<!--   fig.path = "chunk-img/", -->
<!--   dpi = 300, -->
<!--   # tidy = TRUE, -->
<!--   echo = FALSE, -->
<!--   message = FALSE, -->
<!--   warning = FALSE, -->
<!--   cache = FALSE, -->
<!--   fig.show = "hold") -->
<!-- ``` -->







# Zu diesem Buch {-}




<a href="https://imgflip.com/i/689g8g"><img src="https://i.imgflip.com/689g8g.jpg" width="300" title="made at imgflip.com"/></a><div><a href="https://imgflip.com/memegenerator">from Imgflip Meme Generator</a></div>



## Was Sie hier lernen und wozu das gut ist

Alle Welt spricht von Big Data, aber ohne die Analyse sind die großen Daten nur großes Rauschen. Was letztlich interessiert, sind die Erkenntnisse, die Einblicke, nicht die Daten an sich. 
Dabei ist es egal, ob die Daten groß oder klein sind. 
Natürlich erlauben die heutigen Datenmengen im Verbund mit leistungsfähigen Rechnern und neuen Analysemethoden ein Verständnis, 
das vor Kurzem noch nicht möglich war. 
Und wir stehen erst am Anfang dieser Entwicklung. 
Vielleicht handelt es sich bei diesem Feld um eines der dynamischsten Fachgebiete der heutigen Zeit. 
Sie sind dabei: Sie lernen einiges Handwerkszeugs des "Datenwissenschaftlers". 
Wir konzentrieren uns auf das vielleicht bekannteste Teilgebiet: 
Ereignisse vorhersagen auf Basis von hoch strukturierten Daten 
und geeigneter Algorithmen und Verfahren.
Nach diesem Kurs sollten Sie in der Lage sein,
typisches Gebabbel des Fachgebiet mit Lässigkeit mitzumachen.
Ach ja, und mit einigem Erfolg Vorhersagemodelle entwickeln.


## Zitation

Nutzen Sie diese DOI, um dieses Buch zu zitieren: [![DOI](https://zenodo.org/badge/461950782.svg)](https://zenodo.org/badge/latestdoi/461950782)



## Download des Buches

Sie können verschiedene Versionen des Buches beziehen.
Aktuell sind das diese:

<!-- - [Pagedown-PDF-Buch]() -->
- [HTML-Buch](https://github.com/sebastiansauer/datascience1/raw/main/docs/Data-Science-1-html2.html)
- [Epub-Buch](https://github.com/sebastiansauer/datascience1/raw/main/docs/Data-Science-1.epub)
- [HTML-PDF-Buch](https://github.com/sebastiansauer/datascience1/raw/main/docs/DataScience1.pdf)

Bitte beachten Sie aber,
dass diese "schockgefrorenen" Versionen u.U. weniger aktuell sind. Tipp: Vergleichen Sie die Erstellungsdaten der jeweiligen Dokumente.

## Technische Details



- Diese Version des Buches wurde erstellt am: 2022-06-27 22:49:00


- Die URL zu diesem Buch lautet <https://sebastiansauer.github.io/datascience1/> und ist bei [GitHub Pages](https://pages.github.com/) gehostet.

- Lesen Sie sich die folgenden Informationen bitte gut durch: [Hinweise](https://sebastiansauer.github.io/fopra/Interna/Hinweise.html)

- Den Quellcode finden Sie [in diesem Github-Repo](https://github.com/sebastiansauer/datascience1).

- Sie haben Feedback, Fehlerhinweise oder Wünsche zur Weiterentwicklung? Am besten stellen Sie  [hier](https://github.com/sebastiansauer/datascience1/issues) einen *Issue*  ein.

- Dieses Projekt steht unter der [MIT-Lizenz](https://github.com/sebastiansauer/datascience1/blob/main/LICENSE). 

- Dieses Buch wurde in [RStudio](http://www.rstudio.com/ide/) mit Hilfe von [bookdown](http://bookdown.org/) geschrieben. 

- Diese Version des Buches wurd mit der R-Version R version 4.2.0 (2022-04-22) und den folgenden Paketen erstellt:


|package      |version |source         |
|:------------|:-------|:--------------|
|bookdown     |0.26    |CRAN (R 4.2.0) |
|broom        |0.8.0   |CRAN (R 4.2.0) |
|corrr        |NA      |NA             |
|dials        |0.1.1   |CRAN (R 4.2.0) |
|downlit      |0.4.0   |CRAN (R 4.2.0) |
|dplyr        |1.0.9   |CRAN (R 4.2.0) |
|ggplot2      |3.3.6   |CRAN (R 4.2.0) |
|glmnet       |NA      |NA             |
|infer        |1.0.2   |CRAN (R 4.2.0) |
|ISLR         |NA      |NA             |
|kknn         |1.3.1   |CRAN (R 4.2.0) |
|klaR         |NA      |NA             |
|MASS         |7.3-56  |CRAN (R 4.2.0) |
|modeldata    |0.1.1   |CRAN (R 4.2.0) |
|parsnip      |0.2.1   |CRAN (R 4.2.0) |
|patchwork    |1.1.1   |CRAN (R 4.2.0) |
|purrr        |0.3.4   |CRAN (R 4.2.0) |
|randomForest |NA      |NA             |
|ranger       |0.13.1  |CRAN (R 4.2.0) |
|readr        |2.1.2   |CRAN (R 4.2.0) |
|rsample      |0.1.1   |CRAN (R 4.2.0) |
|rstatix      |NA      |NA             |
|tibble       |3.1.7   |CRAN (R 4.2.0) |
|tidymodels   |0.2.0   |CRAN (R 4.2.0) |
|tidyr        |1.2.0   |CRAN (R 4.2.0) |
|tidyverse    |1.3.1   |CRAN (R 4.2.0) |
|tune         |0.2.0   |CRAN (R 4.2.0) |
|vip          |0.3.2   |CRAN (R 4.2.0) |
|workflows    |0.2.6   |CRAN (R 4.2.0) |
|workflowsets |0.2.1   |CRAN (R 4.2.0) |
|xgboost      |1.6.0.1 |CRAN (R 4.2.0) |
|yardstick    |1.0.0   |CRAN (R 4.2.0) |








