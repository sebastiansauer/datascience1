--- 
title: "DataScience1"
subtitle: Grundlagen der Prognosemodellierung 🔮🧰

author: "Sebastian Sauer"
date: "2022-05-19 14:20:10"
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
description: "Grundlagen der Prognosemodellierung mit tidymodels"
github-repo: sebastiansauer/datascience1
# description: "Ein Kurs zu den Grundlagen des statistischen Lernens mit einem Fokus auf Prognosemodelle für hoch strukturierte Daten"
---










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


## Technische Details



- Diese Version des Buches wurde erstellt am: 2022-05-19 14:20:10


- Die URL zu diesem Buch lautet <https://sebastiansauer.github.io/datascience1/> und ist bei [GitHub Pages](https://pages.github.com/) gehostet.

- Lesen Sie sich die folgenden Informationen bitte gut durch: [Hinweise](https://sebastiansauer.github.io/fopra/Interna/Hinweise.html)

- Den Quellcode finden Sie [in diesem Github-Repo](https://github.com/sebastiansauer/datascience1).

- Sie haben Feedback, Fehlerhinweise oder Wünsche zur Weiterentwicklung? Am besten stellen Sie  [hier](https://github.com/sebastiansauer/datascience1/issues) einen *Issue*  ein.

- Dieses Projekt steht unter der [MIT-Lizenz](https://github.com/sebastiansauer/datascience1/blob/main/LICENSE). 

- Dieses Buch wurde in [RStudio](http://www.rstudio.com/ide/) mit Hilfe von [bookdown](http://bookdown.org/) geschrieben. 

- Diese Version des Buches wurd mit der R-Version R version 4.1.3 (2022-03-10) und den folgenden Paketen erstellt:


|package      |version    |source                             |
|:------------|:----------|:----------------------------------|
|bookdown     |0.26.2     |Github (rstudio/bookdown\@6adacc3) |
|broom        |0.8.0      |CRAN (R 4.1.2)                     |
|corrr        |0.4.3      |CRAN (R 4.1.0)                     |
|dials        |0.1.1      |CRAN (R 4.1.2)                     |
|downlit      |0.4.0      |CRAN (R 4.1.0)                     |
|dplyr        |1.0.9      |CRAN (R 4.1.2)                     |
|ggplot2      |3.3.6      |CRAN (R 4.1.2)                     |
|glmnet       |4.1-3      |CRAN (R 4.1.0)                     |
|infer        |1.0.0      |CRAN (R 4.1.0)                     |
|ISLR         |1.4        |CRAN (R 4.1.0)                     |
|kknn         |1.3.1      |CRAN (R 4.1.0)                     |
|klaR         |1.7-0      |CRAN (R 4.1.2)                     |
|MASS         |7.3-55     |CRAN (R 4.1.3)                     |
|modeldata    |0.1.1      |CRAN (R 4.1.0)                     |
|parsnip      |0.2.1      |CRAN (R 4.1.2)                     |
|patchwork    |1.1.1      |CRAN (R 4.1.0)                     |
|purrr        |0.3.4      |CRAN (R 4.1.0)                     |
|randomForest |4.7-1      |CRAN (R 4.1.2)                     |
|ranger       |0.13.1     |CRAN (R 4.1.0)                     |
|readr        |2.1.2      |CRAN (R 4.1.2)                     |
|rsample      |0.1.1      |CRAN (R 4.1.0)                     |
|rstatix      |0.7.0      |CRAN (R 4.1.0)                     |
|tibble       |3.1.7      |CRAN (R 4.1.2)                     |
|tidymodels   |0.1.4      |CRAN (R 4.1.0)                     |
|tidyr        |1.2.0      |CRAN (R 4.1.2)                     |
|tidyverse    |1.3.1      |CRAN (R 4.1.0)                     |
|tune         |0.2.0.9000 |Github (tidymodels/tune\@6ed30a4)  |
|vip          |0.3.2      |CRAN (R 4.1.0)                     |
|workflows    |0.2.6      |CRAN (R 4.1.2)                     |
|workflowsets |0.1.0      |CRAN (R 4.1.0)                     |
|xgboost      |1.5.2.1    |CRAN (R 4.1.2)                     |
|yardstick    |0.0.9      |CRAN (R 4.1.0)                     |








