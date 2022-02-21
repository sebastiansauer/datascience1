--- 
title: "Data Science 1"
author: "Sebastian Sauer"
date: "2022-02-21 21:52:38"
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
github-repo: rstudio/bookdown-demo
description: "Ein Kurs zu den Grundlagen des statistischen Lernens mit einem Fokus auf Prognosemodelle für hoch strukturierte Daten"
---




```r
library(tidyverse)
```

```
## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --
```

```
## v ggplot2 3.3.5     v purrr   0.3.4
## v tibble  3.1.6     v dplyr   1.0.8
## v tidyr   1.2.0     v stringr 1.4.0
## v readr   2.1.2     v forcats 0.5.1
```

```
## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```



# Überblick




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




## Lernziele

Nach diesem Kurs sollten Sie

- grundlegende Konzepte des statistischen Lernens verstehen und mit R anwenden können
- gängige Prognose-Algorithmen kennen, in Grundzügen verstehen und mit R anwenden können
- die Güte und Grenze von Prognosemodellen einschätzen können


## Voraussetzungen

Um von diesem Kurs am besten zu profitieren,
sollten Sie folgendes Wissen mitbringen:


- grundlegende Kenntnisse im Umgang mit R, möglichst auch mit dem tidyverse
- grundlegende Kenntnisse der deskriptiven Statistik
- grundlegende Kenntnis der Regressionsanalyse





## Hinweise zu diesem Projekt

- Die URL zu diesem Projekt lautet <test.io>.

- Lesen Sie sich die folgenden Informationen bitte gut durch: [Hinweise](https://sebastiansauer.github.io/fopra/Interna/Hinweise.html)

- Den Quellcode finden Sie [in diesem Github-Repo](https://github.com/sebastiansauer/datascience1).

- Sie haben Feedback, Fehlerhinweise oder Wünsche zur Weiterentwicklung? Am besten stellen Sie  [hier](https://github.com/sebastiansauer/datascience1/issues) einen *Issue*  ein.

- Dieses Projekt steht unter der [MIT-Lizenz](https://github.com/sebastiansauer/datascience1/blob/main/LICENSE)). 





## Lernhilfen




### Software

- Installieren Sie [R und seine Freunde](https://data-se.netlify.app/2021/11/30/installation-von-r-und-seiner-freunde/).
- Installieren Sie die folgende R-Pakete:
    - tidyverse
    - tidymodels
    - weitere Pakete werden im Unterricht bekannt gegeben (es schadet aber nichts, jetzt schon Pakete nach eigenem Ermessen zu installieren)
- [R Syntax aus dem Unterricht](https://github.com/sebastiansauer/Lehre) findet sich im Github-Repo bzw. Ordner zum jeweiligen Semester.





### Online-Zusammenarbeit

- [Frag-Jetzt-Raum zum anonymen Fragen stellen während des Unterrichts](https://frag.jetzt/home). Der Keycode wird Ihnen vom Dozenten bereitgestellt.
- [Padlet](https://de.padlet.com/) zum einfachen (und anonymen) Hochladen von Arbeitsergebnissen der Studentis im Unterricht. Wir nutzen es als eine Art Pinwand zum Sammeln von Arbeitsbeiträgen. Die Zugangsdaten stellt Ihnen der Dozent bereit.








## Literatur

Zentrale Kursliteratur für die theoretischen Konzepte ist [@rhys_machine_2020].
Die praktische Umsetzung in R basiert auf [@silge_tidy_nodate].













<!--chapter:end:index.Rmd-->

# Modulüberblick



## 

### Datum 

- 14.-18.3.22


### Lernziele 

- Sie können erläutern, was man unter statistischem Lernen versteht.
- Sie wissen, war Overfitting ist, wie es entsteht, und wie es vermieden werden kann.
- Sie kennen verschiedenen Arten von statistischem Lernen und können Algorithmen zu diesen Arten zuordnen.


### Vorbereitung 

- Lesen Sie die Hinweise zum Modul.
- Installieren (oder Updaten) Sie die für dieses Modul angegeben Software.
- Lesen Sie die Literatur.


### Literatur 

- Rhys, Kap. 1


### Skript 

- [Kap. 1]()


### Hinweise 

- Bitte beachten Sie die Einteilung in die Züge für den Präsenzunterricht.




## 

### Datum 

- 21.3.-25.3.


### Lernziele 

- Sie können Funktionen, auch anonyme, in R schreiben.
- Sie können Datensätze vom Lang- und Breit-Format wechseln.
- Sie können Mapping-Funktionen anwenden.
- Sie können eine dplyr-Funktion auf mehrere Spalten gleichzeitig anwenden.


### Vorbereitung 

- Lesen Sie die Literatur.


### Literatur 

- Rhys, Kap. 2




## 

### Datum 

- 28.3.-1.4.


### Literatur 

- TMWR




## 

### Datum 

- 4.4.-8.4.


### Literatur 

- Rhys, Kap. 3




## 

### Datum 

- 11.4.-15.4.


### Literatur 

- Rhys, Kap. 3


### Hinweise 

- In dieser Woche fällt die Übung aus.




## 

### Datum 

- 18.4.-22.4


### Hinweise 

- In dieser Woche fällt die Vorlesung aus.




## 

### Datum 

- 25.4.-29.4.


### Literatur 

- Rhys, Kap. 4




## 

### Datum 

- 2.4.-6.5.


### Literatur 

- Rhys, Kap. 6




## 

### Datum 

- 9.5.-13.5.


### Literatur 

- Rhys, Kap. 7




## 

### Datum 

- 16.5.-20.5.


### Literatur 

- Rhys, Kap. 8




## 

### Datum 

- 23.5.-27.5.


### Literatur 

- Rhys, Kap.9


### Hinweise 

- Nächste Woche ist BlocKalenderwocheoche; es findet kein regulärer Unterricht statt.
- Diese Woche fällt die Übung aus.




## 

### Datum 

- 6.6.-10.6.


### Hinweise 

- In dieser Woche fällt die Vorlesung aus.




## 

### Datum 

- 13.6.-17.6.


### Literatur 

- Rhys, Kap. 10




## 

### Datum 

- 20.6.-24.6.


### Literatur 

- Rhys, Kap. 11




## 

### Datum 

- 27.6.-1.7.


### Literatur 

- Rhys, Kap. 12


### Hinweise 

- Nach dieser Woche endet der Unterricht.


<!--chapter:end:01-Modulueberblick.Rmd-->

# Modulzeitplan



Nr. | Kalenderwoche | Datum | Thema
---|---|---|--
1 | 11 | 14.-18.3.22 | Grundkonzepte
2 | 12 | 21.3.-25.3. | tidyverse, 2. Blick
3 | 13 | 28.3.-1.4. | tidymodels
4 | 14 | 4.4.-8.4. | kNN
5 | 15 | 11.4.-15.4. | Statistisches Lernen
6 | 16 | 18.4.-22.4 | Wiederholung
7 | 17 | 25.4.-29.4. | Logistische Regression
8 | 18 | 2.4.-6.5. | Naive Bayes
9 | 19 | 9.5.-13.5. | Entscheidungsbäume
10 | 20 | 16.5.-20.5. | Zufallswälder
11 | 21 | 23.5.-27.5. | Fallstudie
12 | 23 | 6.6.-10.6. | Wiederholung
13 | 24 | 13.6.-17.6. | GAM
14 | 25 | 20.6.-24.6. | Lasso und Co
15 | 26 | 27.6.-1.7. | Vertiefung


<!--chapter:end:02-Modulzeitplan.Rmd-->



<!--chapter:end:06-references.Rmd-->

