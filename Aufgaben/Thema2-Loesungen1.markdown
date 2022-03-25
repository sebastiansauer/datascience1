1.  **Aufgabe**\

    Schreiben Sie eine Funktion, mit folgendem Algorithmus, wobei ein
    beliebiger Vektor als Eingabe verlangt wird.

    1.  Zähle die Anzahl verschiedener Werte.
    2.  Wenn es nur zwei verschiedene Werte gibt, gebe `TRUE` zurück,
        ansonsten `FALSE`.

    Hinweise:

    -   Wählen Sie einen treffenden Namen für Ihre Funktion (nutzen Sie
        am besten ein konsistentes Namensschema).
    -   Wichtigster Tipp: Googeln :-)
    -   Verschiedene Werte eines Vektors gibt die Funktion `unique()`
        zurück.
    -   Vermutlich gibt es schon viele Lösungen (Implementierungen) für
        diese Funktion. Ist nur als Übung gedacht :-)

    \
    **Lösung**

    ``` text
    has_two_levels <- function(vec){
      
      # input: vector of any type
      # value: number of unique values (double)
      
      tmp <- length(unique(vec))
      tmp == 2
    }
    ```

    `levels` ist ein Ausdruck, der nahelegt, dass es sich um
    *verschiedene* Werte ("Ausprägungen" oder "Stufen") handelt.

    Alternativ könnte man die Funktion auch so schreiben:

    ``` text
    has_two_values <- function(vec){
      
      # input: vector of any type
      # value: number of unique values (double)
      
      step1 <- unique(vec)
      step2 <- length(step1)
      step3 <- if(step2 == 2) {
        out <- TRUE
      } else {
        out <- FALSE
      }
      
      out <- step2
      return(out)
      
    }
    ```

    Das ist expliziter, aber länger.

    Wenn man es genau nimmt, heißt *binär*, dass es nur die Werte `0`
    und `1` gibt. Das ist ein strengeres Kriterium, wie dass es zwei
    beliebigen verschiedene Werte gibt (s. unten dazu ein Vorschlag).

    Testen wir unsere Funktion, Test 1:

    ``` text
    x <- c(1,2, 3, 3, 3, 1)
    x2 <- c("A", "B")


    has_two_levels(x2)
    ```

        ## [1] TRUE

    ``` text
    has_two_levels(x)
    ```

        ## [1] FALSE

    Test 2:

    ``` text
    data(mtcars)
    ```

    Wir wenden unsere neue Funktion mit Tidyverse-Methoden an:

    ``` text
    mtcars %>% 
      summarise(am_has_two_values = has_two_levels(am),
                mpg_has_two_values = has_two_levels(mpg))
    ```

        ##   am_has_two_values mpg_has_two_values
        ## 1              TRUE              FALSE

    Bonus!

    Verwenden Sie `across()` (`{dplyr}`), um alle Spalten von `mtcars`
    mit `has_two_levels()` zu überprüfen.

    ``` text
    mtcars %>% 
      summarise(across(everything(),
                       has_two_levels))
    ```

        ##     mpg   cyl  disp    hp  drat    wt  qsec   vs   am  gear
        ## 1 FALSE FALSE FALSE FALSE FALSE FALSE FALSE TRUE TRUE FALSE
        ##    carb
        ## 1 FALSE

    Kann man auch so schreiben:

    ``` text
    mtcars %>% 
      summarise(across(everything(),
                       ~ has_two_levels(.)))
    ```

        ##     mpg   cyl  disp    hp  drat    wt  qsec   vs   am  gear
        ## 1 FALSE FALSE FALSE FALSE FALSE FALSE FALSE TRUE TRUE FALSE
        ##    carb
        ## 1 FALSE

    Bonus-Bonus:

    So könnte man eine Funktion schreiben, die prüft, ob die
    Ausprägungen eines Vektors binär sind, d.h. nur `0` oder `1`:

    ``` text
    is_binary <- function(var){
      return(all(var %in% c(0,1)))
    }
    ```

2.  **Aufgabe**\

    Schreiben Sie eine Funktion zur Berechnung der Anzahl der fehlenden
    Werte in einem (numerischen) Vektor!

    Hinweise:

    -   Wählen Sie einen treffenden Namen für Ihre Funktion (nutzen Sie
        am besten ein konsistentes Namensschema).

    \
    **Lösung**

    ``` text
    na_n <- function(num_vec) {
      # input: num. vector (int or double)
      # value: count of missing values (double)
      
      if (!is.numeric(num_vec)) stop("Numeric input is needed!")
      out <- sum(is.na(num_vec))
      return(out)
      
    }
    ```

    Test:

    ``` text
    x <- c(1,2, NA, NA)
    x2 <- c("A", "B", NA)

    na_n(x)
    ```

        ## [1] 2

    Bei `x2` sollte ein Fehler aufgeworfen werden:

    ``` text
    na_n(x2)
    ```

        ## Error in na_n(x2): Numeric input is needed!

    Gut!

    Testen wir weiter, jetzt mit dem Datensatz `mtcars`:

    ``` text
    mtcars[1, c(1,2,3,4)] <- NA  # Zeilen/Spalte

    mtcars %>% 
      summarise(mpg_na_n = na_n(mpg))
    ```

        ##   mpg_na_n
        ## 1        1

    BONUS!

    Verwenden Sie `across()`, um die fehlenden Werte in allen Spalten
    von `mtcars` zu zählen.

    Wer schnell ist, der nehme gerne `nycflights13::flights` (aus dem
    Paket `{nycflights13}` oder per CSV-Datei aus geeigneter Stelel aus
    dem Internet. Meistens geht es schneller, die Daten aus einem Paket
    zu laden mit `data(flights)` nachdem man `library(nycflights13)`
    geschrieben hat).

    ``` text
    mtcars %>% 
      summarise(across(everything(), na_n)) 
    ```

        ##   mpg cyl disp hp drat wt qsec vs am gear carb
        ## 1   1   1    1  1    0  0    0  0  0    0    0

    Mit `pivot_longer()` ist es häufig übersichtlicher bzw. besser für
    weitere Bearbeitungsschritte, wie das folgende Beispiel zeigt:

    ``` text
    mtcars %>% 
      summarise(across(everything(), na_n)) %>% 
      pivot_longer(everything()) %>% 
      filter(value > 0)
    ```

        ## # A tibble: 4 × 2
        ##   name  value
        ##   <chr> <int>
        ## 1 mpg       1
        ## 2 cyl       1
        ## 3 disp      1
        ## 4 hp        1

    `flights`:

    ``` text
    data(flights, package = "nycflights13")

    flights %>% 
      select(where(is.numeric)) %>% 
      summarise(across(everything(),
                       na_n)) %>% 
      pivot_longer(everything()) %>% 
      arrange(-value) %>%  # Sortiere absteigend nach Anzahl der fehlenden Werte
      filter(value > 0)  # Zeige nur Variablen mit fehlenden Werten
    ```

        ## # A tibble: 5 × 2
        ##   name      value
        ##   <chr>     <int>
        ## 1 arr_delay  9430
        ## 2 air_time   9430
        ## 3 arr_time   8713
        ## 4 dep_time   8255
        ## 5 dep_delay  8255
