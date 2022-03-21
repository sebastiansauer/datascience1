# R, zweiter Blick


## Objekttypen in R

Näheres findet sich in @modar, Kap. 5.2.


### Überblick

In R ist praktisch alles ein Objekt. 
Ein Objekt meint ein im Computerspeicher repräsentiertes Ding, etwa eine Tabelle.


Vektoren und Dataframes (Tibbles) sind die vielleicht gängigsten Objektarten in R (vgl. Abb. \@ref(fig:o bjs), aus @modar).


```r
knitr::include_graphics("img/zentrale_objektarten.png")
```

<div class="figure">
<img src="img/zentrale_objektarten.png" alt="Zentrale Objektarten in R" width="472" />
<p class="caption">(\#fig:obs)Zentrale Objektarten in R</p>
</div>

Es gibt in R keine (Objekte für) Skalare (einzelne Zahlen).
Stattdessen nutzt R Vektoren der Länge 1.

Ein nützliches Schema stammt aus @r4ds, s. Abb. \@ref(fig:objtypes).


```r
knitr::include_app("https://d33wubrfki0l68.cloudfront.net/1d1b4e1cf0dc5f6e80f621b0225354b0addb9578/6ee1c/diagrams/data-structures-overview.png")
```

<div class="figure">
<iframe src="https://d33wubrfki0l68.cloudfront.net/1d1b4e1cf0dc5f6e80f621b0225354b0addb9578/6ee1c/diagrams/data-structures-overview.png?showcase=0" width="672" height="400px" data-external="1"></iframe>
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


```r
knitr::include_graphics("img/Datenstrukturen.png")
```

<div class="figure">
<img src="img/Datenstrukturen.png" alt="Vektoren stehen im Zentrum der Datenstrukturen in R" width="568" />
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

- Numerisch (`numeric` auch `double`) genannt
- Ganzzahlig (`integer`, auch mit `L` für *Long* abgekürzt)
- Text (´character`, String)
- logische Ausdrücke (`logical` oder `lgl`) mit `TRUE` oder `FALSE`



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


Mann kann auch die "doppelte Eckklammer", `[[` zum Auslesen verwenden;
dann wird anstelle einer Liste die einfachere Struktur eines Vektors zurückgegeben:



```r
eine_liste[[1]]
```

```
## [1] "Einführung"
```


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

<div class="figure">
<img src="img/gather_spread.png" alt="Von lang nach breit und zurück" width="913" />
<p class="caption">(\#fig:langbreit)Von lang nach breit und zurück</p>
</div>


In einer neueren Version des Tidyverse werden diese beiden Befehle umbenannt bzw. erweitert:

- `gather()` -> `pivot_longer()`
- `spread()` -> `pivot_wider()`

Weitere Informationen findet sich in @r4ds, in [diesem Abschnitt, 12.3](https://r4ds.had.co.nz/tidy-data.html?q=pivot_#pivoting).


## Funktionen

Eine Funktion kann man sich als analog zu einer Variable vorstellen.
Es ist ein Objekt, das nicht Daten, sondern Syntax beinhaltet, 
vgl. Abb. \@ref(fig:fun) aus @modar.



```r
knitr::include_graphics("img/Funs_def.png")
```

<div class="figure">
<img src="img/Funs_def.png" alt="Sinnbild einer Funktion" width="348" />
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
Ist `x` ein Tibble, so wird `f` demnach auf jede Spalte von `x` angewendet ("zugeordnet", daher `map`), vgl. Abb. \@ref(fig:map1).



```r
knitr::include_graphics("img/wdh.png")
```

<div class="figure">
<img src="img/wdh.png" alt="Sinnbild für map" width="616" />
<p class="caption">(\#fig:map1)Sinnbild für map</p>
</div>


Hier ein Beispiel-Code:


```r
data(mtcars)

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


[Kap. 25.3](https://r4ds.had.co.nz/many-models.html?q=list#creating-list-columns) aus @r4ds bietet einen guten Einstieg in das Konzept von Listenspalten (list-columns) in R.



## Literatur

