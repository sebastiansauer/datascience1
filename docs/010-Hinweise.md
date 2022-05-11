---
output: html_document
editor_options: 
  chunk_output_type: console
---

<!-- # (PART) Organisatorisches {-} -->

# Hinweise 






<a href="https://imgflip.com/i/689g8g"><img src="https://i.imgflip.com/689g8g.jpg" width="300" title="made at imgflip.com"/></a><div><a href="https://imgflip.com/memegenerator">from Imgflip Meme Generator</a></div>
















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





## Lernhilfen





### Software

- Installieren Sie [R und seine Freunde](https://data-se.netlify.app/2021/11/30/installation-von-r-und-seiner-freunde/).
- Installieren Sie die folgende R-Pakete:
    - tidyverse
    - tidymodels
    - weitere Pakete werden im Unterricht bekannt gegeben (es schadet aber nichts, jetzt schon Pakete nach eigenem Ermessen zu installieren)
- [R Syntax aus dem Unterricht](https://github.com/sebastiansauer/Lehre) findet sich im Github-Repo bzw. Ordner zum jeweiligen Semester.



### Videos

- [Playlist zu den Themen](https://youtube.com/playlist?list=PLRR4REmBgpIGv1e4hZ8asrL3qVBe5LcKp)
- Auf dem [YouTube-Kanal des Autors](https://www.youtube.com/channel/UCkvdtj8maE7g-SOCh4aDB9g) finden sich eine Reihe von Videos mit Bezug zum Inhalt dieses Buches.



### Online-Zusammenarbeit

Hier finden Sie einige Werkzeuge, 
die das Online-Zusammenarbeiten vereinfachen: 

- [Frag-Jetzt-Raum zum anonymen Fragen stellen während des Unterrichts](https://frag.jetzt/home). Der Keycode wird Ihnen vom Dozenten bereitgestellt.
- [Padlet](https://de.padlet.com/) zum einfachen (und anonymen) Hochladen von Arbeitsergebnissen der Studentis im Unterricht. Wir nutzen es als eine Art Pinwand zum Sammeln von Arbeitsbeiträgen. Die Zugangsdaten stellt Ihnen der Dozent bereit.





## Modulzeitplan












| ID| KW|Datum_Beginn |Titel_Link                                                                                          |
|--:|--:|:------------|:---------------------------------------------------------------------------------------------------|
|  1| 11|2022-03-14   |[Statistisches Lernen](https://sebastiansauer.github.io/datascience1/statistisches-lernen.html)     |
|  2| 12|2022-03-21   |[R, zweiter Blick](https://sebastiansauer.github.io/datascience1/r-zweiter-blick.html)              |
|  3| 13|2022-03-28   |[R, zweiter Blick 2](https://sebastiansauer.github.io/datascience1/r-zweiter-blick-2.html)          |
|  4| 14|2022-04-04   |[tidymodels](https://sebastiansauer.github.io/datascience1/tidymodels.html)                         |
|  5| 15|2022-04-11   |[kNN](https://sebastiansauer.github.io/datascience1/knn.html)                                       |
|  6| 16|2022-04-18   |[Wiederholung](https://sebastiansauer.github.io/datascience1/wiederholung.html)                     |
|  7| 17|2022-04-25   |[Resampling und Tuning](https://sebastiansauer.github.io/datascience1/resampling-und-tuning.html)   |
|  8| 18|2022-05-02   |[Logistische Regression](https://sebastiansauer.github.io/datascience1/logistische-regression.html) |
|  9| 19|2022-05-09   |[Entscheidungsbäume](https://sebastiansauer.github.io/datascience1/entscheidungsbäume.html)         |
| 10| 20|2022-05-16   |[Ensemble-Lerner](https://sebastiansauer.github.io/datascience1/ensemble-lerner.html)               |
| 11| 21|2022-05-23   |[Regularisierung](https://sebastiansauer.github.io/datascience1/regularisierung.html)               |
| 12| 22|2022-05-30   |[Fallstudien](https://sebastiansauer.github.io/datascience1/fallstudien.html)                       |
| 13| 23|2022-06-06   |[Wiederholung](https://sebastiansauer.github.io/datascience1/wiederholung.html)                     |
| 14| 24|2022-06-13   |[GAM](https://sebastiansauer.github.io/datascience1/gam.html)                                       |
| 15| 25|2022-06-20   |[Dimensionsreduktion](https://sebastiansauer.github.io/datascience1/dimensionsreduktion.html)       |
| 16| 26|2022-06-27   |[Vertiefung](https://sebastiansauer.github.io/datascience1/vertiefung.html)                         |





## Literatur

Zentrale Kursliteratur für die theoretischen Konzepte ist @rhys.
Bitte prüfen Sie, ob das Buch in einer Bibliothek verfügbar ist.
Die praktische Umsetzung in R basiert auf @silge_tidy_2022 (dem "Tidymodels-Konzept"); 
das Buch ist frei online verfügbar. 

Eine gute Ergänzung ist das Lehrbuch von @timbers_data_2022,
welches grundlegende Data-Science-Konzepte erläutert und mit tidymodels umsetzt.


@islr haben ein weithin renommiertes und sehr bekanntes Buch verfasst.
Es ist allerdings etwas anspruchsvoller aus @rhys,
daher steht es nicht im Fokus dieses Kurses,
aber einige Schwenker zu Inhalten von @islr gibt es. Schauen Sie mal rein,
das Buch ist gut!

In einigen Punkten ist weiterhin @modar hilfreich; 
das Buch ist über SpringerLink in Ihrer Hochschul-Bibliothek verfügbar. Eine gute Ergänzung ist das "Lab-Buch" von @islrtidy.
In dem Buch wird das Lehrbuch @islr in Tidymodels-Konzepte übersetzt; durchaus nett!








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
    
    













