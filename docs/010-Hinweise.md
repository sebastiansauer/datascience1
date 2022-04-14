
<!-- # (PART) Organisatorisches {-} -->

# Hinweise 






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




```{=html}
<div id="eynqkletge" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#eynqkletge .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#eynqkletge .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#eynqkletge .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#eynqkletge .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#eynqkletge .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#eynqkletge .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#eynqkletge .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#eynqkletge .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#eynqkletge .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#eynqkletge .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#eynqkletge .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#eynqkletge .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#eynqkletge .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#eynqkletge .gt_from_md > :first-child {
  margin-top: 0;
}

#eynqkletge .gt_from_md > :last-child {
  margin-bottom: 0;
}

#eynqkletge .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#eynqkletge .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#eynqkletge .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#eynqkletge .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#eynqkletge .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#eynqkletge .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#eynqkletge .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#eynqkletge .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#eynqkletge .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#eynqkletge .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#eynqkletge .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#eynqkletge .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#eynqkletge .gt_left {
  text-align: left;
}

#eynqkletge .gt_center {
  text-align: center;
}

#eynqkletge .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#eynqkletge .gt_font_normal {
  font-weight: normal;
}

#eynqkletge .gt_font_bold {
  font-weight: bold;
}

#eynqkletge .gt_font_italic {
  font-style: italic;
}

#eynqkletge .gt_super {
  font-size: 65%;
}

#eynqkletge .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 65%;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">Kurswoche</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">KW</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">Titel</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">Datum_Beginn</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">Datum_Ende</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_right">1</td>
<td class="gt_row gt_right">11</td>
<td class="gt_row gt_left">Grundkonzepte</td>
<td class="gt_row gt_left">2022-03-14</td>
<td class="gt_row gt_left">2022-03-20</td></tr>
    <tr><td class="gt_row gt_right">2</td>
<td class="gt_row gt_right">12</td>
<td class="gt_row gt_left">R, 2. Blick</td>
<td class="gt_row gt_left">2022-03-21</td>
<td class="gt_row gt_left">2022-03-27</td></tr>
    <tr><td class="gt_row gt_right">3</td>
<td class="gt_row gt_right">13</td>
<td class="gt_row gt_left">R, 2. Blick - Fortsetzung</td>
<td class="gt_row gt_left">2022-03-28</td>
<td class="gt_row gt_left">2022-04-03</td></tr>
    <tr><td class="gt_row gt_right">4</td>
<td class="gt_row gt_right">14</td>
<td class="gt_row gt_left">tidymodels, 1. Blick</td>
<td class="gt_row gt_left">2022-04-04</td>
<td class="gt_row gt_left">2022-04-10</td></tr>
    <tr><td class="gt_row gt_right">5</td>
<td class="gt_row gt_right">15</td>
<td class="gt_row gt_left">Klassifikation am Beispiel von kNN</td>
<td class="gt_row gt_left">2022-04-11</td>
<td class="gt_row gt_left">2022-04-17</td></tr>
    <tr><td class="gt_row gt_right">6</td>
<td class="gt_row gt_right">16</td>
<td class="gt_row gt_left">Wiederholung</td>
<td class="gt_row gt_left">2022-04-18</td>
<td class="gt_row gt_left">2022-04-24</td></tr>
    <tr><td class="gt_row gt_right">7</td>
<td class="gt_row gt_right">17</td>
<td class="gt_row gt_left">Statistisches Lernen</td>
<td class="gt_row gt_left">2022-04-25</td>
<td class="gt_row gt_left">2022-05-01</td></tr>
    <tr><td class="gt_row gt_right">8</td>
<td class="gt_row gt_right">18</td>
<td class="gt_row gt_left">Logistische Regression</td>
<td class="gt_row gt_left">2022-05-02</td>
<td class="gt_row gt_left">2022-05-08</td></tr>
    <tr><td class="gt_row gt_right">9</td>
<td class="gt_row gt_right">19</td>
<td class="gt_row gt_left">Naive Bayes</td>
<td class="gt_row gt_left">2022-05-09</td>
<td class="gt_row gt_left">2022-05-15</td></tr>
    <tr><td class="gt_row gt_right">10</td>
<td class="gt_row gt_right">20</td>
<td class="gt_row gt_left">Entscheidungsbäume</td>
<td class="gt_row gt_left">2022-05-16</td>
<td class="gt_row gt_left">2022-05-22</td></tr>
    <tr><td class="gt_row gt_right">11</td>
<td class="gt_row gt_right">21</td>
<td class="gt_row gt_left">Zufallswälder</td>
<td class="gt_row gt_left">2022-05-23</td>
<td class="gt_row gt_left">2022-05-29</td></tr>
    <tr><td class="gt_row gt_right">12</td>
<td class="gt_row gt_right">23</td>
<td class="gt_row gt_left">Wiederholung</td>
<td class="gt_row gt_left">2022-06-06</td>
<td class="gt_row gt_left">2022-06-12</td></tr>
    <tr><td class="gt_row gt_right">13</td>
<td class="gt_row gt_right">24</td>
<td class="gt_row gt_left">GAM</td>
<td class="gt_row gt_left">2022-06-13</td>
<td class="gt_row gt_left">2022-06-19</td></tr>
    <tr><td class="gt_row gt_right">14</td>
<td class="gt_row gt_right">25</td>
<td class="gt_row gt_left">Lasso und Co</td>
<td class="gt_row gt_left">2022-06-20</td>
<td class="gt_row gt_left">2022-06-26</td></tr>
    <tr><td class="gt_row gt_right">15</td>
<td class="gt_row gt_right">26</td>
<td class="gt_row gt_left">Vertiefung</td>
<td class="gt_row gt_left">2022-06-27</td>
<td class="gt_row gt_left">2022-07-03</td></tr>
  </tbody>
  
  
</table>
</div>
```





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
    
    













