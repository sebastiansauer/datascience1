# tidymodels




Benötigte R-Pakete für dieses Kapitel:


```r
library(tidyverse)
library(tidymodels)
```





## Daten

Dieser Abschnitt bezieht sich auf [Kapitel 4](https://www.tmwr.org/ames.html) in @silge_tidy_2022.




Wir benutzen den Datensatz zu Immobilienpreise aus dem [Ames County](https://en.wikipedia.org/wiki/Ames,_Iowa) in Iowa, USA,
gelegen im Zentrum des Landes.


```r
data(ames)  # Daten wurden über tidymodels mit geladen
ames <- ames %>% mutate(Sale_Price = log10(Sale_Price))
```


Hier wurde die AV log-transformiert.
Das hat zwei (wichtige) Effekte:

1. Die Verteilung ist symmetrischer, näher an der Normalverteilung. Damit gibt es mehr Daten im Hauptbereich des Ranges von `Sale_Price`, was die Vorhersagen stabiler machen dürfte.
2. Logarithmiert man die Y-Variable, so kommt dies [einem multiplikativen Modell gleich](https://sebastiansauer.github.io/2021-sose/QuantMeth1/Vertiefung/Log-Log-Regression.html#19), s. auch [hier](https://data-se.netlify.app/2021/06/17/ein-beispiel-zum-nutzen-einer-log-transformation/).





## Train- vs Test-Datensatz aufteilen


Dieser Abschnitt bezieht sich auf [Kapitel 5](https://www.tmwr.org/splitting.html) in @silge_tidy_2022.


:::: {.infobox .quote}
Das Aufteilen in Train- und Test-Datensatz ist einer der wesentlichen Grundsätze im maschinellen Lernen. Das Ziel ist, Overfitting abzuwenden.
:::

Im Train-Datensatz werden alle Modelle berechnet.
Der Test-Datensatz wird nur *einmal* verwendet, und zwar zur Überprüfung der Modellgüte.


<!-- [![](https://mermaid.ink/img/pako:eNo9jDEOwjAMRa9ieW4RYkKZ4QTt6MVqDERK0ip1KqGqd8e0Ak_fz-97xWH0gg6nIKBBo0BfOOQWlvkEvczadpymKJTBhnC_EoKD6_nPTNvRxRBlbDBJSRy8_V2_EqG-JAmhs-jlwTVagfJmap08q9x90LGg01KlQa46du88_PbDuQV-Fk4H3D5jVDy8)](https://mermaid.live/edit#pako:eNo9jDEOwjAMRa9ieW4RYkKZ4QTt6MVqDERK0ip1KqGqd8e0Ak_fz-97xWH0gg6nIKBBo0BfOOQWlvkEvczadpymKJTBhnC_EoKD6_nPTNvRxRBlbDBJSRy8_V2_EqG-JAmhs-jlwTVagfJmap08q9x90LGg01KlQa46du88_PbDuQV-Fk4H3D5jVDy8) -->

<!-- [Quelle](https://gist.github.com/sebastiansauer/be53bfc193fd3c144a430b7d3b922310) -->

<img src="chunk-img/tidymodelsunnamed-chunk-4-1.png" width="100%" height="200px" style="display: block; margin: auto;" />



Praktisch funktioniert das in @silge_tidy_2022 wie folgt.

Wir laden die Daten und erstellen einen Index,
der jeder Beobachtung die Zuteilung zu Train- bzw. zum Test-Datensatz zuweist:


```r
ames_split <- initial_split(ames, prop = 0.80, strata = Sale_Price)
```

`initial_split()` speichert für spätere komfortable Verwendung auch die Daten.
Aber eben auch der Index, der bestimmt, welche Beobachtung im Train-Set landet:


```r
ames_split$in_id %>% head(n = 10)
```

```
##  [1]  2 28 30 32 33 35 78 79 83 84
```

```r
length(ames_split$in_id)
```

```
## [1] 2342
```

Praktisch ist auch,
dass die AV-Verteilung in beiden Datensätzen ähnlich gehalten wird (Stratifizierung),
das besorgt das Argument `strata`.


Die eigentlich Aufteilung in die zwei Datensätze geht dann so:


```r
ames_train <- training(ames_split)
ames_test  <-  testing(ames_split)
```



## Grundlagen der Modellierung mit tidymodels

Dieser Abschnitt bezieht sich auf [Kapitel 6](https://www.tmwr.org/models.html) in @silge_tidy_2022.




`tidymodels` ist eine Sammlung mehrerer, zusammengehöriger Pakete,
eben zum Thema statistische Modellieren.

Das kann man analog zur Sammlung `tidyverse` verstehen,
zu der z.B. das R-Paket `dplyr` gehört.


Das R-Paket innerhalb von `tidymodels`, das zum "Fitten" von Modellen zuständig ist, heißt [parsnip](https://parsnip.tidymodels.org/).

Eine Liste der verfügbaren Modelltypen, Modellimplementierungen und Modellparameter, die in Parsnip aktuell unterstützt werden, findet sich [hier](https://www.tidymodels.org/find/parsnip/).



### Modelle spezifizieren





Ein (statistisches) Modell wird in Tidymodels mit drei Elementen spezifiziert, vgl. Abb. \@ref(fig:tidymodels-def).

<div class="figure" style="text-align: center">

```{=html}
<div id="htmlwidget-bb7edd9febb3524d68de" style="width:100%;height:300px;" class="nomnoml html-widget"></div>
<script type="application/json" data-for="htmlwidget-bb7edd9febb3524d68de">{"x":{"code":"\n#fill: #FEFEFF\n#lineWidth: 1\n#zoom: 4\n#direction: right\n\n#direction: leftright\n[Modell|\n  [type (Algorithmus)|\n    [Regression] \n    [Neuronale Netze] \n    [...]\n  ]  \n  [engine (Implementierung)|\n    [lm]\n    [stan_glm]\n    [...]\n  ]\n  [mode (modus)|\n    [regression]\n    [classification]\n  ]\n  \n]\n","svg":false},"evals":[],"jsHooks":[]}</script>
```

<p class="caption">(\#fig:tidymodels-def)Definition eines Models in tidymodels</p>
</div>


Die Definition eines Modells in tidymodels folgt diesen Ideen:


1. Das Modell sollte unabhängig von den Daten spezifiziert sein
2. Das Modell sollte unabhängig von den Variablen (AV, UVs) spezifiziert sein
3. Das Modell sollte unabhängig von etwaiger Vorverarbeitung (z.B. z-Transformation) spezifiziert sein


Da bei einer linearen Regression nur der Modus "Regression" möglich ist,
muss der Modus in diesem Fall nicht angegeben werden.
Tidymodels erkennt das automatisch.


```r
lm_model <-   
  linear_reg() %>%   # Algorithmus, Modelltyp
  set_engine("lm")  # Implementierung
  # Modus hier nicht nötig, da lineare Modelle immer numerisch klassifizieren
```


### Modelle berechnen


Nach @rhys ist ein Modell sogar erst ein Modell,
wenn die Koeffizienten berechnet sind.
Tidymodels kennt diese Unterscheidung nicht.
Stattdessen spricht man in Tidymodels von einem "gefitteten" Modell,
sobald es berechnet ist.
Ähnlich fancy könnte man von einem "instantiierten" Modell sprechen.

Für das Beispiel der einfachen linearen Regression heißt das,
das Modell ist gefittet, 
sobald die Steigung und der Achsenabschnitt (sowie die Residualstreuung) 
berechnet sind.



```r
lm_form_fit <- 
  lm_model %>% 
  fit(Sale_Price ~ Longitude + Latitude, data = ames_train)
```


### Vorhersagen

Im maschinellen Lernen ist man primär an den Vorhersagen interessiert,
häufig nur an Punktschätzungen.
Schauen wir uns also zunächst diese an.


Vorhersagen bekommt man recht einfach mit der `predict()` Methode:


```r
predict(lm_form_fit, new_data = ames_test) %>% 
  head()
```

```
## # A tibble: 6 × 1
##   .pred
##   <dbl>
## 1  5.29
## 2  5.24
## 3  5.24
## 4  5.24
## 5  5.32
## 6  5.32
```


Die Syntax lautet `predict(modell, daten_zum_vorhersagen)`.

### Vorhersagen im Train-Datensatz

Vorhersagen im Train-Datensatz machen keinen Sinn,
da sie nicht gegen Overfitting geschützt sind und daher deutlich zu optimistisch sein können.

Bei einer linearen Regression ist diese Gefahr nicht so hoch,
aber bei anderen, flexibleren Modellen, ist diese Gefahr absurd groß.


### Modellkoeffizienten im Train-Datensatz


Gibt man den Namen des Modellobjekts ein,
so wird ein Überblick an relevanten Modellergebnissen am Bildschirm gedruckt:



```r
lm_form_fit
```

```
## parsnip model object
## 
## 
## Call:
## stats::lm(formula = Sale_Price ~ Longitude + Latitude, data = data)
## 
## Coefficients:
## (Intercept)    Longitude     Latitude  
##    -316.432       -2.111        2.949
```

Innerhalb des Ergebnisobjekts findet sich eine Liste namens `fit`,
in der die Koeffizienten (der "Fit") abgelegt sind:


```r
lm_form_fit %>% pluck("fit")
```

```
## 
## Call:
## stats::lm(formula = Sale_Price ~ Longitude + Latitude, data = data)
## 
## Coefficients:
## (Intercept)    Longitude     Latitude  
##    -316.432       -2.111        2.949
```

Zum Herausholen dieser Infos kann man auch die Funktion `extract_fit_engine()` verwenden:



```r
lm_fit <-
  lm_form_fit %>% 
  extract_fit_engine()

lm_fit
```

```
## 
## Call:
## stats::lm(formula = Sale_Price ~ Longitude + Latitude, data = data)
## 
## Coefficients:
## (Intercept)    Longitude     Latitude  
##    -316.432       -2.111        2.949
```

Das extrahierte Objekt ist, in diesem Fall, 
das typische `lm()` Objekt.
Entsprechend kann man daruaf `coef()` oder `summary()` anwenden.



```r
coef(lm_fit)
```

```
## (Intercept)   Longitude    Latitude 
## -316.432218   -2.111054    2.949206
```

```r
summary(lm_fit)
```

```
## 
## Call:
## stats::lm(formula = Sale_Price ~ Longitude + Latitude, data = data)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -1.02055 -0.09657 -0.01778  0.10125  0.57462 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)    
## (Intercept) -316.4322    14.4596  -21.88   <2e-16 ***
## Longitude     -2.1111     0.1298  -16.27   <2e-16 ***
## Latitude       2.9492     0.1806   16.33   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.1617 on 2339 degrees of freedom
## Multiple R-squared:  0.1821,	Adjusted R-squared:  0.1814 
## F-statistic: 260.3 on 2 and 2339 DF,  p-value: < 2.2e-16
```

Schicker sind die Pendant-Befehle aus `broom`,
die jeweils einen Tibble zuückliefern:



```r
library(broom)
tidy(lm_fit) # Koeffizienten
```

```
## # A tibble: 3 × 5
##   term        estimate std.error statistic  p.value
##   <chr>          <dbl>     <dbl>     <dbl>    <dbl>
## 1 (Intercept)  -316.      14.5       -21.9 9.86e-97
## 2 Longitude      -2.11     0.130     -16.3 1.82e-56
## 3 Latitude        2.95     0.181      16.3 7.12e-57
```

```r
glance(lm_fit) # Modellgüte
```

```
## # A tibble: 1 × 12
##   r.squared adj.r.squared sigma statistic   p.value    df logLik    AIC    BIC
##       <dbl>         <dbl> <dbl>     <dbl>     <dbl> <dbl>  <dbl>  <dbl>  <dbl>
## 1     0.182         0.181 0.162      260. 8.39e-103     2   946. -1884. -1861.
## # … with 3 more variables: deviance <dbl>, df.residual <int>, nobs <int>
```


### Parsnip RStudio add-in

Mit dem Add-in von Parsnip kann man sich eine Modellspezifikation per Klick ausgeben lassen. 
Nett!


```r
parsnip_addin()
```



## Workflows

Dieser Abschnitt bezieht sich auf [Kapitel 7](https://www.tmwr.org/workflows.html) in @silge_tidy_2022.


### Konzept des Workflows in Tidymodels

<div class="figure" style="text-align: center">

```{=html}
<div id="htmlwidget-b334af3c1b8ba2174b5d" style="width:100%;height:500px;" class="nomnoml html-widget"></div>
<script type="application/json" data-for="htmlwidget-b334af3c1b8ba2174b5d">{"x":{"code":"\n#fill: #FEFEFF\n#lineWidth: 1\n#zoom: 4\n#direction: right\n\n\n[Workflow|\n  [preprocessing|\n   Vorverarbeitung;\n   Imputation;\n   Transformation;\n   Prädiktorwahl\n   AV-Wahl\n   ...\n  \n  ]\n  [fitting |\n    Modell berechnen\n    ...\n  ]\n  [postprocessing|\n    Grenzwerte für Klass. festlegen\n    ...\n  ]\n]\n","svg":false},"evals":[],"jsHooks":[]}</script>
```

<p class="caption">(\#fig:tidymodels-workflow)Definition eines Models in tidymodels</p>
</div>


### Einfaches Beispiel

Wir initialisieren einen Workflow,
verzichten auf Vorverarbeitung und fügen ein Modell hinzu:



```r
lm_workflow <- 
  workflow() %>%  # init
  add_model(lm_model) %>%   # Modell hinzufügen
  add_formula(Sale_Price ~ Longitude + Latitude)  # Modellformel hinzufügen
```




Werfen wir einen Blick in das Workflow-Objekt:


```r
lm_workflow
```

```
## ══ Workflow ════════════════════════════════════════════════════════════════════
## Preprocessor: Formula
## Model: linear_reg()
## 
## ── Preprocessor ────────────────────────────────────────────────────────────────
## Sale_Price ~ Longitude + Latitude
## 
## ── Model ───────────────────────────────────────────────────────────────────────
## Linear Regression Model Specification (regression)
## 
## Computational engine: lm
```

Wie man sieht,
gehört die Modellformel (`y ~ x`) zur Vorverarbeitung 
aus Sicht von Tidymodels.


Was war nochmal im Objekt `lm_model` enthalten?


```r
lm_model
```

```
## Linear Regression Model Specification (regression)
## 
## Computational engine: lm
```


Jetzt können wir das Modell berechnen (fitten):



```r
lm_fit <- 
  lm_workflow %>%
  fit(ames_train)
```

Natürlich kann man synonym auch schreiben:


```r
lm_fit <- fit(lm_wflow, ames_train)
```


Schauen wir uns das Ergebnis an:


```r
lm_fit
```

```
## ══ Workflow [trained] ══════════════════════════════════════════════════════════
## Preprocessor: Formula
## Model: linear_reg()
## 
## ── Preprocessor ────────────────────────────────────────────────────────────────
## Sale_Price ~ Longitude + Latitude
## 
## ── Model ───────────────────────────────────────────────────────────────────────
## 
## Call:
## stats::lm(formula = ..y ~ ., data = data)
## 
## Coefficients:
## (Intercept)    Longitude     Latitude  
##    -316.432       -2.111        2.949
```


### Vorhersage mit einem Workflow

Die Vorhersage mit einem Tidymodels-Workflow ist einerseits komfortabel,
da man einfach sagen kann:

"Nimm die richtigen Koeffizienten des Modells aus dem Train-Set
und wende sie auf das Test-Sample an. Berechne mir
die Vorhersagen und die Modellgüte."

So sieht das aus:


```r
final_lm_res <- last_fit(lm_workflow, ames_split)
final_lm_res
```

```
## # Resampling results
## # Manual resampling 
## # A tibble: 1 × 6
##   splits             id               .metrics .notes   .predictions .workflow 
##   <list>             <chr>            <list>   <list>   <list>       <list>    
## 1 <split [2342/588]> train/test split <tibble> <tibble> <tibble>     <workflow>
```

Anderseits wird auch ein recht komplexes Objekt zurückgeliefert,
das man erst mal durchschauen muss.

Wie man sieht, gibt es mehrere Listenspalten.
Besonders interessant erscheinen natürlich die Listenspalten `.metrics` und `.predictions`.

Schauen wir uns die Vorhersagen an.


```r
lm_preds <- final_lm_res %>% pluck(".predictions", 1)
```

Es gibt auch eine Funktion, die obige Zeile vereinfacht (also synonym ist):


```r
lm_preds <- collect_predictions(final_lm_res)
lm_preds %>% slice_head(n = 5)
```

```
## # A tibble: 5 × 5
##   id               .pred  .row Sale_Price .config             
##   <chr>            <dbl> <int>      <dbl> <chr>               
## 1 train/test split  5.29     5       5.28 Preprocessor1_Model1
## 2 train/test split  5.24    19       5.15 Preprocessor1_Model1
## 3 train/test split  5.24    27       5.10 Preprocessor1_Model1
## 4 train/test split  5.24    31       5.02 Preprocessor1_Model1
## 5 train/test split  5.32    39       5.60 Preprocessor1_Model1
```


### Modellgüte


Dieser Abschnitt bezieht sich auf [Kapitel 9](https://www.tmwr.org/performance.html) in @silge_tidy_2022.



Die Vorhersagen bilden die Basis für die Modellgüte ("Metriken"),
die schon fertig berechnet im Objekt `final_lm_res` liegen und mit
`collect_metrics` herausgenommen werden können:


```r
lm_metrics <- collect_metrics(final_lm_res)
```



```{=html}
<div id="ltsnituplc" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#ltsnituplc .gt_table {
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

#ltsnituplc .gt_heading {
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

#ltsnituplc .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#ltsnituplc .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#ltsnituplc .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ltsnituplc .gt_col_headings {
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

#ltsnituplc .gt_col_heading {
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

#ltsnituplc .gt_column_spanner_outer {
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

#ltsnituplc .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ltsnituplc .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ltsnituplc .gt_column_spanner {
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

#ltsnituplc .gt_group_heading {
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

#ltsnituplc .gt_empty_group_heading {
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

#ltsnituplc .gt_from_md > :first-child {
  margin-top: 0;
}

#ltsnituplc .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ltsnituplc .gt_row {
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

#ltsnituplc .gt_stub {
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

#ltsnituplc .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ltsnituplc .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#ltsnituplc .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ltsnituplc .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ltsnituplc .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ltsnituplc .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ltsnituplc .gt_footnotes {
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

#ltsnituplc .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#ltsnituplc .gt_sourcenotes {
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

#ltsnituplc .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#ltsnituplc .gt_left {
  text-align: left;
}

#ltsnituplc .gt_center {
  text-align: center;
}

#ltsnituplc .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ltsnituplc .gt_font_normal {
  font-weight: normal;
}

#ltsnituplc .gt_font_bold {
  font-weight: bold;
}

#ltsnituplc .gt_font_italic {
  font-style: italic;
}

#ltsnituplc .gt_super {
  font-size: 65%;
}

#ltsnituplc .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 65%;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">.metric</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">.estimator</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">.estimate</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">.config</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left">rmse</td>
<td class="gt_row gt_left">standard</td>
<td class="gt_row gt_right">1.59 &times; 10<sup class='gt_super'>&minus;1</sup></td>
<td class="gt_row gt_left">Preprocessor1_Model1</td></tr>
    <tr><td class="gt_row gt_left">rsq</td>
<td class="gt_row gt_left">standard</td>
<td class="gt_row gt_right">1.33 &times; 10<sup class='gt_super'>&minus;1</sup></td>
<td class="gt_row gt_left">Preprocessor1_Model1</td></tr>
  </tbody>
  
  
</table>
</div>
```


Man kann auch angeben, 
welche Metriken der Modellgüte man bekommen möchte:


```r
ames_metrics <- metric_set(rmse, rsq, mae)
```


```r
ames_metrics(data = lm_preds, 
             truth = Sale_Price, 
             estimate = .pred)
```

```
## # A tibble: 3 × 3
##   .metric .estimator .estimate
##   <chr>   <chr>          <dbl>
## 1 rmse    standard       0.159
## 2 rsq     standard       0.133
## 3 mae     standard       0.119
```



### Vorhersage von Hand


Man kann sich die Metriken auch von Hand ausgeben lassen,
wenn man direktere Kontrolle haben möchte als mit `last_fit` und `collect_metrics`.


```r
ames_test_small <- ames_test %>% slice(1:5)
predict(lm_form_fit, new_data = ames_test_small)
```

```
## # A tibble: 5 × 1
##   .pred
##   <dbl>
## 1  5.29
## 2  5.24
## 3  5.24
## 4  5.24
## 5  5.32
```

Jetzt binden wir die Spalten zusammen, also die "Wahrheit" ($y$) und die Vorhersagen:



```r
ames_test_small2 <- 
  ames_test_small %>% 
  select(Sale_Price) %>% 
  bind_cols(predict(lm_form_fit, ames_test_small)) %>% 
  # Add 95% prediction intervals to the results:
  bind_cols(predict(lm_form_fit, ames_test_small, type = "pred_int")) 
```




```r
rsq(ames_test_small2, 
   truth = Sale_Price,
   estimate = .pred
   )
```

```
## # A tibble: 1 × 3
##   .metric .estimator .estimate
##   <chr>   <chr>          <dbl>
## 1 rsq     standard       0.930
```

Andere Koeffizienten der Modellgüte können mit `rmse` oder `mae` abgerufen werden.


## Rezepte zur Vorverarbeitung


Dieser Abschnitt bezieht sich auf [Kapitel 8](https://www.tmwr.org/recipes.html) in @silge_tidy_2022.

### Was ist Rezept und wozu ist es gut?

So könnte ein typischer Aufruf von `lm()` aussehen:


```r
lm(Sale_Price ~ Neighborhood + log10(Gr_Liv_Area) + Year_Built + Bldg_Type, data = ames)
```

Neben dem Fitten des Modells besorgt die Formel-Schreibweise noch einige zusätzliche nützliche Vorarbeitung:


1. Definition von AV und AV
2. Log-Transformation von `Gr_Liv_Area`
3. Transformation der nominalen Variablen in Dummy-Variablen


Das ist schön und nütlich, hat aber auch Nachteile:


1. Das Modell wird nicht nur spezifiziert, sondern auch gleich berechnet. Das ist unpraktisch, weil man die Modellformel vielleicht in anderen Modell wiederverwenden möchte. Außerdem kann das Berechnen lange dauern.
2. Die Schritte sind ineinander vermengt, so dass man nicht einfach und übersichtlich die einzelnen Schritte bearbeiten kann.


Praktischer wäre also, die Schritte der Vorverarbeitung zu ent-flechten.
Das geht mit einem "Rezept" aus Tidmoodels:


```r
simple_ames <- 
  recipe(Sale_Price ~ Neighborhood + Gr_Liv_Area + Year_Built + Bldg_Type,
         data = ames_train) %>%
  step_log(Gr_Liv_Area, base = 10) %>% 
  step_dummy(all_nominal_predictors())
simple_ames
```

```
## Recipe
## 
## Inputs:
## 
##       role #variables
##    outcome          1
##  predictor          4
## 
## Operations:
## 
## Log transformation on Gr_Liv_Area
## Dummy variables from all_nominal_predictors()
```


:::: {.infobox .quote}
Ein Rezept berechnet kein Modell. Es macht nichts außer die Vorverarbeitung des Modells zu spezizifieren (inklusive der Modellformel).
:::



### Workflows mit Rezepten

Jetzt definieren wir den Workflow nicht nur mit einer Modellformel,
sondern mit einem Rezept:


```r
lm_workflow <-
  workflow() %>% 
  add_model(lm_model) %>% 
  add_recipe(simple_ames)
```


Sonst hat sich nichts geändert.



Wie vorher, können wir jetzt das Modell berechnen.



```r
lm_fit <- fit(lm_workflow, ames_train)
```



```r
final_lm_res <- last_fit(lm_workflow, ames_split)
final_lm_res
```

```
## # Resampling results
## # Manual resampling 
## # A tibble: 1 × 6
##   splits             id               .metrics .notes   .predictions .workflow 
##   <list>             <chr>            <list>   <list>   <list>       <list>    
## 1 <split [2342/588]> train/test split <tibble> <tibble> <tibble>     <workflow>
## 
## There were issues with some computations:
## 
##   - Warning(s) x1: prediction from a rank-deficient fit may be misleading
## 
## Use `collect_notes(object)` for more information.
```



```r
lm_metrics <- collect_metrics(final_lm_res)
lm_metrics
```

```
## # A tibble: 2 × 4
##   .metric .estimator .estimate .config             
##   <chr>   <chr>          <dbl> <chr>               
## 1 rmse    standard      0.0793 Preprocessor1_Model1
## 2 rsq     standard      0.784  Preprocessor1_Model1
```


### Spaltenrollen

Eine praktische Funktion ist es, 
bestimmte Spalten nicht als Prädiktor,
sondern als ID-Variable zu nutzen.
Das kann man in Tidymodels komfortabel wie folgt angeben:



```r
ames_recipe <-
  simple_ames %>% 
  update_role(Neighborhood, new_role = "id")

ames_recipe
```

```
## Recipe
## 
## Inputs:
## 
##       role #variables
##         id          1
##    outcome          1
##  predictor          3
## 
## Operations:
## 
## Log transformation on Gr_Liv_Area
## Dummy variables from all_nominal_predictors()
```

### Fazit

Mehr zu Rezepten findet sich [hier](https://recipes.tidymodels.org/).
Ein Überblick zu allen Schritten der Vorverarbeitung findet sich [hier](https://recipes.tidymodels.org/articles/recipes.html).











