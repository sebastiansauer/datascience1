# Kaggle




## Vorbereitung








### Lernsteuerung

### Vorbereitung 

- Lesen Sie die Hinweise zum Modul.
- Installieren (oder Updaten) Sie die für dieses Modul angegeben Software.
- Lesen Sie die Literatur.



### Lernziele 

- Sie können erläutern, was man unter statistischem Lernen versteht.
- Sie wissen, war Overfitting ist, wie es entsteht, und wie es vermieden werden kann.
- Sie kennen verschiedenen Arten von statistischem Lernen und können Algorithmen zu diesen Arten zuordnen.



### Literatur 

- Rhys, Kap. 1
- evtl. Sauer, Kap. 15



### Hinweise 

- Bitte beachten Sie die Hinweise zum Präsenzunterricht und der Streamingoption.
- Bitte stellen Sie sicher, dass Sie einen einsatzbereiten Computer haben und dass die angegebene Software (in aktueller Version) läuft.







### R-Pakete


In diesem Kapitel werden folgende R-Pakete benötigt:


```r
library(tidyverse)
library(tidymodels)
library(tictoc)  # Rechenzeit messen
library(lubridate)  # Datumsangaben
library(VIM)  # fehlende Werte
library(visdat)  # Datensatz visualisieren
```


## Was ist Kaggle?


>    Kaggle, a subsidiary of Google LLC, is an online community of data scientists and machine learning practitioners. Kaggle allows users to find and publish data sets, explore and build models in a web-based data-science environment, work with other data scientists and machine learning engineers, and enter competitions to solve data science challenges.

[Quelle](https://en.wikipedia.org/wiki/Kaggle)


[Kaggle as AirBnB for Data Scientists?!](https://www.kaggle.com/getting-started/44916)


## Fallstudie TMDB

Wir bearbeiten hier die Fallstudie [TMDB Box Office Prediction - 
Can you predict a movie's worldwide box office revenue?](https://www.kaggle.com/competitions/tmdb-box-office-prediction/overview),
ein [Kaggle](https://www.kaggle.com/)-Prognosewettbewerb.

Ziel ist es, genaue Vorhersagen zu machen,
in diesem Fall für Filme.



### Aufgabe

Reichen Sie bei Kaggle eine Submission für die Fallstudie ein! Berichten Sie den Score!


Hinweise:

- Sie müssen sich bei Kaggle ein Konto anlegen (kostenlos und anonym möglich); alternativ können Sie sich mit einem Google-Konto anmelden.
- Halten Sie das Modell so einfach wie möglich. Verwenden Sie als Algorithmus die lineare Regression ohne weitere Schnörkel.
- Logarithmieren Sie `budget` und `revenue`.
- Minimieren Sie die Vorverarbeitung (`steps`) so weit als möglich.
- Verwenden Sie `tidymodels`.
- Die Zielgröße ist `revenue` in Dollars; nicht in "Log-Dollars". Sie müssen also rücktransformieren,
wenn Sie `revenue` logarithmiert haben.



### Daten

Die Daten können Sie von der Kaggle-Projektseite beziehen oder so:









Mal einen Blick werfen:


```
## Rows: 3,000
## Columns: 23
## $ id                    <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 1…
## $ belongs_to_collection <chr> "[{'id': 313576, 'name': 'Hot Tub Time Machine C…
## $ budget                <dbl> 1.40e+07, 4.00e+07, 3.30e+06, 1.20e+06, 0.00e+00…
## $ genres                <chr> "[{'id': 35, 'name': 'Comedy'}]", "[{'id': 35, '…
## $ homepage              <chr> NA, NA, "http://sonyclassics.com/whiplash/", "ht…
## $ imdb_id               <chr> "tt2637294", "tt0368933", "tt2582802", "tt182148…
## $ original_language     <chr> "en", "en", "en", "hi", "ko", "en", "en", "en", …
## $ original_title        <chr> "Hot Tub Time Machine 2", "The Princess Diaries …
## $ overview              <chr> "When Lou, who has become the \"father of the In…
## $ popularity            <dbl> 6.575393, 8.248895, 64.299990, 3.174936, 1.14807…
## $ poster_path           <chr> "/tQtWuwvMf0hCc2QR2tkolwl7c3c.jpg", "/w9Z7A0GHEh…
## $ production_companies  <chr> "[{'name': 'Paramount Pictures', 'id': 4}, {'nam…
## $ production_countries  <chr> "[{'iso_3166_1': 'US', 'name': 'United States of…
## $ release_date          <chr> "2/20/15", "8/6/04", "10/10/14", "3/9/12", "2/5/…
## $ runtime               <dbl> 93, 113, 105, 122, 118, 83, 92, 84, 100, 91, 119…
## $ spoken_languages      <chr> "[{'iso_639_1': 'en', 'name': 'English'}]", "[{'…
## $ status                <chr> "Released", "Released", "Released", "Released", …
## $ tagline               <chr> "The Laws of Space and Time are About to be Viol…
## $ title                 <chr> "Hot Tub Time Machine 2", "The Princess Diaries …
## $ Keywords              <chr> "[{'id': 4379, 'name': 'time travel'}, {'id': 96…
## $ cast                  <chr> "[{'cast_id': 4, 'character': 'Lou', 'credit_id'…
## $ crew                  <chr> "[{'credit_id': '59ac067c92514107af02c8c8', 'dep…
## $ revenue               <dbl> 12314651, 95149435, 13092000, 16000000, 3923970,…
```

```
## Rows: 4,398
## Columns: 22
## $ id                    <dbl> 3001, 3002, 3003, 3004, 3005, 3006, 3007, 3008, …
## $ belongs_to_collection <chr> "[{'id': 34055, 'name': 'Pokémon Collection', 'p…
## $ budget                <dbl> 0.00e+00, 8.80e+04, 0.00e+00, 6.80e+06, 2.00e+06…
## $ genres                <chr> "[{'id': 12, 'name': 'Adventure'}, {'id': 16, 'n…
## $ homepage              <chr> "http://www.pokemon.com/us/movies/movie-pokemon-…
## $ imdb_id               <chr> "tt1226251", "tt0051380", "tt0118556", "tt125595…
## $ original_language     <chr> "ja", "en", "en", "fr", "en", "en", "de", "en", …
## $ original_title        <chr> "ディアルガVSパルキアVSダークライ", "Attack of t…
## $ overview              <chr> "Ash and friends (this time accompanied by newco…
## $ popularity            <dbl> 3.851534, 3.559789, 8.085194, 8.596012, 3.217680…
## $ poster_path           <chr> "/tnftmLMemPLduW6MRyZE0ZUD19z.jpg", "/9MgBNBqlH1…
## $ production_companies  <chr> NA, "[{'name': 'Woolner Brothers Pictures Inc.',…
## $ production_countries  <chr> "[{'iso_3166_1': 'JP', 'name': 'Japan'}, {'iso_3…
## $ release_date          <chr> "7/14/07", "5/19/58", "5/23/97", "9/4/10", "2/11…
## $ runtime               <dbl> 90, 65, 100, 130, 92, 121, 119, 77, 120, 92, 88,…
## $ spoken_languages      <chr> "[{'iso_639_1': 'en', 'name': 'English'}, {'iso_…
## $ status                <chr> "Released", "Released", "Released", "Released", …
## $ tagline               <chr> "Somewhere Between Time & Space... A Legend Is B…
## $ title                 <chr> "Pokémon: The Rise of Darkrai", "Attack of the 5…
## $ Keywords              <chr> "[{'id': 11451, 'name': 'pok√©mon'}, {'id': 1155…
## $ cast                  <chr> "[{'cast_id': 3, 'character': 'Tonio', 'credit_i…
## $ crew                  <chr> "[{'credit_id': '52fe44e7c3a368484e03d683', 'dep…
```


### Train-Set verschlanken










### Datensatz kennenlernen




<img src="chunk-img/unnamed-chunk-7-1.png" width="100%" style="display: block; margin: auto;" />


### Fehlende Werte prüfen

Welche Spalten haben viele fehlende Werte?


<img src="chunk-img/unnamed-chunk-8-1.png" width="100%" style="display: block; margin: auto;" />


Mit `{VIM}` kann man einen Datensatz gut auf fehlende Werte hin untersuchen:

<img src="chunk-img/unnamed-chunk-9-1.png" width="100%" style="display: block; margin: auto;" />


## Rezept

### Rezept definieren



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
## Variable mutation for if_else(budget < 10, 10, budget)
## Log transformation on budget
## Variable mutation for mdy(release_date)
## Date features from release_date
## K-nearest neighbor imputation for all_predictors()
## Dummy variables from all_nominal()
```


```
## # A tibble: 6 × 6
##   number operation type       trained skip  id              
##    <int> <chr>     <chr>      <lgl>   <lgl> <chr>           
## 1      1 step      mutate     FALSE   FALSE mutate_h5zV5    
## 2      2 step      log        FALSE   FALSE log_cMkyV       
## 3      3 step      mutate     FALSE   FALSE mutate_hTtgg    
## 4      4 step      date       FALSE   FALSE date_lddPK      
## 5      5 step      impute_knn FALSE   FALSE impute_knn_sXbFF
## 6      6 step      dummy      FALSE   FALSE dummy_B54Dt
```



### Check das Rezept 



```
## oper 1 step mutate [training] 
## oper 2 step log [training] 
## oper 3 step mutate [training] 
## oper 4 step date [training] 
## oper 5 step impute knn [training] 
## oper 6 step dummy [training] 
## The retained training set is ~ 0.38 Mb  in memory.
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
## Training data contained 3000 data points and 2 incomplete rows. 
## 
## Operations:
## 
## Variable mutation for ~if_else(budget < 10, 10, budget) [trained]
## Log transformation on budget [trained]
## Variable mutation for ~mdy(release_date) [trained]
## Date features from release_date [trained]
## K-nearest neighbor imputation for runtime, budget, release_date_year, release_da... [trained]
## Dummy variables from release_date_month [trained]
```




```
## # A tibble: 3,000 × 16
##    popularity runtime budget  revenue release_date_year release_date_month_Feb
##         <dbl>   <dbl>  <dbl>    <dbl>             <dbl>                  <dbl>
##  1      6.58       93  16.5  12314651              2015                      1
##  2      8.25      113  17.5  95149435              2004                      0
##  3     64.3       105  15.0  13092000              2014                      0
##  4      3.17      122  14.0  16000000              2012                      0
##  5      1.15      118   2.30  3923970              2009                      1
##  6      0.743      83  15.9   3261638              1987                      0
##  7      7.29       92  16.5  85446075              2012                      0
##  8      1.95       84   2.30  2586511              2004                      0
##  9      6.90      100   2.30 34327391              1996                      1
## 10      4.67       91  15.6  18750246              2003                      0
## # … with 2,990 more rows, and 10 more variables: release_date_month_Mar <dbl>,
## #   release_date_month_Apr <dbl>, release_date_month_May <dbl>,
## #   release_date_month_Jun <dbl>, release_date_month_Jul <dbl>,
## #   release_date_month_Aug <dbl>, release_date_month_Sep <dbl>,
## #   release_date_month_Oct <dbl>, release_date_month_Nov <dbl>,
## #   release_date_month_Dec <dbl>
```





```
## # A tibble: 1 × 16
##   popularity runtime budget revenue release_date_year release_date_month_Feb
##        <int>   <int>  <int>   <int>             <int>                  <int>
## 1          0       0      0       0                 0                      0
## # … with 10 more variables: release_date_month_Mar <int>,
## #   release_date_month_Apr <int>, release_date_month_May <int>,
## #   release_date_month_Jun <int>, release_date_month_Jul <int>,
## #   release_date_month_Aug <int>, release_date_month_Sep <int>,
## #   release_date_month_Oct <int>, release_date_month_Nov <int>,
## #   release_date_month_Dec <int>
```


Keine fehlenden Werte mehr *in den Prädiktoren*.

Nach fehlenden Werten könnte man z.B. auch so suchen:

Variable   |     Mean |       SD |      IQR |              Range | Skewness | Kurtosis |    n | n_Missing
---------------------------------------------------------------------------------------------------------
popularity |     8.46 |    12.10 |     6.88 | [1.00e-06, 294.34] |    14.38 |   280.10 | 3000 |         0
runtime    |   107.86 |    22.09 |    24.00 |     [0.00, 338.00] |     1.02 |     8.19 | 2998 |         2
revenue    | 6.67e+07 | 1.38e+08 | 6.66e+07 |   [1.00, 1.52e+09] |     4.54 |    27.78 | 3000 |         0
budget     | 2.25e+07 | 3.70e+07 | 2.90e+07 |   [0.00, 3.80e+08] |     3.10 |    13.23 | 3000 |         0


So bekommt man gleich noch ein paar Infos über die Verteilung der Variablen. Praktische Sache.

### Check Test-Sample

Das Test-Sample backen wir auch mal.

Wichtig: Wir preppen den Datensatz mit dem *Train-Sample*.


```
## # A tibble: 6 × 15
##   popularity runtime budget release_date_year release_date_mon… release_date_mo…
##        <dbl>   <dbl>  <dbl>             <dbl>             <dbl>            <dbl>
## 1       3.85      90   2.30              2007                 0                0
## 2       3.56      65  11.4               2058                 0                0
## 3       8.09     100   2.30              1997                 0                0
## 4       8.60     130  15.7               2010                 0                0
## 5       3.22      92  14.5               2005                 1                0
## 6       8.68     121   2.30              1996                 1                0
## # … with 9 more variables: release_date_month_Apr <dbl>,
## #   release_date_month_May <dbl>, release_date_month_Jun <dbl>,
## #   release_date_month_Jul <dbl>, release_date_month_Aug <dbl>,
## #   release_date_month_Sep <dbl>, release_date_month_Oct <dbl>,
## #   release_date_month_Nov <dbl>, release_date_month_Dec <dbl>
```




## Kreuzvalidierung





## Modelle

### Baum






### Random Forest









### XGBoost





### LM






## Workflows





## Fitten und tunen





Man kann sich das Ergebnisobjekt abspeichern, 
um künftig Rechenzeit zu sparen:




Professioneller ist der Ansatz mit dem R-Paket [target](https://books.ropensci.org/targets/).



## Finalisieren


### Welcher Algorithmus schneidet am besten ab?

Genauer geagt, welches Modell, denn es ist ja nicht nur ein Algorithmus,
sondern ein Algorithmus plus ein Rezept plus die Parameterinstatiierung plus
ein spezifischer Datensatz.

<img src="chunk-img/unnamed-chunk-26-1.png" width="100%" style="display: block; margin: auto;" />

R-Quadrat ist nicht entscheidend; `rmse` ist wichtiger.

Die Ergebnislage ist nicht ganz klar, aber
einiges spricht für das Boosting-Modell, `rec1_boost1`.



```
## # A tibble: 10 × 9
##    wflow_id    .config     preproc model .metric .estimator   mean     n std_err
##    <chr>       <chr>       <chr>   <chr> <chr>   <chr>       <dbl> <int>   <dbl>
##  1 rec1_lm1    Preprocess… recipe  line… rmse    standard   1.15e8    15  2.20e6
##  2 rec1_tree1  Preprocess… recipe  deci… rmse    standard   1.12e8    15  2.67e6
##  3 rec1_rf1    Preprocess… recipe  rand… rmse    standard   1.10e8    15  2.64e6
##  4 rec1_tree1  Preprocess… recipe  deci… rmse    standard   9.46e7    15  2.30e6
##  5 rec1_tree1  Preprocess… recipe  deci… rmse    standard   9.33e7    15  2.26e6
##  6 rec1_boost1 Preprocess… recipe  boos… rmse    standard   9.30e7    15  1.91e6
##  7 rec1_boost1 Preprocess… recipe  boos… rmse    standard   9.27e7    15  2.13e6
##  8 rec1_tree1  Preprocess… recipe  deci… rmse    standard   9.21e7    15  1.91e6
##  9 rec1_tree1  Preprocess… recipe  deci… rmse    standard   9.21e7    15  1.91e6
## 10 rec1_boost1 Preprocess… recipe  boos… rmse    standard   9.21e7    15  1.73e6
```



```
## # A tibble: 1 × 4
##    mtry trees min_n .config              
##   <int> <int> <int> <chr>                
## 1     6   100     4 Preprocessor1_Model04
```







```
## ══ Workflow ════════════════════════════════════════════════════════════════════
## Preprocessor: Recipe
## Model: boost_tree()
## 
## ── Preprocessor ────────────────────────────────────────────────────────────────
## 6 Recipe Steps
## 
## • step_mutate()
## • step_log()
## • step_mutate()
## • step_date()
## • step_impute_knn()
## • step_dummy()
## 
## ── Model ───────────────────────────────────────────────────────────────────────
## Boosted Tree Model Specification (regression)
## 
## Main Arguments:
##   mtry = 6
##   trees = 100
##   min_n = 4
## 
## Engine-Specific Arguments:
##   nthreads = parallel::detectCores()
## 
## Computational engine: xgboost
```

### Final Fit



```
## [12:09:37] WARNING: amalgamation/../src/learner.cc:576: 
## Parameters: { "nthreads" } might not be used.
## 
##   This could be a false alarm, with some parameters getting used by language bindings but
##   then being mistakenly passed down to XGBoost core, or some parameter actually being used
##   but getting flagged wrongly here. Please open an issue if you find any such cases.
```

```
## ══ Workflow [trained] ══════════════════════════════════════════════════════════
## Preprocessor: Recipe
## Model: boost_tree()
## 
## ── Preprocessor ────────────────────────────────────────────────────────────────
## 6 Recipe Steps
## 
## • step_mutate()
## • step_log()
## • step_mutate()
## • step_date()
## • step_impute_knn()
## • step_dummy()
## 
## ── Model ───────────────────────────────────────────────────────────────────────
## ##### xgb.Booster
## raw: 375.7 Kb 
## call:
##   xgboost::xgb.train(params = list(eta = 0.3, max_depth = 6, gamma = 0, 
##     colsample_bytree = 1, colsample_bynode = 0.4, min_child_weight = 4L, 
##     subsample = 1, objective = "reg:squarederror"), data = x$data, 
##     nrounds = 100L, watchlist = x$watchlist, verbose = 0, nthreads = 8L, 
##     nthread = 1)
## params (as set within xgb.train):
##   eta = "0.3", max_depth = "6", gamma = "0", colsample_bytree = "1", colsample_bynode = "0.4", min_child_weight = "4", subsample = "1", objective = "reg:squarederror", nthreads = "8", nthread = "1", validate_parameters = "TRUE"
## xgb.attributes:
##   niter
## callbacks:
##   cb.evaluation.log()
## # of features: 15 
## niter: 100
## nfeatures : 15 
## evaluation_log:
##     iter training_rmse
##        1     121344704
##        2     101127808
## ---                   
##       99      26307716
##      100      26233010
```







## Submission


### Submission vorbereiten




Abspeichern und einreichen:



Diese CSV-Datei reichen wir dann bei Kagglei ein.


### Kaggle Score

Diese Submission erzielte einen Score von **4.79227** (RMSLE).







