--- 
title: "DataScience1"
subtitle: Grundlagen der Prognosemodellierung 🔮🧰

  
author: "Sebastian Sauer"
date: "2022-03-17 09:50:05"
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
github-repo: rstudio/bookdown-demo
# description: "Ein Kurs zu den Grundlagen des statistischen Lernens mit einem Fokus auf Prognosemodelle für hoch strukturierte Daten"
---










# Überblick


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

- Dieses Projekt steht unter der [MIT-Lizenz](https://github.com/sebastiansauer/datascience1/blob/main/LICENSE). 





## Lernhilfen





### Software

 Installieren Sie [R und seine Freunde](https://data-se.netlify.app/2021/11/30/installation-von-r-und-seiner-freunde/).
- Installieren Sie die folgende R-Pakete:
    - tidyverse
    - tidymodels
    - weitere Pakete werden im Unterricht bekannt gegeben (es schadet aber nichts, jetzt schon Pakete nach eigenem Ermessen zu installieren)
- [R Syntax aus dem Unterricht](https://github.com/sebastiansauer/Lehre) findet sich im Github-Repo bzw. Ordner zum jeweiligen Semester.



### Videos

- [Playlist zu den Themen](https://youtube.com/playlist?list=PLRR4REmBgpIGv1e4hZ8asrL3qVBe5LcKp)
- 



### Online-Zusammenarbeit

- [Frag-Jetzt-Raum zum anonymen Fragen stellen während des Unterrichts](https://frag.jetzt/home). Der Keycode wird Ihnen vom Dozenten bereitgestellt.
- [Padlet](https://de.padlet.com/) zum einfachen (und anonymen) Hochladen von Arbeitsergebnissen der Studentis im Unterricht. Wir nutzen es als eine Art Pinwand zum Sammeln von Arbeitsbeiträgen. Die Zugangsdaten stellt Ihnen der Dozent bereit.





## Modulzeitplan


Nr. | Kalenderwoche | Datum | Thema
---|---|---|--
1 | 11 | 14.-18.3.22 | Grundkonzepte
2 | 12 | 21.3.-25.3. | tidyverse, 2. Blick
3 | 13 | 28.3.-1.4. | tidymodels
4 | 14 | 4.4.-8.4. | kNN
5 | 15 | 11.4.-15.4. | Statistisches Lernen
6 | 16 | 18.4.-22.4 | Wiederholung
7 | 17 | 25.4.-29.4 | Logistische Regression
8 | 18 | 2.5.-6.5. | Naive Bayes
9 | 19 | 9.5.-13.5. | Entscheidungsbäume
10 | 20 | 16.5.-20.5. | Zufallswälder
11 | 21 | 23.5.-27.5. | Fallstudie
12 | 23 | 6.6.-10.6. | Wiederholung
13 | 24 | 13.6.-17.6. | GAM
14 | 25 | 20.6.-24.6. | Lasso und Co
15 | 26 | 27.6.-1.7. | Vertiefung







## Literatur

Zentrale Kursliteratur für die theoretischen Konzepte ist @rhys.
Bitte prüfen Sie, ob das Buch in einer Bibliothek verfügbar ist.
Die praktische Umsetzung in R basiert auf @silge_tidy_2022 (dem "Tidymodels-Konzept"); 
das Buch ist frei online verfügbar. 
Eine theoretische Konzepte sind @islr entnommen; 
dieser Text ist frei online verfügbar. 
@islr haben ein weithin renommiertes und sehr bekanntes Buch verfasst.
Es ist allerdings etwas anspruchsvoller aus @rhys,
daher steht es nicht im Fokus dieses Kurses,
aber einige Schwenker zu Inhaltesn von @islr gibt es. Schauen Sie mal rein,
das Buch ist gut!

In einigen Punkten ist weiterhin @modar hilfreich; 
das Buch ist über SpringerLink in Ihrer Hochschul-Bibliothek verfügbar. Eine gute Ergänzung ist das "Lab-Buch" von @islrtidy.
In dem Buch wird das Lehrbuch @islr in Tidymodels-Konzepte übersetzt; sehr schön!








## FAQ





- *Folien*
    - Frage: Gibt es ein Folienskript?
    - Antwort: Wo es einfache, gute Literatur gibt, gibt es kein Skript. Wo es keine gute oder keine einfach zugängliche Literatur gibt, dort gibt es ein Skript.
    
- *Englisch*
    - Ist die Literatur auf Englisch?
    - Ja. Allerdings ist die Literatur gut zugänglich. Das Englisch ist nicht schwer. Bedenken Sie: Englisch ist die lingua franca in Wissenschaft und Wirtschaft. Ein solides Verständnis englischer (geschriebener) Sprache ist für eine gute Ausbildung unerlässlich. Zu dem sollte die Kursliteratur fachlich passende und gute Bücher umfassen; oft sind das englische Titel. 
    
- *Anstrengend*
    - Ist der Kurs sehr anstrengend, aufwändig?
    - Der Kurs hat ein mittleres Anspruchsniveau. 
    
- *Mathe*
    - Muss man ein Mathe-Crack sein, um eine gute Note zu erreichen?
    - Nein. Mathe steht nicht im Vordergrund. Schauen Sie sich die Literatur an, sie werden wenig Mathe darin finden.
    
- *Prüfungsliteratur*
    - Welche Literatur ist prüfungsrelevant?
    - Die Prüfung ist angewandt, z.B. ein Prognosewettbewerb. Es wird keine Klausur geben, in der reines Wissen abgefragt wird.


- *Nur R?*
    - Wird nur R in dem Kurs gelehrt? Andere Programmiersprachen sind doch auch wichtig.
    - In der Datenanalyse gibt es zwei zentrale Programmiersprachen, R und Python. Beide sind gut und beide werden viel verwendet. In einer Grundausbildung sollte man sich auf eine Sprache begrenzen, da sonst den Sprachen zu viel Zeit eingeräumt werden muss. Wichtiger als eine zweite Programmiersprache zu lernen, mit der man nicht viel mehr kann als mit der ersten, ist es, die Inhalte des Fachs zu lernen.
    
    










