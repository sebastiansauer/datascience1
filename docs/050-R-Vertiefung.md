



# R, zweiter Blick




Benötigte R-Pakete für dieses Kapitel:


```r
library(tidyverse)
library(tidymodels)
```



## Lernsteuerung

<!-- Chapter Start sections: Lernziele, Literatur, Hinweise, ... -->

### Vorbereitung 

- Lesen Sie die Literatur.



### Lernziele 

- Sie können Funktionen, in R schreiben.
- Sie können Datensätze vom Lang- und Breit-Format wechseln.
- Sie können Wiederholungsstrukturen wie Mapping-Funktionen anwenden.
- Sie können eine dplyr-Funktion auf mehrere Spalten gleichzeitig anwenden.



### Literatur 

- Rhys, Kap. 2
- MODAR, Kap. 5



## Objekttypen in R

Näheres zu Objekttypen findet sich in @modar, Kap. 5.2.


### Überblick

In R ist praktisch alles ein Objekt. 
Ein Objekt meint ein im Computerspeicher repräsentiertes Ding, etwa eine Tabelle.


Vektoren und Dataframes (Tibbles) sind die vielleicht gängigsten Objektarten in R (vgl. Abb. \@ref(fig:obs), aus @modar).

<div class="figure" style="text-align: center">
<img src="img/zentrale_objektarten.png" alt="Zentrale Objektarten in R" width="70%" />
<p class="caption">(\#fig:obs)Zentrale Objektarten in R</p>
</div>

Es gibt in R keine (Objekte für) Skalare (einzelne Zahlen).
Stattdessen nutzt R Vektoren der Länge 1.

Ein nützliches Schema stammt aus @r4ds, s. Abb. \@ref(fig:objtypes).

<div class="figure" style="text-align: center">
<img src="https://d33wubrfki0l68.cloudfront.net/1d1b4e1cf0dc5f6e80f621b0225354b0addb9578/6ee1c/diagrams/data-structures-overview.png" alt="Objektarten hierarchisch gegliedert" width="70%" />
<p class="caption">(\#fig:objtypes)Objektarten hierarchisch gegliedert</p>
</div>



### Taxonomie

Unter *homogenen* Objektiven verstehen wir Datenstrukturen, 
die nur eine Art von Daten (wie Text oder Ganze Zahlen) fassen.
Sonstige Objekte nennen wir *heterogen*.


- Homogene Objekte
    - Vektoren 
    - Matrizen
- Heterogen
    - Liste
    - Dataframes (Tibbles)
    
    
    
#### Vektoren

*Vektoren* sind insofern zentral in R,
als dass die übrigen Datenstrukturen auf ihnen aufbauen, vgl. Abb. \@ref(fig:vektorenimzentrum) aus @modar.

Reine (atomare) Vektoren in R sind eine geordnete Liste von Daten eines Typs.

<div class="figure" style="text-align: center">
<img src="img/Datenstrukturen.png" alt="Vektoren stehen im Zentrum der Datenstrukturen in R" width="70%" />
<p class="caption">(\#fig:vektorenimzentrum)Vektoren stehen im Zentrum der Datenstrukturen in R</p>
</div>



```r
ein_vektor <- c(1, 2, 3)
noch_ein_vektor <- c("A", "B", "C")
logischer_vektor <- c(TRUE, FALSE, TRUE)
```


Mit `str()` kann man sich die `Str`uktur eines Objektsausgeben lassen:


```r
str(ein_vektor)
```

```
##  num [1:3] 1 2 3
```

```r
str(noch_ein_vektor)
```

```
##  chr [1:3] "A" "B" "C"
```

```r
str(logischer_vektor)
```

```
##  logi [1:3] TRUE FALSE TRUE
```


Vektoren können von folgenden Typen sein:

- Kommazahlen ( `double`) genannt
- Ganzzahlig (`integer`, auch mit `L` für *Long* abgekürzt)
- Text (´character`, String)
- logische Ausdrücke (`logical` oder `lgl`) mit `TRUE` oder `FALSE`


Kommazahlen und Ganze Zahlen zusammen bilden den Typ `numeric` (numerisch) in R.




```r
knitr::opts_chunk$set(echo = TRUE)
```




Den Typ eines Vektors kann man mit `typeof()` ausgeben lassen:


```r
typeof(ein_vektor)
```

```
## [1] "double"
```



#### Faktoren



```r
sex <- factor(c("Mann", "Frau", "Frau"))
```

Interessant:


```r
str(sex)
```

```
##  Factor w/ 2 levels "Frau","Mann": 2 1 1
```


Vertiefende Informationen findet sich in @r4ds.

#### Listen


```r
eine_liste <- list(titel = "Einführung",
                   woche = 1,
                   datum = c("2022-03-14", "2202-03-21"),
                   lernziele = c("dies", "jenes", "und noch mehr"),
                   lehre = c(TRUE, TRUE, TRUE)
                   )
str(eine_liste)
```

```
## List of 5
##  $ titel    : chr "Einführung"
##  $ woche    : num 1
##  $ datum    : chr [1:2] "2022-03-14" "2202-03-21"
##  $ lernziele: chr [1:3] "dies" "jenes" "und noch mehr"
##  $ lehre    : logi [1:3] TRUE TRUE TRUE
```




#### Tibbles

Für `tibble()` brauchen wir `tidyverse`:


```r
library(tidyverse)
```



```r
studentis <-
  tibble(
    name = c("Anna", "Berta"),
    motivation = c(10, 20),
    noten = c(1.3, 1.7)
  )
str(studentis)
```

```
## tibble [2 × 3] (S3: tbl_df/tbl/data.frame)
##  $ name      : chr [1:2] "Anna" "Berta"
##  $ motivation: num [1:2] 10 20
##  $ noten     : num [1:2] 1.3 1.7
```



### Indizieren

Einen Teil eines Objekts auszulesen, bezeichnen wir als *Indizieren*.


#### Reine Vektoren

Zur Erinnerung:


```r
str(ein_vektor)
```

```
##  num [1:3] 1 2 3
```



```r
ein_vektor[1]
```

```
## [1] 1
```

```r
ein_vektor[c(1,2)]
```

```
## [1] 1 2
```

Aber *nicht* so:


```r
ein_vektor[1,2]
```

```
## Error in ein_vektor[1, 2]: incorrect number of dimensions
```

Man darf Vektoren auch wie Listen ansprechen, also eine doppelte Eckklammer zum Indizieren verwenden


```r
ein_vektor[[2]]
```

```
## [1] 2
```

Der Grund ist,
dass Listen auch Vektoren sind, nur eben ein besonderer Fall eines Vektors:



```r
is.vector(eine_liste)
```

```
## [1] TRUE
```


Was passiert, wenn man bei einem Vektor der Länge 3 das 4. Element indiziert?


```r
ein_vektor[4]
```

```
## [1] NA
```

Ein schnödes `NA` ist die Antwort. Das ist interessant: 
Wir bekommen keine Fehlermeldung, sondern den Hinweis,
das angesprochene Element sei leer bzw. nicht verfügbar.


In @modar, Kap. 5.3.1 findet man weitere Indizierungsmöglichkeiten für reine Vektoren.



#### Listen


```r
eine_liste %>% str()
```

```
## List of 5
##  $ titel    : chr "Einführung"
##  $ woche    : num 1
##  $ datum    : chr [1:2] "2022-03-14" "2202-03-21"
##  $ lernziele: chr [1:3] "dies" "jenes" "und noch mehr"
##  $ lehre    : logi [1:3] TRUE TRUE TRUE
```


Listen können wie Vektoren, also mit `[` ausgelesen werden. 
Dann wird eine Liste zurückgegeben.




```r
eine_liste[1]
```

```
## $titel
## [1] "Einführung"
```

```r
eine_liste[2]
```

```
## $woche
## [1] 1
```

Das hat den technischen Hintergrund,
dass Listen als eine bestimmte Art von Vektoren implementiert sind.


Mann kann auch die "doppelte Eckklammer", `[[` zum Auslesen verwenden;
dann wird anstelle einer Liste die einfachere Struktur eines Vektors zurückgegeben:



```r
eine_liste[[1]]
```

```
## [1] "Einführung"
```

Man könnte sagen,
die "äußere Schicht" des Objekts, die Liste,
wird abgeschält, und man bekommnt die "innere" Schicht,
den Vektor.


Mann die Elemente der Liste entweder mit ihrer Positionsnummer (1, 2, ...) oder,
sofern vorhanden, ihren Namen ansprechen:



```r
eine_liste[["titel"]]
```

```
## [1] "Einführung"
```


Dann gibt es noch den Dollar-Operator,
mit dem Mann benannte Elemente von Listen ansprechen kann:


```r
eine_liste$titel
```

```
## [1] "Einführung"
```

Man kann auch tiefer in eine Liste hinein indizieren.
Sagen wir, uns interessiert das 4. Element der Liste `eine_liste` - 
und davon das erste Element. 

Das geht dann so:


```r
eine_liste[[4]][[1]] 
```

```
## [1] "dies"
```


Eine einfachere Art des Indizierens von Listen bietet die Funktion `pluck()`, aus dem Paket `purrr`,
das Hilfen für den Umgang mit Listen bietet.



```r
pluck(eine_liste, 4)
```

```
## [1] "dies"          "jenes"         "und noch mehr"
```


Und jetzt aus dem 4. Element das 1. Element:


```r
pluck(eine_liste, 4, 1)
```

```
## [1] "dies"
```


Probieren Sie mal, aus einer Liste der Länge 5 das 6. Element auszulesen:


```r
eine_liste %>% length()
```

```
## [1] 5
```


```r
eine_liste[[6]]
```

```
## Error in eine_liste[[6]]: subscript out of bounds
```

Unser Versuch wird mit einer Fehlermeldung quittiert.


Sprechen wir die Liste wie einen (atomaren) Vektor an,
bekommen wir hingegen ein `NA` bzw. ein `NULL`:


```r
eine_liste[6]
```

```
## $<NA>
## NULL
```

#### Tibbles

Tibbles lassen sich sowohl wie ein Vektor als auch wie eine Liste indizieren.



```r
studentis[1]
```

```
## # A tibble: 2 × 1
##   name 
##   <chr>
## 1 Anna 
## 2 Berta
```

Die Indizierung eines Tibbles mit der einfachen Eckklammer liefert einen Tibble zurück.


```r
studentis["name"]
```

```
## # A tibble: 2 × 1
##   name 
##   <chr>
## 1 Anna 
## 2 Berta
```
Mit doppelter Eckklammer bekommt man,
analog zur Liste, 
einen Vektor zurück:


```r
studentis[["name"]]
```

```
## [1] "Anna"  "Berta"
```

Beim Dollar-Operator kommt auch eine Liste zurück:


```r
studentis$name
```

```
## [1] "Anna"  "Berta"
```


### Weiterführende Hinweise

- [Tutorial](https://jennybc.github.io/purrr-tutorial/bk00_vectors-and-lists.html) zum Themen Indizieren von Listen von Jenny BC.


### Indizieren mit dem Tidyverse 

Natürlich kann man auch die Tidyverse-Verben zum Indizieren verwenden.
Das bietet sich an, wenn zwei Bedingungen erfüllt sind:

1. Wenn man einen Tibble als Input und als Output hat
2. Wenn man nicht programmieren möchte



## Datensätze von lang nach breit umformatieren


Manchmal findet man Datensätze im sog. *langen* Format vor,
manchmal im *breiten*.

In der Regel müssen die Daten "tidy" sein,
was meist dem langen Format entspricht, vgl. Abb. \@ref(fig:langbreit) aus @modar.



```r
knitr::include_graphics("img/gather_spread.png")
```

<div class="figure" style="text-align: center">
<img src="img/gather_spread.png" alt="Von lang nach breit und zurück" width="70%" />
<p class="caption">(\#fig:langbreit)Von lang nach breit und zurück</p>
</div>


In einer neueren Version des Tidyverse werden diese beiden Befehle umbenannt bzw. erweitert:

- `gather()` -> `pivot_longer()`
- `spread()` -> `pivot_wider()`

Weitere Informationen findet sich in @r4ds, in [diesem Abschnitt, 12.3](https://r4ds.had.co.nz/tidy-data.html?q=pivot_#pivoting).


## Funktionen

Eine Funktion kann man sich als analog zu einer Variable vorstellen.
Es ist ein Objekt, das nicht Daten, sondern Syntax beinhaltet, 
vgl. Abb. \@ref(fig:funs) aus @modar.


<div class="figure" style="text-align: center">
<img src="img/Funs_def.png" alt="Sinnbild einer Funktion" width="70%" />
<p class="caption">(\#fig:funs)Sinnbild einer Funktion</p>
</div>



```r
mittelwert <- function(x){
  
  summe <- sum(x, na.rm = TRUE)
  mw <- summe/length(x)
  return(mw)
  
}
```


```r
mittelwert(c(1, 2, 3))
```

```
## [1] 2
```



Weitere Informationen finden sich in [Kapitel 19](https://r4ds.had.co.nz/functions.html) in @r4ds. Alternativ findet sich ein Abschnitt dazu (28.1) in @modar.




## Wiederholungen programmieren

Häufig möchte man eine Operation mehrfach ausführen.
Ein Beispiel wäre die Anzahl der fehlenden Werte pro Spalte auslesen.
Natürlich kann man die Abfrage einfach häufig tippen, nervt aber irgendwann.
Daher braucht's Strukturen, die *Wiederholungen* beschreiben.

Dafür gibt es verschiedene Ansätze.

### `across()`

Handelt es sich um Spalten von Tibbles, dann bietet sich die Funktion `across(.col, .fns)` an.
`across` wendet eine oder mehrere Funktionen (mit `.fns` bezeichnet) auf die Spalten `.col` an.

Das erklärt sich am besten mit einem Beispiel:


Natürlich hätte man in diesem Fall auch anders vorgehen können:


```r
mtcars %>% 
  summarise(across(.cols = everything(),
                   .fns = mean))
```

```
##        mpg    cyl     disp       hp     drat      wt     qsec     vs      am
## 1 20.09062 6.1875 230.7219 146.6875 3.596563 3.21725 17.84875 0.4375 0.40625
##     gear   carb
## 1 3.6875 2.8125
```



Möchte man der Funktion `.fns` Parameter übergeben, so nutzt man diese Syntax ("Purrr-Lambda"):


```r
mtcars %>% 
  summarise(across(.cols = everything(),
                   .fns = ~ mean(., na.rm = TRUE)))
```

```
##        mpg    cyl     disp       hp     drat      wt     qsec     vs      am
## 1 20.09062 6.1875 230.7219 146.6875 3.596563 3.21725 17.84875 0.4375 0.40625
##     gear   carb
## 1 3.6875 2.8125
```



[Hier](https://www.rebeccabarter.com/blog/2020-07-09-across/) findet sich ein guter Überblick zu `across()`. 



### `map()`

`map()` ist eine Funktion aus dem R-Paket `purrr` und Teil des Tidyverse.

`map(x, f)` wenden die Funktion `f` auf jedes Element von `x` an.
Ist `x` ein Tibble, so wird `f` demnach auf jede Spalte von `x` angewendet ("zugeordnet", daher `map`), vgl. Abb. \@ref(fig:map1) aus @modar.


<div class="figure" style="text-align: center">
<img src="img/wdh.png" alt="Sinnbild für map" width="70%" />
<p class="caption">(\#fig:map1)Sinnbild für map</p>
</div>


Hier ein Beispiel-Code:


```r
data(mtcars)

mtcars <- mtcars %>% select(1:3)  # nur die ersten 3 Spalten

map(mtcars, mean)
```

```
## $mpg
## [1] 20.09062
## 
## $cyl
## [1] 6.1875
## 
## $disp
## [1] 230.7219
```


Möchte man der gemappten Funktion Parameter übergeben,
nutzt man wieder die "Kringel-Schreibweise":



```r
map(mtcars, ~ mean(., na.rm = TRUE))
```

```
## $mpg
## [1] 20.09062
## 
## $cyl
## [1] 6.1875
## 
## $disp
## [1] 230.7219
## 
## $hp
## [1] 146.6875
## 
## $drat
## [1] 3.596563
## 
## $wt
## [1] 3.21725
## 
## $qsec
## [1] 17.84875
## 
## $vs
## [1] 0.4375
## 
## $am
## [1] 0.40625
## 
## $gear
## [1] 3.6875
## 
## $carb
## [1] 2.8125
```


### Weiterführende Hinweise

Weiteres zu `map()` findet sich z.B. in @r4ds, [Kapitel 21.5](https://r4ds.had.co.nz/iteration.html#the-map-functions) oder in @modar, Kap. 28.2.

[Tutorial](https://jennybc.github.io/purrr-tutorial/ls01_map-name-position-shortcuts.html) zu `map()` von Jenny BC.

## Listenspalten


### Wozu Listenspalten?

Listenspalten sind immer dann sinnvoll,
wenn eine einfache Tabelle nicht komplex genug für unsere Daten ist.

Zwei Fälle stechen dabei ins Auge:

1. Unsere Datenstruktur ist nicht rechteckig
2. In einer Zelle der Tabelle soll mehr als ein einzelner Wert stehen: vielleicht ein Vektor, eine Liste oder eine Tabelle


Der erstere Fall (nicht reckeckig) ließe sich noch einfach lösen,
in dem man mit `NA` auffüllt.

Der zweite Fall verlangt schlichtweg nach komplexeren Datenstrukturen.


[Kap. 25.3](https://r4ds.had.co.nz/many-models.html?q=list#creating-list-columns) aus @r4ds bietet einen guten Einstieg in das Konzept von Listenspalten (list-columns) in R.


### Beispiele für Listenspalten


#### tidymodel

Wenn wir mit `tidymodels` arbeiten,
werden wir mit Listenspalten zu tun haben.
Daher ist es praktisch, sich schon mal damit zu beschäftigen.

Hier ein Beispiel für eine $v=3$-fache Kreuzvalidierung:


```r
library(tidymodels)
mtcars_cv <-
  vfold_cv(mtcars, v = 3)

mtcars_cv
```

```
## #  3-fold cross-validation 
## # A tibble: 3 × 2
##   splits          id   
##   <list>          <chr>
## 1 <split [21/11]> Fold1
## 2 <split [21/11]> Fold2
## 3 <split [22/10]> Fold3
```

Betrachten wir das Objekt `mtcars_cv` näher.
Die Musik spielt in der 1. Spalte.

Lesen wir den Inhalt der 1. Spalte, 1 Zeile aus (nennen wir das mal "Position 1,1"):


```r
pos11 <- mtcars_cv[[1]][[1]]
pos11
```

```
## <Analysis/Assess/Total>
## <21/11/32>
```

In dieser Zelle findet sich eine Aufteilung des Komplettdatensatzes in den Analyseteil (Analysis sample) und den Assessmentteil (Assessment Sample).

Schauen wir jetzt in dieses Objekt näher an.
Das können wir mit `str()` tun.
`str()` zeigt uns die Strktur eines Objekts.


```r
str(pos11)
```

```
## List of 4
##  $ data  :'data.frame':	32 obs. of  11 variables:
##   ..$ mpg : num [1:32] 21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
##   ..$ cyl : num [1:32] 6 6 4 6 8 6 8 4 4 6 ...
##   ..$ disp: num [1:32] 160 160 108 258 360 ...
##   ..$ hp  : num [1:32] 110 110 93 110 175 105 245 62 95 123 ...
##   ..$ drat: num [1:32] 3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
##   ..$ wt  : num [1:32] 2.62 2.88 2.32 3.21 3.44 ...
##   ..$ qsec: num [1:32] 16.5 17 18.6 19.4 17 ...
##   ..$ vs  : num [1:32] 0 0 1 1 0 1 0 1 1 1 ...
##   ..$ am  : num [1:32] 1 1 1 0 0 0 0 0 0 0 ...
##   ..$ gear: num [1:32] 4 4 4 3 3 3 3 4 4 4 ...
##   ..$ carb: num [1:32] 4 4 1 1 2 1 4 2 2 4 ...
##  $ in_id : int [1:21] 1 3 4 5 8 9 10 12 15 16 ...
##  $ out_id: logi NA
##  $ id    : tibble [1 × 1] (S3: tbl_df/tbl/data.frame)
##   ..$ id: chr "Fold1"
##  - attr(*, "class")= chr [1:2] "vfold_split" "rsplit"
```

Oh! `pos11` ist eine Liste, und zwar eine durchaus komplexe.
Wir müssen erkennen,
dass in einer einzelnen Zelle dieses Dataframes viel mehr steht,
als ein Skalar bzw. ein einzelnes, atomares Element.

Damit handelt es sich bei Spalte 1 dieses Dataframes (`mtcars_cv`) also um eine Listenspalte.


Üben wir uns noch etwas im Indizieren.

Sprechen wir in `pos11` das erste Element an (`data`) und davon das erste Element:


```r
pos11[["data"]][[1]]
```

```
##  [1] 21.0 21.0 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 17.8 16.4 17.3 15.2 10.4
## [16] 10.4 14.7 32.4 30.4 33.9 21.5 15.5 15.2 13.3 19.2 27.3 26.0 30.4 15.8 19.7
## [31] 15.0 21.4
```

Wir haben hier die doppelten Eckklammern benutzt, 
um den "eigentlichen" oder "inneren" Vektor zu bekommen, 
nicht die "außen" herumgewickelte Liste.
Zur Erinnerung: 
Ein Dataframe ist ein Spezialfall einer Liste, 
also auch eine Liste, nur eine mit bestimmten Eigenschaften.

Zum Vergleich indizieren wir mal mit einer einfachen Eckklammer:


```r
pos11[["data"]][1] %>% 
  head()
```

```
##                    mpg
## Mazda RX4         21.0
## Mazda RX4 Wag     21.0
## Datsun 710        22.8
## Hornet 4 Drive    21.4
## Hornet Sportabout 18.7
## Valiant           18.1
```


Mit `pluck()` bekommen wir das gleiche Ergebnis, 
nur etwas komfortabler,
da wir keine Eckklammern tippen müssen:


```r
pluck(pos11, "data", 1, 1)
```

```
## [1] 21
```

Wie man sieht, können wir beliebig tief in das Objekt hineinindizieren.



#### Kurs DataScience1

Ein Kurs, wie dieser, kann anhand einer "Deskriptoren" wie Titel der Inhalte, Lernziele, Literatur und so weiter zusammmengefasst werden.
Diese Deskriptoren kann man wiederum jeder Kurswoche oder jedem Kursabschnitt zuordnen, 
so dass eine zweidimensionale Struktur resultiert. 
Eine Tabelle, einfach gesagt, etwa so:




```r
tibble::tribble(
  ~Nr,   ~Titel,   ~Literatur,   ~Aufgaben,
   1L, "Titel1", "Literatur1", "Aufgaben1",
   2L, "Titel2", "Literatur2", "Aufgaben2",
   3L, "Titel3", "Literatur3", "Aufgaben3"
  ) %>% 
  gt::gt()
```

```{=html}
<div id="ffomdulass" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#ffomdulass .gt_table {
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

#ffomdulass .gt_heading {
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

#ffomdulass .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#ffomdulass .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#ffomdulass .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ffomdulass .gt_col_headings {
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

#ffomdulass .gt_col_heading {
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

#ffomdulass .gt_column_spanner_outer {
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

#ffomdulass .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ffomdulass .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ffomdulass .gt_column_spanner {
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

#ffomdulass .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
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

#ffomdulass .gt_empty_group_heading {
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

#ffomdulass .gt_from_md > :first-child {
  margin-top: 0;
}

#ffomdulass .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ffomdulass .gt_row {
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

#ffomdulass .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#ffomdulass .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#ffomdulass .gt_row_group_first td {
  border-top-width: 2px;
}

#ffomdulass .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ffomdulass .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ffomdulass .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ffomdulass .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ffomdulass .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ffomdulass .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ffomdulass .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ffomdulass .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ffomdulass .gt_footnotes {
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

#ffomdulass .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ffomdulass .gt_sourcenotes {
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

#ffomdulass .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ffomdulass .gt_left {
  text-align: left;
}

#ffomdulass .gt_center {
  text-align: center;
}

#ffomdulass .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ffomdulass .gt_font_normal {
  font-weight: normal;
}

#ffomdulass .gt_font_bold {
  font-weight: bold;
}

#ffomdulass .gt_font_italic {
  font-style: italic;
}

#ffomdulass .gt_super {
  font-size: 65%;
}

#ffomdulass .gt_two_val_uncert {
  display: inline-block;
  line-height: 1em;
  text-align: right;
  font-size: 60%;
  vertical-align: -0.25em;
  margin-left: 0.1em;
}

#ffomdulass .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#ffomdulass .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ffomdulass .gt_slash_mark {
  font-size: 0.7em;
  line-height: 0.7em;
  vertical-align: 0.15em;
}

#ffomdulass .gt_fraction_numerator {
  font-size: 0.6em;
  line-height: 0.6em;
  vertical-align: 0.45em;
}

#ffomdulass .gt_fraction_denominator {
  font-size: 0.6em;
  line-height: 0.6em;
  vertical-align: -0.05em;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">Nr</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">Titel</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">Literatur</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">Aufgaben</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_right">1</td>
<td class="gt_row gt_left">Titel1</td>
<td class="gt_row gt_left">Literatur1</td>
<td class="gt_row gt_left">Aufgaben1</td></tr>
    <tr><td class="gt_row gt_right">2</td>
<td class="gt_row gt_left">Titel2</td>
<td class="gt_row gt_left">Literatur2</td>
<td class="gt_row gt_left">Aufgaben2</td></tr>
    <tr><td class="gt_row gt_right">3</td>
<td class="gt_row gt_left">Titel3</td>
<td class="gt_row gt_left">Literatur3</td>
<td class="gt_row gt_left">Aufgaben3</td></tr>
  </tbody>
  
  
</table>
</div>
```


Wie man sieht, entspricht jede Spalte einem Deskriptor des Kurses,
und jede Zeile entspricht einem Thema (oder Woche oder Abschnitt) des Kurses.


Jetzt ist es nur so,
dass einzelne Zellen dieser Tabelle nicht aus nur einem Element bestehen.
So könnte etwa "Aufgaben1" aus mehreren Aufgaben bestehen, 
die jeweils wiederum aus mehreren (Text-)Elementen bestehen. 
Oder "Literatur2" besteht vielleicht aus zwei Literaturquellen.

Kurz gesagt, wir brauchen eine Tabelle,
die erlaubt, in einer Zelle mehr als ein einzelnes Element zu packen.
Listenspalten erlauben das.

Schauen wir uns die "Mastertabelle" dieses Kurses an zur Illustration.

Zunächst `source`n wir die nötigen Funktionen.


```r
source("https://raw.githubusercontent.com/sebastiansauer/Lehre/main/R-Code/render-course-sections.R")
```


In Ihrem `Environment` sollten Sie jetzt die gesourcten Funktionen sehen.
Mit Klick auf den Funktionsnamen können Sie diese Funktionen auch betrachten.

Die Deskriptoren des Kurses speisen sich aus zwei Textdateien, gespeichert im sog. YAML-Format, ein einfaches Textformat, und hier nicht weiter von Belang.

Zum einen eine Datei mit den Datumsangaben:


```r
course_dates_file <- "https://raw.githubusercontent.com/sebastiansauer/datascience1/main/course-dates.yaml"
```


Zum anderen eine Datei mit den Deskriptoren,
die unabhängig vom Datum sind:


```r
content_file <- "https://raw.githubusercontent.com/sebastiansauer/datascience1/main/_modul-ueberblick.yaml"
```


Im [Githup-Repo](https://github.com/sebastiansauer/datascience1) 
dieses Kurses können Sie die Dateien komfortabel betrachten.


Die "Mastertabelle" kann man mit folgender Funktion erstellen:



```r
mastertable <- build_master_course_table(
  course_dates_file =  course_dates_file,
  content_file = content_file)
```

Betrachten Sie die Tabelle in Ruhe!
Sie werden sehen, dass einige Spalten komplex sind, 
also mehr als nur einen einzelnen Wert enthalten:



```r
mastertable[["Vorbereitung"]][[1]]
```

```
## [1] "Lesen Sie die Hinweise zum Modul."                                       
## [2] "Installieren (oder Updaten) Sie die für dieses Modul angegeben Software."
## [3] "Lesen Sie die Literatur."
```


Gerade haben wir aus dem Objekt `mastertable`, ein Dataframe, 
die Spalte mit dem Namen *Vorbereitung*  ausgelesen und aus dieser Spalte das erste erste Element.
Dieses erste Element ist ein Textvektor der Länge 3.

Daraus könnten wir z.B. das zweite Element auslesen:




```r
mastertable[["Vorbereitung"]][[1]][2]
```

```
## [1] "Installieren (oder Updaten) Sie die für dieses Modul angegeben Software."
```


Was würde passieren, wenn wir anstelle der doppelten Eckklammer einfache Eckklammern verwenden würden?




```r
mastertable["Vorbereitung"] %>% class()
```

```
## [1] "tbl_df"     "tbl"        "data.frame"
```

```r
mastertable[["Vorbereitung"]] %>% class()
```

```
## [1] "list"
```

Das macht noch keinen großen Unterschied,
aber schauen wir mal weiter.

Wenn wir das erste Element der Spalte "Vorbereitung" mit *doppelter* Eckklammer ansprechen, 
bekommen wir einen Text-Vektor (der Länge drei) zurück.


```r
mastertable[["Vorbereitung"]][[1]]
```

```
## [1] "Lesen Sie die Hinweise zum Modul."                                       
## [2] "Installieren (oder Updaten) Sie die für dieses Modul angegeben Software."
## [3] "Lesen Sie die Literatur."
```

Jetzt können wir, wie oben getan,
diese einzelnen Elemente ansprechen.


Aber: Wenn wir das erste Element der Spalte "Vorbereitung" mit einfacher Eckklammer ansprechen, bekommen wir eine Liste *mit einem Element* zurück. 


```r
mastertable[["Vorbereitung"]][1]
```

```
## [[1]]
## [1] "Lesen Sie die Hinweise zum Modul."                                       
## [2] "Installieren (oder Updaten) Sie die für dieses Modul angegeben Software."
## [3] "Lesen Sie die Literatur."
```

Wir können also nicht (ohne weiteres "Abschälen") 
z.B. das zweite Element des Text-Vektors ("Installieren Sie...") auslesen:


```r
mastertable[["Vorbereitung"]][1] %>% pluck(2)
```

```
## NULL
```


Wenn Sie sich über `pluck()` wundern, 
Sie hätten synonym auch schreiben können:


```r
mastertable[["Vorbereitung"]][1][2]
```

```
## [[1]]
## NULL
```


Da die Liste nur aus einem Element besteht,
könnten wir z.B. nicht das zweite Element der Liste ansprechen:


```r
mastertable[["Vorbereitung"]][1][[2]]
```

```
## Error in mastertable[["Vorbereitung"]][1][[2]]: subscript out of bounds
```


Haben wir aber die doppelte Eckklammer verwendet,
so bekommen wir einen Vektor der Länge drei zurück (vom Typ Text),
und daher können wir die Elemente 1 bis 3 ansprechen:


```r
mastertable[["Vorbereitung"]][[1]][2]
```

```
## [1] "Installieren (oder Updaten) Sie die für dieses Modul angegeben Software."
```

Dabei ist es egal, ob Sie einfache oder doppelte Eckklammern benutzen,
da Listen auch Vektoren sind.   



### Programmieren mit dem Tidyverse

Das Programmieren mit dem Tidyvers ist nicht ganz einfach und hier nicht näher ausgeführt.
Eine Einführung findet sich z.B. 

- [Tidyeval in fünf Minuten (Video)](https://www.youtube.com/watch?v=nERXS3ssntw)
- In [Kapiteln 17-21 in Advanced R, 2nd Ed](https://adv-r.hadley.nz/)
- Ein Überblicksdiagramm findet sich [hier](https://twitter.com/lapply/status/1493908215796535296/photo/1) [Quelle](https://twitter.com/lapply/status/1493908215796535296?t=P0SbLJAd0Yd97hYPzNMxMg&s=09).









