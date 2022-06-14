1.  **Aufgabe**\

    Melden Sie sich an für die Kaggle Competition [TMDB Box Office
    Prediction - Can you predict a movie's worldwide box office
    revenue?](https://www.kaggle.com/competitions/tmdb-box-office-prediction/overview).

    Sie benötigen dazu ein Konto; es ist auch möglich, sich mit seinem
    Google-Konto anzumelden.

    Bei diesem Prognosewettbewerb geht es darum, vorherzusagen, wieviel
    Umsatz wohl einige Filme machen werden. Als Prädiktoren stehen
    einige Infos wie Budget, Genre, Titel etc. zur Verfügung. Eine
    klassische "predictive Competition" also :-) Allerdings können immer
    ein paar Schwierigkeiten auftreten ;-)

    *Aufgabe*

    Erstellen Sie ein Random-Forest-Modell mit Tidymodels! Reichen Sie
    es bei Kaggle ein un berichten Sie den Score!

    *Hinweise*

    -   Verzichten Sie auf Vorverarbeitung.
    -   Tunen Sie die typischen Parameter.
    -   Begrenzen Sie sich auf folgende Prädiktoren.

    ``` text
    preds_chosen <- 
      c("id", "budget", "popularity", "runtime")
    ```

    \
    **Lösung**

    # Pakete starten

    ``` text
    library(tidyverse)
    library(tidymodels)
    library(tictoc)
    ```

    # Daten importieren

    ``` text
    d_train_path <- "https://raw.githubusercontent.com/sebastiansauer/Lehre/main/data/tmdb-box-office-prediction/train.csv"
    d_test_path <- "https://raw.githubusercontent.com/sebastiansauer/Lehre/main/data/tmdb-box-office-prediction/test.csv"

    d_train <- read_csv(d_train_path)
    d_test <- read_csv(d_test_path)
    ```

    Werfen wir einen Blick in die Daten:

    ``` text
    glimpse(d_train)
    ```

        ## Rows: 3,000
        ## Columns: 23
        ## $ id                    <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12…
        ## $ belongs_to_collection <chr> "[{'id': 313576, 'name': 'Hot Tub Tim…
        ## $ budget                <dbl> 1.40e+07, 4.00e+07, 3.30e+06, 1.20e+0…
        ## $ genres                <chr> "[{'id': 35, 'name': 'Comedy'}]", "[{…
        ## $ homepage              <chr> NA, NA, "http://sonyclassics.com/whip…
        ## $ imdb_id               <chr> "tt2637294", "tt0368933", "tt2582802"…
        ## $ original_language     <chr> "en", "en", "en", "hi", "ko", "en", "…
        ## $ original_title        <chr> "Hot Tub Time Machine 2", "The Prince…
        ## $ overview              <chr> "When Lou, who has become the \"fathe…
        ## $ popularity            <dbl> 6.575393, 8.248895, 64.299990, 3.1749…
        ## $ poster_path           <chr> "/tQtWuwvMf0hCc2QR2tkolwl7c3c.jpg", "…
        ## $ production_companies  <chr> "[{'name': 'Paramount Pictures', 'id'…
        ## $ production_countries  <chr> "[{'iso_3166_1': 'US', 'name': 'Unite…
        ## $ release_date          <chr> "2/20/15", "8/6/04", "10/10/14", "3/9…
        ## $ runtime               <dbl> 93, 113, 105, 122, 118, 83, 92, 84, 1…
        ## $ spoken_languages      <chr> "[{'iso_639_1': 'en', 'name': 'Englis…
        ## $ status                <chr> "Released", "Released", "Released", "…
        ## $ tagline               <chr> "The Laws of Space and Time are About…
        ## $ title                 <chr> "Hot Tub Time Machine 2", "The Prince…
        ## $ Keywords              <chr> "[{'id': 4379, 'name': 'time travel'}…
        ## $ cast                  <chr> "[{'cast_id': 4, 'character': 'Lou', …
        ## $ crew                  <chr> "[{'credit_id': '59ac067c92514107af02…
        ## $ revenue               <dbl> 12314651, 95149435, 13092000, 1600000…

    ``` text
    glimpse(d_test)
    ```

        ## Rows: 4,398
        ## Columns: 22
        ## $ id                    <dbl> 3001, 3002, 3003, 3004, 3005, 3006, 3…
        ## $ belongs_to_collection <chr> "[{'id': 34055, 'name': 'Pokémon Coll…
        ## $ budget                <dbl> 0.00e+00, 8.80e+04, 0.00e+00, 6.80e+0…
        ## $ genres                <chr> "[{'id': 12, 'name': 'Adventure'}, {'…
        ## $ homepage              <chr> "http://www.pokemon.com/us/movies/mov…
        ## $ imdb_id               <chr> "tt1226251", "tt0051380", "tt0118556"…
        ## $ original_language     <chr> "ja", "en", "en", "fr", "en", "en", "…
        ## $ original_title        <chr> "ディアルガVSパルキアVSダークライ", "…
        ## $ overview              <chr> "Ash and friends (this time accompani…
        ## $ popularity            <dbl> 3.851534, 3.559789, 8.085194, 8.59601…
        ## $ poster_path           <chr> "/tnftmLMemPLduW6MRyZE0ZUD19z.jpg", "…
        ## $ production_companies  <chr> NA, "[{'name': 'Woolner Brothers Pict…
        ## $ production_countries  <chr> "[{'iso_3166_1': 'JP', 'name': 'Japan…
        ## $ release_date          <chr> "7/14/07", "5/19/58", "5/23/97", "9/4…
        ## $ runtime               <dbl> 90, 65, 100, 130, 92, 121, 119, 77, 1…
        ## $ spoken_languages      <chr> "[{'iso_639_1': 'en', 'name': 'Englis…
        ## $ status                <chr> "Released", "Released", "Released", "…
        ## $ tagline               <chr> "Somewhere Between Time & Space... A …
        ## $ title                 <chr> "Pokémon: The Rise of Darkrai", "Atta…
        ## $ Keywords              <chr> "[{'id': 11451, 'name': 'pok√©mon'}, …
        ## $ cast                  <chr> "[{'cast_id': 3, 'character': 'Tonio'…
        ## $ crew                  <chr> "[{'credit_id': '52fe44e7c3a368484e03…

    `preds_chosen` sind alle Prädiktoren im Datensatz, oder nicht? Das
    prüfen wir mal kurz:

    ``` text
    preds_chosen %in% names(d_train) %>% 
      all()
    ```

        ## [1] TRUE

    Ja, alle Elemente von `preds_chosen` sind Prädiktoren im
    (Train-)Datensatz.

    # CV

    ``` text
    cv_scheme <- vfold_cv(d_train)
    ```

    # Rezept 1

    ``` text
    rec1 <- 
      recipe(revenue ~ budget + popularity + runtime, data = d_train) %>% 
      step_impute_bag(all_predictors()) %>% 
      step_naomit(all_predictors()) 
    rec1
    ```

        ## Recipe
        ## 
        ## Inputs:
        ## 
        ##       role #variables
        ##    outcome          1
        ##  predictor          3
        ## 
        ## Operations:
        ## 
        ## Bagged tree imputation for all_predictors()
        ## Removing rows with NA values in all_predictors()

    Man beachte, dass noch 21 Prädiktoren angezeigt werden, da das
    Rezept noch nicht auf den Datensatz angewandt ("gebacken") wurde.

    ``` text
    tidy(rec1)
    ```

        ## # A tibble: 2 × 6
        ##   number operation type       trained skip  id              
        ##    <int> <chr>     <chr>      <lgl>   <lgl> <chr>           
        ## 1      1 step      impute_bag FALSE   FALSE impute_bag_KRpez
        ## 2      2 step      naomit     FALSE   FALSE naomit_nPSJ2

    Rezept checken:

    ``` text
    prep(rec1)
    ```

        ## Recipe
        ## 
        ## Inputs:
        ## 
        ##       role #variables
        ##    outcome          1
        ##  predictor          3
        ## 
        ## Training data contained 3000 data points and 2 incomplete rows. 
        ## 
        ## Operations:
        ## 
        ## Bagged tree imputation for budget, popularity, runtime [trained]
        ## Removing rows with NA values in budget, popularity, runtime [trained]

    ``` text
    d_train_baked <-
      rec1 %>% 
      prep() %>% 
      bake(new_data = NULL)

    glimpse(d_train_baked)
    ```

        ## Rows: 3,000
        ## Columns: 4
        ## $ budget     <dbl> 1.40e+07, 4.00e+07, 3.30e+06, 1.20e+06, 0.00e+00…
        ## $ popularity <dbl> 6.575393, 8.248895, 64.299990, 3.174936, 1.14807…
        ## $ runtime    <dbl> 93, 113, 105, 122, 118, 83, 92, 84, 100, 91, 119…
        ## $ revenue    <dbl> 12314651, 95149435, 13092000, 16000000, 3923970,…

    Fehlende Werte noch übrig?

    ``` text
    library(easystats)
    describe_distribution(d_train_baked) %>% 
      select(Variable, n_Missing)
    ```

        ## Variable   | n_Missing
        ## ----------------------
        ## budget     |         0
        ## popularity |         0
        ## runtime    |         0
        ## revenue    |         0

    # Modell 1: RF

    ``` text
    model1 <- rand_forest(mtry = tune(),
                            trees = tune(),
                            min_n = tune()) %>% 
                set_engine('ranger') %>% 
                set_mode('regression')
    ```

    # Workflow 1

    ``` text
    wf1 <-
      workflow() %>% 
      add_model(model1) %>% 
      add_recipe(rec1)
    ```

    # Modell fitten (und tunen)

    ``` text
    doParallel::registerDoParallel(4)
    tic()
    rf_fit1 <-
      wf1 %>% 
      tune_grid(resamples = cv_scheme)
    toc()
    ```

        ## 65.17 sec elapsed

    ``` text
    rf_fit1[[".notes"]][1]
    ```

        ## [[1]]
        ## # A tibble: 0 × 3
        ## # … with 3 variables: location <chr>, type <chr>, note <chr>

    # Bester Kandidat

    ``` text
    select_best(rf_fit1)
    ```

        ## Warning: No value of `metric` was given; metric 'rmse' will be used.

        ## # A tibble: 1 × 4
        ##    mtry trees min_n .config              
        ##   <int> <int> <int> <chr>                
        ## 1     1   258    10 Preprocessor1_Model04

    # Workflow Finalisieren

    ``` text
    wf_best <-
      wf1 %>% 
      finalize_workflow(parameters = select_best(rf_fit1))
    ```

        ## Warning: No value of `metric` was given; metric 'rmse' will be used.

    # Final Fit

    ``` text
    fit1_final <-
      wf_best %>% 
      fit(d_train)

    fit1_final
    ```

        ## ══ Workflow [trained] ═══════════════════════════════════════════════
        ## Preprocessor: Recipe
        ## Model: rand_forest()
        ## 
        ## ── Preprocessor ─────────────────────────────────────────────────────
        ## 2 Recipe Steps
        ## 
        ## • step_impute_bag()
        ## • step_naomit()
        ## 
        ## ── Model ────────────────────────────────────────────────────────────
        ## Ranger result
        ## 
        ## Call:
        ##  ranger::ranger(x = maybe_data_frame(x), y = y, mtry = min_cols(~1L,      x), num.trees = ~258L, min.node.size = min_rows(~10L, x),      num.threads = 1, verbose = FALSE, seed = sample.int(10^5,          1)) 
        ## 
        ## Type:                             Regression 
        ## Number of trees:                  258 
        ## Sample size:                      3000 
        ## Number of independent variables:  3 
        ## Mtry:                             1 
        ## Target node size:                 10 
        ## Variable importance mode:         none 
        ## Splitrule:                        variance 
        ## OOB prediction error (MSE):       6.668705e+15 
        ## R squared (OOB):                  0.6474409

    ``` text
    preds <-
      fit1_final %>% 
      predict(d_test)
    ```

    # Submission df

    ``` text
    submission_df <-
      d_test %>% 
      select(id) %>% 
      bind_cols(preds) %>% 
      rename(revenue = .pred)

    head(submission_df)
    ```

        ## # A tibble: 6 × 2
        ##      id   revenue
        ##   <dbl>     <dbl>
        ## 1  3001  5019278.
        ## 2  3002  6458883.
        ## 3  3003 13366502.
        ## 4  3004 42798066.
        ## 5  3005  4254825.
        ## 6  3006 24553805.

    Abspeichern und einreichen:

    ``` text
    #write_csv(submission_df, file = "submission.csv")
    ```

    # Kaggle Score

    Diese Submission erzielte einen Score von **Score: 2.76961**
    (RMSLE).

    ``` text
    sol <-  2.76961
    ```

2.  **Aufgabe**\

    Wir bearbeiten hier die Fallstudie [TMDB Box Office Prediction - Can
    you predict a movie's worldwide box office
    revenue?](https://www.kaggle.com/competitions/tmdb-box-office-prediction/overview),
    ein [Kaggle](https://www.kaggle.com/)-Prognosewettbewerb.

    Ziel ist es, genaue Vorhersagen zu machen, in diesem Fall für Filme.

    Die Daten können Sie von der Kaggle-Projektseite beziehen oder so:

    ``` text
    d_train_path <- "https://raw.githubusercontent.com/sebastiansauer/Lehre/main/data/tmdb-box-office-prediction/train.csv"
    d_test_path <- "https://raw.githubusercontent.com/sebastiansauer/Lehre/main/data/tmdb-box-office-prediction/test.csv"
    ```

    # Aufgabe

    Reichen Sie bei Kaggle eine Submission für die Fallstudie ein!
    Berichten Sie den Kaggle-Score

    Hinweise:

    -   Sie müssen sich bei Kaggle ein Konto anlegen (kostenlos und
        anonym möglich); alternativ können Sie sich mit einem
        Google-Konto anmelden.
    -   Berechnen Sie einen Entscheidungsbaum und einen Random-Forest.
    -   Tunen Sie nach Bedarf; verwenden Sie aber Default-Werte.
    -   Verwenden Sie Tidymodels.

    \
    **Lösung**

    # Vorbereitung

    ``` text
    library(tidyverse)
    library(tidymodels)
    library(tictoc)
    ```

    ``` text
    d_train <- read_csv(d_train_path)
    d_test <- read_csv(d_test_path)

    glimpse(d_train)
    ```

        ## Rows: 3,000
        ## Columns: 23
        ## $ id                    <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12…
        ## $ belongs_to_collection <chr> "[{'id': 313576, 'name': 'Hot Tub Tim…
        ## $ budget                <dbl> 1.40e+07, 4.00e+07, 3.30e+06, 1.20e+0…
        ## $ genres                <chr> "[{'id': 35, 'name': 'Comedy'}]", "[{…
        ## $ homepage              <chr> NA, NA, "http://sonyclassics.com/whip…
        ## $ imdb_id               <chr> "tt2637294", "tt0368933", "tt2582802"…
        ## $ original_language     <chr> "en", "en", "en", "hi", "ko", "en", "…
        ## $ original_title        <chr> "Hot Tub Time Machine 2", "The Prince…
        ## $ overview              <chr> "When Lou, who has become the \"fathe…
        ## $ popularity            <dbl> 6.575393, 8.248895, 64.299990, 3.1749…
        ## $ poster_path           <chr> "/tQtWuwvMf0hCc2QR2tkolwl7c3c.jpg", "…
        ## $ production_companies  <chr> "[{'name': 'Paramount Pictures', 'id'…
        ## $ production_countries  <chr> "[{'iso_3166_1': 'US', 'name': 'Unite…
        ## $ release_date          <chr> "2/20/15", "8/6/04", "10/10/14", "3/9…
        ## $ runtime               <dbl> 93, 113, 105, 122, 118, 83, 92, 84, 1…
        ## $ spoken_languages      <chr> "[{'iso_639_1': 'en', 'name': 'Englis…
        ## $ status                <chr> "Released", "Released", "Released", "…
        ## $ tagline               <chr> "The Laws of Space and Time are About…
        ## $ title                 <chr> "Hot Tub Time Machine 2", "The Prince…
        ## $ Keywords              <chr> "[{'id': 4379, 'name': 'time travel'}…
        ## $ cast                  <chr> "[{'cast_id': 4, 'character': 'Lou', …
        ## $ crew                  <chr> "[{'credit_id': '59ac067c92514107af02…
        ## $ revenue               <dbl> 12314651, 95149435, 13092000, 1600000…

    ``` text
    glimpse(d_test)
    ```

        ## Rows: 4,398
        ## Columns: 22
        ## $ id                    <dbl> 3001, 3002, 3003, 3004, 3005, 3006, 3…
        ## $ belongs_to_collection <chr> "[{'id': 34055, 'name': 'Pokémon Coll…
        ## $ budget                <dbl> 0.00e+00, 8.80e+04, 0.00e+00, 6.80e+0…
        ## $ genres                <chr> "[{'id': 12, 'name': 'Adventure'}, {'…
        ## $ homepage              <chr> "http://www.pokemon.com/us/movies/mov…
        ## $ imdb_id               <chr> "tt1226251", "tt0051380", "tt0118556"…
        ## $ original_language     <chr> "ja", "en", "en", "fr", "en", "en", "…
        ## $ original_title        <chr> "ディアルガVSパルキアVSダークライ", "…
        ## $ overview              <chr> "Ash and friends (this time accompani…
        ## $ popularity            <dbl> 3.851534, 3.559789, 8.085194, 8.59601…
        ## $ poster_path           <chr> "/tnftmLMemPLduW6MRyZE0ZUD19z.jpg", "…
        ## $ production_companies  <chr> NA, "[{'name': 'Woolner Brothers Pict…
        ## $ production_countries  <chr> "[{'iso_3166_1': 'JP', 'name': 'Japan…
        ## $ release_date          <chr> "7/14/07", "5/19/58", "5/23/97", "9/4…
        ## $ runtime               <dbl> 90, 65, 100, 130, 92, 121, 119, 77, 1…
        ## $ spoken_languages      <chr> "[{'iso_639_1': 'en', 'name': 'Englis…
        ## $ status                <chr> "Released", "Released", "Released", "…
        ## $ tagline               <chr> "Somewhere Between Time & Space... A …
        ## $ title                 <chr> "Pokémon: The Rise of Darkrai", "Atta…
        ## $ Keywords              <chr> "[{'id': 11451, 'name': 'pok√©mon'}, …
        ## $ cast                  <chr> "[{'cast_id': 3, 'character': 'Tonio'…
        ## $ crew                  <chr> "[{'credit_id': '52fe44e7c3a368484e03…

    # Rezpet

    ## Rezept definieren

    ``` text
    rec1 <-
      recipe(revenue ~ ., data = d_train) %>% 
      update_role(all_predictors(), new_role = "id") %>% 
      update_role(popularity, runtime, revenue, budget) %>% 
      update_role(revenue, new_role = "outcome") %>% 
      step_mutate(budget = ifelse(budget < 10, 10, budget)) %>% 
      step_log(budget) %>% 
      step_impute_knn(all_predictors())

    rec1
    ```

        ## Recipe
        ## 
        ## Inputs:
        ## 
        ##       role #variables
        ##         id         19
        ##    outcome          1
        ##  predictor          3
        ## 
        ## Operations:
        ## 
        ## Variable mutation for ifelse(budget < 10, 10, budget)
        ## Log transformation on budget
        ## K-nearest neighbor imputation for all_predictors()

    ## Check das Rezept

    ``` text
    rec1_prepped <-
      prep(rec1, verbose = TRUE)
    ```

        ## oper 1 step mutate [training] 
        ## oper 2 step log [training] 
        ## oper 3 step impute knn [training] 
        ## The retained training set is ~ 28.71 Mb  in memory.

    ``` text
    rec1_prepped
    ```

        ## Recipe
        ## 
        ## Inputs:
        ## 
        ##       role #variables
        ##         id         19
        ##    outcome          1
        ##  predictor          3
        ## 
        ## Training data contained 3000 data points and 2793 incomplete rows. 
        ## 
        ## Operations:
        ## 
        ## Variable mutation for ~ifelse(budget < 10, 10, budget) [trained]
        ## Log transformation on budget [trained]
        ## K-nearest neighbor imputation for popularity, runtime, budget [trained]

    ``` text
    d_train_baked <-
      rec1_prepped %>% 
      bake(new_data = NULL) 

    head(d_train_baked)
    ```

        ## # A tibble: 6 × 23
        ##      id belongs_to_collection          budget genres homepage imdb_id
        ##   <dbl> <fct>                           <dbl> <fct>  <fct>    <fct>  
        ## 1     1 [{'id': 313576, 'name': 'Hot …  16.5  [{'id… <NA>     tt2637…
        ## 2     2 [{'id': 107674, 'name': 'The …  17.5  [{'id… <NA>     tt0368…
        ## 3     3 <NA>                            15.0  [{'id… http://… tt2582…
        ## 4     4 <NA>                            14.0  [{'id… http://… tt1821…
        ## 5     5 <NA>                             2.30 [{'id… <NA>     tt1380…
        ## 6     6 <NA>                            15.9  [{'id… <NA>     tt0093…
        ## # … with 17 more variables: original_language <fct>,
        ## #   original_title <fct>, overview <fct>, popularity <dbl>,
        ## #   poster_path <fct>, production_companies <fct>,
        ## #   production_countries <fct>, release_date <fct>, runtime <dbl>,
        ## #   spoken_languages <fct>, status <fct>, tagline <fct>,
        ## #   title <fct>, Keywords <fct>, cast <fct>, crew <fct>,
        ## #   revenue <dbl>

    Die AV-Spalte sollte leer sein:

    ``` text
    bake(rec1_prepped, new_data = head(d_test), all_outcomes())
    ```

        ## # A tibble: 6 × 0

    ``` text
    d_train_baked %>% 
      map_df(~ sum(is.na(.)))
    ```

        ## # A tibble: 1 × 23
        ##      id belongs_to_collection budget genres homepage imdb_id
        ##   <int>                 <int>  <int>  <int>    <int>   <int>
        ## 1     0                  2396      0      7     2054       0
        ## # … with 17 more variables: original_language <int>,
        ## #   original_title <int>, overview <int>, popularity <int>,
        ## #   poster_path <int>, production_companies <int>,
        ## #   production_countries <int>, release_date <int>, runtime <int>,
        ## #   spoken_languages <int>, status <int>, tagline <int>,
        ## #   title <int>, Keywords <int>, cast <int>, crew <int>,
        ## #   revenue <int>

    Keine fehlenden Werte mehr *in den Prädiktoren*.

    Nach fehlenden Werten könnte man z.B. auch so suchen:

    ``` text
    datawizard::describe_distribution(d_train_baked)
    ```

    ## variable \| mean \| sd \| iqr \| range \| skewness \| kurtosis \| n \| n_missing

    id \| 1500.50 \| 866.17 \| 1500.50 \| \[1.00, 3000.00\] \| 0.00 \|
    -1.20 \| 3000 \| 0 budget \| 12.51 \| 6.44 \| 14.88 \| \[2.30,
    19.76\] \| -0.87 \| -1.09 \| 3000 \| 0 popularity \| 8.46 \| 12.10
    \| 6.88 \| \[1.00e-06, 294.34\] \| 14.38 \| 280.10 \| 3000 \| 0
    runtime \| 107.85 \| 22.08 \| 24.00 \| \[0.00, 338.00\] \| 1.02 \|
    8.20 \| 3000 \| 0 revenue \| 6.67e+07 \| 1.38e+08 \| 6.66e+07 \|
    \[1.00, 1.52e+09\] \| 4.54 \| 27.78 \| 3000 \| 0

    So bekommt man gleich noch ein paar Infos über die Verteilung der
    Variablen. Praktische Sache.

    Das Test-Sample backen wir auch mal:

    ``` text
    d_test_baked <-
      bake(rec1_prepped, new_data = d_test)

    d_test_baked %>% 
      head()
    ```

        ## # A tibble: 6 × 22
        ##      id belongs_to_collection          budget genres homepage imdb_id
        ##   <dbl> <fct>                           <dbl> <fct>  <fct>    <fct>  
        ## 1  3001 [{'id': 34055, 'name': 'Pokém…   2.30 [{'id… <NA>     <NA>   
        ## 2  3002 <NA>                            11.4  [{'id… <NA>     <NA>   
        ## 3  3003 <NA>                             2.30 [{'id… <NA>     <NA>   
        ## 4  3004 <NA>                            15.7  <NA>   <NA>     <NA>   
        ## 5  3005 <NA>                            14.5  [{'id… <NA>     <NA>   
        ## 6  3006 <NA>                             2.30 [{'id… <NA>     <NA>   
        ## # … with 16 more variables: original_language <fct>,
        ## #   original_title <fct>, overview <fct>, popularity <dbl>,
        ## #   poster_path <fct>, production_companies <fct>,
        ## #   production_countries <fct>, release_date <fct>, runtime <dbl>,
        ## #   spoken_languages <fct>, status <fct>, tagline <fct>,
        ## #   title <fct>, Keywords <fct>, cast <fct>, crew <fct>

    # Kreuzvalidierung

    ``` text
    cv_scheme <- vfold_cv(d_train,
                          v = 5, 
                          repeats = 3)
    ```

    # Modelle

    ## Baum

    ``` text
    mod_tree <-
      decision_tree(cost_complexity = tune(),
                    tree_depth = tune(),
                    mode = "regression")
    ```

    ## Random Forest

    ``` text
    doParallel::registerDoParallel()
    ```

    ``` text
    mod_rf <-
      rand_forest(mtry = tune(),
                  min_n = tune(),
                  trees = 1000,
                  mode = "regression") %>% 
      set_engine("ranger", num.threads = 4)
    ```

    # Workflows

    ``` text
    wf_tree <-
      workflow() %>% 
      add_model(mod_tree) %>% 
      add_recipe(rec1)

    wf_rf <-
      workflow() %>% 
      add_model(mod_rf) %>% 
      add_recipe(rec1)
    ```

    # Fitten und tunen

    ## Tree

    ``` text
    tic()
    tree_fit <-
      wf_tree %>% 
      tune_grid(
        resamples = cv_scheme,
        grid = 2
      )
    toc()
    ```

        ## 5.761 sec elapsed

    Hilfe zu `tune_grid()` bekommt man
    [hier](https://www.rdocumentation.org/packages/tune/versions/0.2.0/topics/tune_grid).

    ``` text
    tree_fit
    ```

        ## # Tuning results
        ## # 5-fold cross-validation repeated 3 times 
        ## # A tibble: 15 × 5
        ##    splits             id      id2   .metrics         .notes          
        ##    <list>             <chr>   <chr> <list>           <list>          
        ##  1 <split [2400/600]> Repeat1 Fold1 <tibble [4 × 6]> <tibble [0 × 3]>
        ##  2 <split [2400/600]> Repeat1 Fold2 <tibble [4 × 6]> <tibble [0 × 3]>
        ##  3 <split [2400/600]> Repeat1 Fold3 <tibble [4 × 6]> <tibble [0 × 3]>
        ##  4 <split [2400/600]> Repeat1 Fold4 <tibble [4 × 6]> <tibble [0 × 3]>
        ##  5 <split [2400/600]> Repeat1 Fold5 <tibble [4 × 6]> <tibble [0 × 3]>
        ##  6 <split [2400/600]> Repeat2 Fold1 <tibble [4 × 6]> <tibble [0 × 3]>
        ##  7 <split [2400/600]> Repeat2 Fold2 <tibble [4 × 6]> <tibble [0 × 3]>
        ##  8 <split [2400/600]> Repeat2 Fold3 <tibble [4 × 6]> <tibble [0 × 3]>
        ##  9 <split [2400/600]> Repeat2 Fold4 <tibble [4 × 6]> <tibble [0 × 3]>
        ## 10 <split [2400/600]> Repeat2 Fold5 <tibble [4 × 6]> <tibble [0 × 3]>
        ## 11 <split [2400/600]> Repeat3 Fold1 <tibble [4 × 6]> <tibble [0 × 3]>
        ## 12 <split [2400/600]> Repeat3 Fold2 <tibble [4 × 6]> <tibble [0 × 3]>
        ## 13 <split [2400/600]> Repeat3 Fold3 <tibble [4 × 6]> <tibble [0 × 3]>
        ## 14 <split [2400/600]> Repeat3 Fold4 <tibble [4 × 6]> <tibble [0 × 3]>
        ## 15 <split [2400/600]> Repeat3 Fold5 <tibble [4 × 6]> <tibble [0 × 3]>

    Steht was in den `.notes`?

    ``` text
    tree_fit[[".notes"]][[2]]
    ```

        ## # A tibble: 0 × 3
        ## # … with 3 variables: location <chr>, type <chr>, note <chr>

    Nein.

    ``` text
    collect_metrics(tree_fit)
    ```

        ## # A tibble: 4 × 8
        ##   cost_complexity tree_depth .metric .estimator    mean     n std_err
        ##             <dbl>      <int> <chr>   <chr>        <dbl> <int>   <dbl>
        ## 1        3.96e-10          5 rmse    standard   8.86e+7    15 1.84e+6
        ## 2        3.96e-10          5 rsq     standard   5.92e-1    15 1.34e-2
        ## 3        4.03e- 2         13 rmse    standard   9.92e+7    15 2.26e+6
        ## 4        4.03e- 2         13 rsq     standard   4.87e-1    15 1.65e-2
        ## # … with 1 more variable: .config <chr>

    ``` text
    show_best(tree_fit)
    ```

        ## Warning: No value of `metric` was given; metric 'rmse' will be used.

        ## # A tibble: 2 × 8
        ##   cost_complexity tree_depth .metric .estimator    mean     n std_err
        ##             <dbl>      <int> <chr>   <chr>        <dbl> <int>   <dbl>
        ## 1        3.96e-10          5 rmse    standard    8.86e7    15  1.84e6
        ## 2        4.03e- 2         13 rmse    standard    9.92e7    15  2.26e6
        ## # … with 1 more variable: .config <chr>

    ### Finalisieren

    ``` text
    best_tree_wf <-
      wf_tree %>% 
      finalize_workflow(select_best(tree_fit))
    ```

        ## Warning: No value of `metric` was given; metric 'rmse' will be used.

    ``` text
    best_tree_wf
    ```

        ## ══ Workflow ═════════════════════════════════════════════════════════
        ## Preprocessor: Recipe
        ## Model: decision_tree()
        ## 
        ## ── Preprocessor ─────────────────────────────────────────────────────
        ## 3 Recipe Steps
        ## 
        ## • step_mutate()
        ## • step_log()
        ## • step_impute_knn()
        ## 
        ## ── Model ────────────────────────────────────────────────────────────
        ## Decision Tree Model Specification (regression)
        ## 
        ## Main Arguments:
        ##   cost_complexity = 3.96265898896028e-10
        ##   tree_depth = 5
        ## 
        ## Computational engine: rpart

    ``` text
    tree_last_fit <-
      fit(best_tree_wf, data = d_train)

    tree_last_fit
    ```

        ## ══ Workflow [trained] ═══════════════════════════════════════════════
        ## Preprocessor: Recipe
        ## Model: decision_tree()
        ## 
        ## ── Preprocessor ─────────────────────────────────────────────────────
        ## 3 Recipe Steps
        ## 
        ## • step_mutate()
        ## • step_log()
        ## • step_impute_knn()
        ## 
        ## ── Model ────────────────────────────────────────────────────────────
        ## n= 3000 
        ## 
        ## node), split, n, deviance, yval
        ##       * denotes terminal node
        ## 
        ##  1) root 3000 5.672651e+19   66725850  
        ##    2) budget< 18.32631 2845 1.958584e+19   46935270  
        ##      4) budget< 17.19976 2252 5.443953e+18   25901120  
        ##        8) popularity< 9.734966 1745 1.665118e+18   17076460  
        ##         16) popularity< 5.761331 1019 3.184962e+17    8793730  
        ##           32) budget< 15.44456 782 1.408243e+17    6074563 *
        ##           33) budget>=15.44456 237 1.528117e+17   17765830 *
        ##         17) popularity>=5.761331 726 1.178595e+18   28701940  
        ##           34) budget< 16.15249 484 6.504138e+17   21093220 *
        ##           35) budget>=16.15249 242 4.441208e+17   43919380 *
        ##        9) popularity>=9.734966 507 3.175231e+18   56273980  
        ##         18) budget< 15.36217 186 3.092335e+17   24880850  
        ##           36) popularity< 14.04031 151 1.743659e+17   20728170 *
        ##           37) popularity>=14.04031 35 1.210294e+17   42796710 *
        ##         19) budget>=15.36217 321 2.576473e+18   74464390  
        ##           38) popularity< 19.64394 300 2.025184e+18   68010500 *
        ##           39) popularity>=19.64394 21 3.602808e+17  166662900 *
        ##      5) budget>=17.19976 593 9.361685e+18  126815400  
        ##       10) popularity< 19.63372 570 6.590372e+18  117422100  
        ##         20) budget< 17.86726 374 2.692151e+18   94469490  
        ##           40) popularity< 8.444193 149 6.363495e+17   68256660 *
        ##           41) popularity>=8.444193 225 1.885623e+18  111828200 *
        ##         21) budget>=17.86726 196 3.325222e+18  161219400  
        ##           42) popularity< 11.60513 126 1.693483e+18  136587100 *
        ##           43) popularity>=11.60513 70 1.417677e+18  205557600 *
        ##       11) popularity>=19.63372 23 1.474624e+18  359605200  
        ##         22) runtime>=109.5 16 9.882757e+17  299077200 *
        ##         23) runtime< 109.5 7 2.937458e+17  497955000 *
        ##    3) budget>=18.32631 155 1.557371e+19  429978800  
        ##      6) popularity< 17.26579 101 4.711450e+18  299997300  
        ##       12) budget< 18.73897 67 1.671489e+18  230290900  
        ##         24) popularity< 12.66146 40 5.426991e+17  174328700  
        ##           48) budget< 18.44536 18 1.099070e+17  134734600 *
        ##           49) budget>=18.44536 22 3.814856e+17  206724000 *
        ##         25) popularity>=12.66146 27 8.179336e+17  313197700  
        ##           50) budget< 18.52944 13 1.273606e+17  234797100 *
        ##           51) budget>=18.52944 14 5.364675e+17  385998300 *
        ##       13) budget>=18.73897 34 2.072879e+18  437360100  
        ##         26) runtime< 132.5 26 1.123840e+18  391271100  
        ##           52) popularity< 11.34182 9 9.729505e+16  248614500 *
        ##           53) popularity>=11.34182 17 7.464210e+17  466795200 *
        ##         27) runtime>=132.5 8 7.143147e+17  587149400 *
        ##      7) popularity>=17.26579 54 5.964228e+18  673092200  
        ##       14) budget< 18.99438 33 2.082469e+18  534404700  
        ##         28) popularity< 25.35778 19 5.425201e+17  416871200 *
        ## 
        ## ...
        ## and 4 more lines.

    ### Vorhersage Test-Sample

    ``` text
    predict(tree_last_fit, new_data = d_test)
    ```

        ## # A tibble: 4,398 × 1
        ##         .pred
        ##         <dbl>
        ##  1   6074563.
        ##  2   6074563.
        ##  3  21093221.
        ##  4  21093221.
        ##  5   6074563.
        ##  6  21093221.
        ##  7   6074563.
        ##  8  68256659.
        ##  9  43919378.
        ## 10 205557624.
        ## # … with 4,388 more rows

    ## RF

    ### Fitten und Tunen

    Um Rechenzeit zu sparen, kann man das Objekt, wenn einmal berechnet,
    abspeichern unter `result_obj_path` auf der Festplatte und beim
    nächsten Mal importieren, das geht schneller als neu berechnen.

    In diesem Fall hat `result_obj_path` den Inhalt tmbd_rf_fit1.rds.

    ``` text
    if (file.exists(result_obj_path)) {
      rf_fit <- read_rds(result_obj_path)
    } else {
      tic()
      rf_fit <-
        wf_rf %>% 
        tune_grid(
          resamples = cv_scheme)
      toc()
    }
    ```

    *Achtung* Ein Ergebnisobjekt von der Festplatte zu laden ist
    *gefährlich*. Wenn Sie Ihr Modell verändern, aber vergessen, das
    Objekt auf der Festplatte zu aktualisieren, werden Ihre Ergebnisse
    falsch sein (da auf dem veralteten Objekt beruhend), ohne dass Sie
    durch eine Fehlermeldung von R gewarnt würden!

    So kann man das Ergebnisobjekt auf die Festplatte schreiben:

    ``` text
    #write_rds(rf_fit, file = "objects/tmbd_rf_fit1.rds")
    ```

    ``` text
    collect_metrics(rf_fit)
    ```

        ## # A tibble: 20 × 8
        ##     mtry min_n .metric .estimator         mean     n  std_err .config
        ##    <int> <int> <chr>   <chr>             <dbl> <int>    <dbl> <chr>  
        ##  1     2    15 rmse    standard   82814784.       15  1.71e+6 Prepro…
        ##  2     2    15 rsq     standard          0.643    15  1.15e-2 Prepro…
        ##  3     1    34 rmse    standard   82884640.       15  1.82e+6 Prepro…
        ##  4     1    34 rsq     standard          0.646    15  1.15e-2 Prepro…
        ##  5     1    23 rmse    standard   82457030.       15  1.78e+6 Prepro…
        ##  6     1    23 rsq     standard          0.648    15  1.15e-2 Prepro…
        ##  7     1    29 rmse    standard   82726287.       15  1.78e+6 Prepro…
        ##  8     1    29 rsq     standard          0.646    15  1.13e-2 Prepro…
        ##  9     2    27 rmse    standard   82386320.       15  1.74e+6 Prepro…
        ## 10     2    27 rsq     standard          0.645    15  1.21e-2 Prepro…
        ## 11     3    20 rmse    standard   83010493.       15  1.75e+6 Prepro…
        ## 12     3    20 rsq     standard          0.641    15  1.23e-2 Prepro…
        ## 13     3    10 rmse    standard   83920729.       15  1.72e+6 Prepro…
        ## 14     3    10 rsq     standard          0.634    15  1.22e-2 Prepro…
        ## 15     2    40 rmse    standard   82786794.       15  1.78e+6 Prepro…
        ## 16     2    40 rsq     standard          0.642    15  1.22e-2 Prepro…
        ## 17     2     9 rmse    standard   83237809.       15  1.71e+6 Prepro…
        ## 18     2     9 rsq     standard          0.640    15  1.14e-2 Prepro…
        ## 19     2     3 rmse    standard   83861944.       15  1.64e+6 Prepro…
        ## 20     2     3 rsq     standard          0.635    15  1.12e-2 Prepro…

    ``` text
    select_best(rf_fit)
    ```

        ## Warning: No value of `metric` was given; metric 'rmse' will be used.

        ## # A tibble: 1 × 3
        ##    mtry min_n .config              
        ##   <int> <int> <chr>                
        ## 1     2    27 Preprocessor1_Model05

    ### Finalisieren

    ``` text
    final_wf <-
      wf_rf %>% 
      finalize_workflow(select_best(rf_fit))
    ```

        ## Warning: No value of `metric` was given; metric 'rmse' will be used.

    ``` text
    final_fit <-
      fit(final_wf, data = d_train)
    ```

    ``` text
    final_preds <- 
      final_fit %>% 
      predict(new_data = d_test) %>% 
      bind_cols(d_test)
    ```

    ``` text
    submission <-
      final_preds %>% 
      select(id, revenue = .pred)
    ```

    Abspeichern und einreichen:

    ``` text
    write_csv(submission, file = "submission.csv")
    ```

    # Kaggle Score {#kaggle-score}

    Diese Submission erzielte einen Score von **2.7664** (RMSLE).

    ``` text
    sol <- 2.7664
    ```

3.  **Aufgabe**\

    Wir bearbeiten hier die Fallstudie [TMDB Box Office Prediction - Can
    you predict a movie's worldwide box office
    revenue?](https://www.kaggle.com/competitions/tmdb-box-office-prediction/overview),
    ein [Kaggle](https://www.kaggle.com/)-Prognosewettbewerb.

    Ziel ist es, genaue Vorhersagen zu machen, in diesem Fall für Filme.

    Die Daten können Sie von der Kaggle-Projektseite beziehen oder so:

    ``` text
    d_train_path <- "https://raw.githubusercontent.com/sebastiansauer/Lehre/main/data/tmdb-box-office-prediction/train.csv"
    d_test_path <- "https://raw.githubusercontent.com/sebastiansauer/Lehre/main/data/tmdb-box-office-prediction/test.csv"
    ```

    # Aufgabe {#aufgabe}

    Reichen Sie bei Kaggle eine Submission für die Fallstudie ein!
    Berichten Sie den Score!

    Hinweise:

    -   Sie müssen sich bei Kaggle ein Konto anlegen (kostenlos und
        anonym möglich); alternativ können Sie sich mit einem
        Google-Konto anmelden.
    -   Verwenden Sie *mehrere, und zwar folgende Algorithmen*: Random
        Forest, Boosting, lineare Regression. Tipp: Ein Workflow-Set ist
        hilfreich.
    -   Logarithmieren Sie `budget`.
    -   Betreiben Sie Feature Engineering, zumindest etwas. Insbesondere
        sollten Sie den Monat und das Jahr aus dem Datum extrahieren und
        als Features (Prädiktoren) nutzen.
    -   Verwenden Sie `tidymodels`.
    -   Die Zielgröße ist `revenue` in Dollars; nicht in "Log-Dollars".
        Sie müssen also rücktransformieren, falls Sie `revenue`
        logarithmiert haben.

    \
    **Lösung**

    # Vorbereitung {#vorbereitung}

    ``` text
    library(tidyverse)
    library(tidymodels)
    library(tictoc)  # Rechenzeit messen
    #library(Metrics)
    library(lubridate)  # Datumsangaben
    library(VIM)  # fehlende Werte
    library(visdat)  # Datensatz visualisieren
    ```

    ``` text
    d_train_raw <- read_csv(d_train_path)
    d_test <- read_csv(d_test_path)
    ```

    Mal einen Blick werfen:

    ``` text
    glimpse(d_train_raw)
    ```

        ## Rows: 3,000
        ## Columns: 23
        ## $ id                    <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12…
        ## $ belongs_to_collection <chr> "[{'id': 313576, 'name': 'Hot Tub Tim…
        ## $ budget                <dbl> 1.40e+07, 4.00e+07, 3.30e+06, 1.20e+0…
        ## $ genres                <chr> "[{'id': 35, 'name': 'Comedy'}]", "[{…
        ## $ homepage              <chr> NA, NA, "http://sonyclassics.com/whip…
        ## $ imdb_id               <chr> "tt2637294", "tt0368933", "tt2582802"…
        ## $ original_language     <chr> "en", "en", "en", "hi", "ko", "en", "…
        ## $ original_title        <chr> "Hot Tub Time Machine 2", "The Prince…
        ## $ overview              <chr> "When Lou, who has become the \"fathe…
        ## $ popularity            <dbl> 6.575393, 8.248895, 64.299990, 3.1749…
        ## $ poster_path           <chr> "/tQtWuwvMf0hCc2QR2tkolwl7c3c.jpg", "…
        ## $ production_companies  <chr> "[{'name': 'Paramount Pictures', 'id'…
        ## $ production_countries  <chr> "[{'iso_3166_1': 'US', 'name': 'Unite…
        ## $ release_date          <chr> "2/20/15", "8/6/04", "10/10/14", "3/9…
        ## $ runtime               <dbl> 93, 113, 105, 122, 118, 83, 92, 84, 1…
        ## $ spoken_languages      <chr> "[{'iso_639_1': 'en', 'name': 'Englis…
        ## $ status                <chr> "Released", "Released", "Released", "…
        ## $ tagline               <chr> "The Laws of Space and Time are About…
        ## $ title                 <chr> "Hot Tub Time Machine 2", "The Prince…
        ## $ Keywords              <chr> "[{'id': 4379, 'name': 'time travel'}…
        ## $ cast                  <chr> "[{'cast_id': 4, 'character': 'Lou', …
        ## $ crew                  <chr> "[{'credit_id': '59ac067c92514107af02…
        ## $ revenue               <dbl> 12314651, 95149435, 13092000, 1600000…

    ``` text
    glimpse(d_test)
    ```

        ## Rows: 4,398
        ## Columns: 22
        ## $ id                    <dbl> 3001, 3002, 3003, 3004, 3005, 3006, 3…
        ## $ belongs_to_collection <chr> "[{'id': 34055, 'name': 'Pokémon Coll…
        ## $ budget                <dbl> 0.00e+00, 8.80e+04, 0.00e+00, 6.80e+0…
        ## $ genres                <chr> "[{'id': 12, 'name': 'Adventure'}, {'…
        ## $ homepage              <chr> "http://www.pokemon.com/us/movies/mov…
        ## $ imdb_id               <chr> "tt1226251", "tt0051380", "tt0118556"…
        ## $ original_language     <chr> "ja", "en", "en", "fr", "en", "en", "…
        ## $ original_title        <chr> "ディアルガVSパルキアVSダークライ", "…
        ## $ overview              <chr> "Ash and friends (this time accompani…
        ## $ popularity            <dbl> 3.851534, 3.559789, 8.085194, 8.59601…
        ## $ poster_path           <chr> "/tnftmLMemPLduW6MRyZE0ZUD19z.jpg", "…
        ## $ production_companies  <chr> NA, "[{'name': 'Woolner Brothers Pict…
        ## $ production_countries  <chr> "[{'iso_3166_1': 'JP', 'name': 'Japan…
        ## $ release_date          <chr> "7/14/07", "5/19/58", "5/23/97", "9/4…
        ## $ runtime               <dbl> 90, 65, 100, 130, 92, 121, 119, 77, 1…
        ## $ spoken_languages      <chr> "[{'iso_639_1': 'en', 'name': 'Englis…
        ## $ status                <chr> "Released", "Released", "Released", "…
        ## $ tagline               <chr> "Somewhere Between Time & Space... A …
        ## $ title                 <chr> "Pokémon: The Rise of Darkrai", "Atta…
        ## $ Keywords              <chr> "[{'id': 11451, 'name': 'pok√©mon'}, …
        ## $ cast                  <chr> "[{'cast_id': 3, 'character': 'Tonio'…
        ## $ crew                  <chr> "[{'credit_id': '52fe44e7c3a368484e03…

    ## Train-Set verschlanken

    ``` text
    d_train <-
      d_train_raw %>% 
      select(popularity, runtime, revenue, budget, release_date) 
    ```

    ## Datensatz kennenlernen

    ``` text
    library(visdat)
    vis_dat(d_train)
    ```

    ![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAZAAAAD3CAYAAAAzOQKaAAAEDmlDQ1BrQ0dDb2xvclNwYWNlR2VuZXJpY1JHQgAAOI2NVV1oHFUUPpu5syskzoPUpqaSDv41lLRsUtGE2uj+ZbNt3CyTbLRBkMns3Z1pJjPj/KRpKT4UQRDBqOCT4P9bwSchaqvtiy2itFCiBIMo+ND6R6HSFwnruTOzu5O4a73L3PnmnO9+595z7t4LkLgsW5beJQIsGq4t5dPis8fmxMQ6dMF90A190C0rjpUqlSYBG+PCv9rt7yDG3tf2t/f/Z+uuUEcBiN2F2Kw4yiLiZQD+FcWyXYAEQfvICddi+AnEO2ycIOISw7UAVxieD/Cyz5mRMohfRSwoqoz+xNuIB+cj9loEB3Pw2448NaitKSLLRck2q5pOI9O9g/t/tkXda8Tbg0+PszB9FN8DuPaXKnKW4YcQn1Xk3HSIry5ps8UQ/2W5aQnxIwBdu7yFcgrxPsRjVXu8HOh0qao30cArp9SZZxDfg3h1wTzKxu5E/LUxX5wKdX5SnAzmDx4A4OIqLbB69yMesE1pKojLjVdoNsfyiPi45hZmAn3uLWdpOtfQOaVmikEs7ovj8hFWpz7EV6mel0L9Xy23FMYlPYZenAx0yDB1/PX6dledmQjikjkXCxqMJS9WtfFCyH9XtSekEF+2dH+P4tzITduTygGfv58a5VCTH5PtXD7EFZiNyUDBhHnsFTBgE0SQIA9pfFtgo6cKGuhooeilaKH41eDs38Ip+f4At1Rq/sjr6NEwQqb/I/DQqsLvaFUjvAx+eWirddAJZnAj1DFJL0mSg/gcIpPkMBkhoyCSJ8lTZIxk0TpKDjXHliJzZPO50dR5ASNSnzeLvIvod0HG/mdkmOC0z8VKnzcQ2M/Yz2vKldduXjp9bleLu0ZWn7vWc+l0JGcaai10yNrUnXLP/8Jf59ewX+c3Wgz+B34Df+vbVrc16zTMVgp9um9bxEfzPU5kPqUtVWxhs6OiWTVW+gIfywB9uXi7CGcGW/zk98k/kmvJ95IfJn/j3uQ+4c5zn3Kfcd+AyF3gLnJfcl9xH3OfR2rUee80a+6vo7EK5mmXUdyfQlrYLTwoZIU9wsPCZEtP6BWGhAlhL3p2N6sTjRdduwbHsG9kq32sgBepc+xurLPW4T9URpYGJ3ym4+8zA05u44QjST8ZIoVtu3qE7fWmdn5LPdqvgcZz8Ww8BWJ8X3w0PhQ/wnCDGd+LvlHs8dRy6bLLDuKMaZ20tZrqisPJ5ONiCq8yKhYM5cCgKOu66Lsc0aYOtZdo5QCwezI4wm9J/v0X23mlZXOfBjj8Jzv3WrY5D+CsA9D7aMs2gGfjve8ArD6mePZSeCfEYt8CONWDw8FXTxrPqx/r9Vt4biXeANh8vV7/+/16ffMD1N8AuKD/A/8leAvFY9bLAAAAOGVYSWZNTQAqAAAACAABh2kABAAAAAEAAAAaAAAAAAACoAIABAAAAAEAAAGQoAMABAAAAAEAAAD3AAAAANi3NQ4AADuxSURBVHgB7Z0HvBTV2YcPIBYEpQiKHQSMimCJ2FARGwJBwdjA3pVOImrQaGIvUaMGETs2ohFFBWtE0FiwF1REYkFUxAJKU8H9zvP6nc3cy969e/dumbv7P7/fvTs7O3PmzDO78855a72Eb05NBERABERABGpIoH4Nt9fmIiACIiACImAEJED0RRABERABEciKgARIVti0kwiIgAiIgASIvgMiIAIiIAJZEZAAyQqbdhIBERABEZAA0XdABERABEQgKwISIFlh004iIAIiIAISIPoOiIAIiIAIZEVAAiQrbNpJBERABERAAkTfAREQAREQgawISIBkhU07iYAIiIAISIDoOyACIiACIpAVAQmQrLBpJxEQAREQAQkQfQdEQAREQASyIiABkhU27SQCIiACIiABou+ACIiACIhAVgQkQLLCpp1EQAREQAQkQPQdEAEREAERyIqABEhW2LSTCIiACIiABIi+AyIgAiIgAlkRkADJCpt2EgEREAERkADRd0AEREAERCArAhIgWWHTTiIgAiIgAhIg+g6IgAiIgAhkRUACJCts2kkEREAEREACRN8BERABERCBrAhIgGSFTTuJgAiIgAhIgOg7IAIiIAIikBUBCZCssGknERABERABCRB9B0RABERABLIisEpWe2mnkiDwyy+/uPvuu89NmTLFNW3a1PXv39916tSpJM5NJyECIpB/ApqB5J9xbI9wyy23uJdfftmddNJJrn379m7IkCHu008/je14NTAREIF4EZAAidf1yOtoPvnkkwr9T5gwwZ155pmuQ4cObvr06W7o0KHu448/dvPmzauwnd6IgAiIQCoCEiCpqJTgOoTCoEGD3IwZM9z48ePdihUr3PLly92cOXPcH/7wB9ejRw/Xt29f9+ijj7q33nqrBAnolERABHJNQAIk10Rj2t+6667rBgwY4E455RS3aNEi16BBA7fvvvu6ESNGuO7du5vwYOjffvuta9OmTUzPQsMSARGIEwEZ0eN0NfI8lsaNG7u9997bTZw40e255542I0Gtdeedd7r58+e7119/3W211VauXbt2eR6JuhcBESgFAvUSvpXCiegcMieA7ePWW291V199tdt0003dk08+6T788EPXsWNH161bt8w70pYiIAJlTUACpMQv/9dff+0uvvhis2scfvjh7rjjjrMzDkLkiCOOcB999JEZ00schU5PBEQgxwSkwsox0Dh19+OPP7qRI0ea2ooYjz//+c9m/8Bdt1+/fhb78a9//csdf/zxcRq2xiICIlBHCGgGUkcuVCbD/OGHH2yzJk2a2OvkyZPdm2++6c466yxz07399tvdl19+6bp27eqGDRvm6tWrl0m32kYEREAEUhKQF1ZKLHVzJVHlw4cPd0GQMAMh2pz3V155pQkSYj1QX/3pT3+yz+rmmWrUIiACcSCgGUgcrkKOxoCwuOiiiywY8KqrrjJXXboeN26cLZ944onuhRdesFiQ/fbbz2200UY5OnJ23cycOdPGJa+v7PhpLxEoNgHNQIp9BXJ4/Pr161tAILEczEQIFmzUqJFFlhP78cEHH7ibb77Z4j+KLTw47TfeeMNciHOIQF2JgAgUkIBmIAWEne9D3XjjjXZTxhX3xRdfdAsXLnTMRIhCv+yyy9yyZcvcwIED3Y477pjvoWTU/5IlS9whhxziGHfr1q0z2kcbiYAIxIeABEh8rkWtRrJ06VJ3wAEHuHvvvde8qwjvQZ2Fiy5CJBjWa3WQLHcmWHGTTTaxvRnPaqut5tZff317P3bsWMfYsc2oiYAI1C0CUmHVretV5Wi5KSM0UGPR8LA67bTTLNcV6iwM6sVolXNwkWvr6KOPdn/961/d7Nmz3cEHH+yeeuqppOG/GGPUMUVABLIjIAGSHbfY7YXgIE0Jsw6e6GnYP1q0aOFOPvlke+ov5KDx/MJIXjkHF0KNWRIzEFyJUa1tscUW7oEHHijk8HQsERCBHBCQAMkBxLh0MXjwYLd48WJHxDm1Psiyu8suu7gddtih4EMk/uT666+340ZzcDHraNasmTvhhBMcQYxdunSxWdL999/vfv7554KPUwcUARHInoBsINmzi+WeqLHIbfWxr+ux+eabuz322KNo48QLDMGw5ZZbWp6tkD6FHFybbbZZcly4H48aNcrttddeNotKfqCFCgRUQbICDr2JAYEG5/kWg3FoCDkigO2Dm/P222/vNvWJEovZiHrHE+z8889322yzjQmz1Vdf3V1yySUW//HII49YVDxjDiqvnXfeuZhDjvWxccGmVssxxxzjfvrpJ3fppZdaKv6111471uPW4EqXgHJhlei1pXAUN+WddtqpKGdI2pRJkya5e+65x45/+umnu8svvzxlDi5uhqizUGupVU2AGRxBoQjhG264IVlBEgcKbE1qIlBoAhIghSae5fF48uTmQewEBaAOOuigKnNZITyuueYaM6hnebha7Ua9EWqLXHDBBTbTIOqdhhC54oorbPycQ2irrrqqxYJg9C9kqwnTQo4r1bGiFSTHjBmTrCBJnjM87PbZZ59UuxVkHerSYs92C3KiOshKBGREXwlJ/FbgzXThhReafYD06xjI77777pQDjQoPPLCK0VZZZRX36quvWo2RcHyECF5Xf/zjH91XX30VVidfCy08asI0OcgiLDBOhHGcK0iikiQP20MPPWQVLYuASYcsEgHZQIoEviaHvemmm9zuu+/u+vTp4x5//HGbeRDBjadTCNCjvzgID4z4HTp0MJUKsyA8wNZZZx07XXJeoVKLQxqVTJnW5DrlY1uuKWZKKkX26tXLrvm0adPsRo0aCxdo1hezMba//OUv7rPPPnO///3vTdgVczw6duEISIAUjnXWR5o6dartS+6o999/31RTr7zyigXg4blEK7bwYDzMMMaPH2/eXwi85s2bmxoLg34QIqyLQ8uEaRzGiWpogw02sBt0586dLQiTmSX5zlBb4bJd7LZ8+XL36aefmucf9hgEilqZEPBPjGoxJ/Dyyy8nfA3zxKBBgxJe322j9XXMEz6HVHLkPuYi4asPJt8XcuHdd99N+BtZwmf6TXg7TcLbNxKMmeY9rRL7779/wtdcL+SQUh7L2zwS06dPt88yYZqykwKs9A8JCR9sWeFITzzxRMIHiiZee+21Cuvj9Oa///1vonfv3iuNPU5j1FhyS0AzkJg+KKCm+Pe//20R26iEsCugvpo7d66t9zdCi51o2LChncFvf/tbizwvxOmgk48mP8Sd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RKAwBOrsDGTChAlWtIdaB7T58+dbESIKN6mJgAiIgAjkn0CdFSAk2CMdeWjUxaZcZ7qGQRaPngrNr8tlC0bUr/0MKZftZ19uNpcNFr/4UrxfeMEb54bxfIUf53x/3YpdDrg6Tj/7cS70ZYIXeaN/nFv4jub62jesV6/CaVNRskGDBhXW6U1pEaizAgQVVpMmTZJXo3Hjxhm5pUZvQvW+/MI1vPSiZB9xXuh4cHzrYcSZm8ZWOAIPb7O126zRGoU7oI5UdAJ1VoBQnjXqLourZ3U1vXkaat68eRJ6YtlStzj5TgsiIAK1IdC0aVPXvPGatelC+9YxArnVixTw5Fu1amUV1cIhsYG0bt06vNWrCIiACIhAngnUWQHSvXt3Ry2Lb7/91i1cuND5es8VbCJ55qbuRUAERKDsCdRZFRauu88995wbMGCAQ52FQZ06z2oiIAIiIAKFIVBnBUg97/ExcuRIN2jQIPP0WG211QpDTEcRAREQAREwAnVWgITr16hRo7CoVxEQAREQgQISqLM2kAIy0qFEQAREQARSEJAASQFFq0RABERABKonIAFSPSNtIQIiIAIikIKABEgKKFolAiIgAiJQPQEJkOoZaQsREAEREIEUBCRAUkDRKhEQAREQgeoJSIBUz0hbiIAIiIAIpCAgAZICilaJgAiIgAhUT0ACpHpG2kIEREAERCAFAQmQFFC0SgREQAREoHoCEiDVM9IWIiACIiACKQhIgKSAolUiIAIiIALVE5AAqZ6RthABERABEUhBQAIkBRStEgEREAERqJ6ABEj1jLSFCIiACIhACgJ1vh5IinOqctWKFSvcggULkp/X98sNk++0IAIiUBsC/La++XFZsoumTZtasbfkCi2UHIFaCZBEImFAqA5YF1qDBg1cixYtkkNN+C/74uQ7LYiACNSGAAKjReM1a9NFxvuefPLJ7t577027/bx589yqq66adht9WDsCNRIgd9xxh12QQw891D3wwAPutNNOsyeMiy++2B155JG1G4n2FgEREIEMCRx99NFujz32sK1//PFHd9xxx7ljjz3W7b333skeVlmlRre35H5ayJxAxoQfeughd8wxx7grrrjChQu23XbbuZ122snxNMBr+/btMz+ythQBERCBLAnssssujj/a0qVLTYB06dLF9e/fP8senVuyZIlLVyJ72bJl9sDcsKEU3wFyxkZ0ZhyDBw92w4cPd08//bTZEsaMGeMuvPBCt+2227pp06aFPvUqAiIgAkUn8MILL7h11lnHvf322xXGwkzl+OOPt3WtWrVy119/vdt8881dkyZNXOfOnd19991XYfvXX3/d7bjjjq5x48b217t3bzd37twK25Trm4wFCMC22GIL4/Too4+6tm3bJmcczZs3dz/99FO5MtR5i4AIxJAAWhFu+nfeeWdydAsXLnTjx493BxxwgK37+uuv3ciRI90111zjWO7Vq5ep41955RX7HDtKt27d3Kabbupee+01N3nyZPfdd985hMgvv/yS7LdcFzIWIB06dHCPPPKImzNnjrv//vsNINDeeustm5Hss88+5cpQ5y0CIhBDAjj3oHa/++67kzd7ZhdrrbWW69mzZ3LEPXr0cPvtt59r1qyZu+iii1zLli3d2LFj7fNrr73W4b3J+06dOrm99trL3Xrrre6NN95wjz32WLKPcl3IWIAMHTrUvfzyy27jjTe2i/HHP/7RzZw5022zzTZu//33d+3atStXhjpvERCBmBLA2I72ZOrUqTbCcePGuQEDBriogR0BEm377ruvQ21FmzFjhltttdUcjkNsx9+QIUNs/3fffTe6W1kuZ2xEx0COwGDGgdBAX4jx6plnnnG77757WcLTSYuACMSbQJs2bUwFdddddzmWn3vuOcesItq4l0UbM5EgYHAYat26tQmQ6DYIFGYk5d4yFiCA+uGHH9ysWbPcq6++6kIMCOt5j05QXljQUBMBEYgTAYzmOP9gKMdIzl+0PfHEE+6QQw5JrsLWsf3229t79pkyZYrr16+fW3vttW3d999/766++mq36667Jvcp14WMBQhCAmAYy/FsqOzKhvCQACnXr5HOWwTiS+Cggw5yAwcOdJdeeqk755xzVhrogw8+aDYQ7BsIhpdeesnCFdiQ/UaPHu0GDRrkzj33XLOfIIyef/5594c//GGlvsptRcYC5B//+IeprjAcEXGqJgIiIAJ1gQCxHcwwsH+kihPBhkssGzMLvK0wuhPjRsO2+/DDD9vnOBJhD+FBGpXYmmsWJuo+zowzFiDz5893Bx54oIRHnK+mxiYCZUhgjTXWqKBST4WANEao2fGwqtzwyLrtttvcl19+6TbYYIPKHzuM6h999JHDpRdhVNlmstIOZbQiYy+s3XbbzT3++ONl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CXQOQmPOnDnuiSeesPIV6667bl04tWrHmHYGwskyTRs3btxKwoOe8ShAwhKd/tFHH1V7MG0gAiIgAqVGYP311zdVFpVZyaYRGuorZh0km+WPtEsU1AtVVcN2dfk17QzkqaeesijzdCe44YYbWqEp8mK1adMm3ab6TAREQARKkgBuu/fdd5+bOHGixcShveGeSGG8aJbwxYsXW5nuM888M1m+oi4DSTsDIQV7VSlEoidNQShVH4sS0bIIiEC5EUCVFeI8sBVjO44KD3iQwRzHo3SeW3WJW9oZCFUDmYUQB5IqRxUniovajBkzap1IsS5B01hFQATKmwB5AfmLNoQF5SXSNeookRi2VFraGUj//v3NOE4gTKpGQaljjjnGqhFusskmqTbROhEQAREQgRIlkHYGgmfBJZdcYvU5qPlBLEjbtm1tRkJ23tGjR1s1QVK5q4mACIiACJQXgbQCBBSE6hNxySu+zqH6YMuWLS0G5LrrrkuWoi0vdDpbERABEShvAtUKEPAQLPj666+bTzMBhdTgoEZ6XWsY+pctW/a/YXsVnJoIiEBuCKDSXlK/XrKz1VdfvSQ8jZInpIWVCGQkQMJeCA4M63W5VXAG8OVz1URABHJDgN9Whd9XbrpVLzEmUCMBEuPzyGho9evXt/rpYeOEf0JaHN7oVQREoFYEmHGsscYateoj053JyadWfAJlJUCKj1sjEAERyAWBkSNH5qIb9VFLAmndeGvZt3YXAREQAREoYQISICV8cXVqIiACIpBPAhIg+aSrvkVABESghAlIgJTwxdWpiYAIiEA+CUiA5JOu+hYBERCBEiYgAVLCF1enJgIiIAL5JCABkk+66lsEREAESpiABEgJX1ydmgiIgAjkk4AESD7pqm8REAERKGECEiAlfHF1aiIgAiKQTwISIPmkq75FQAREoIQJSICU8MXVqYmACIhAPglIgOSTrvoWAREQgRImIAFSwhdXpyYCIiAC+SQgAZJPuupbBERABEqYQMHqgVBK9tFHH3UvvPCC22CDDdxRRx3lmjVrlkT78MMPu+eee86ts8467thjj7VXPvz222/dAw884N577z2rzX744Ycny2S+8847jv0WL17s+vTp47p06ZLsTwsiIAIiIAL5JVCwGci4cePcyy+/7I4//ni36qqruhEjRiTPDCHA36GHHuoaNmzohg0b5qhfTrvgggvcwoULXf/+/d20adPczTffbOvnzZvnzj33XCuxu/POO7sLL7zQzZw50z7TPxEQAREQgfwTKJgAWbFihRsyZIjbfPPNTRh8+OGH7vvvv7czvOOOO9zQoUPddtttZ8KjQYMG7pVXXnHvv/++++STT9zw4cPts1GjRtlshL4mTJjg9txzT9ezZ0/Xq1cv17dvX/ss/8h0BBEQAREQAQgUTIV16qmnGvE5c+a4e+65x9RRa621llu+fLljNtGuXbvkFdlss81McDRv3tzW16tXzz7beOON3dKlS913333n5s6d67p27Zrch/2nT5+efJ9qIZFIOIRPaAl/bDUREIHcEOC3zF9oPAiG325Yp9fSIlAwAQI2buCommbNmuUGDhxo77/++mu3yiqruNVWWy1JtnHjxm7BggXu559/dk2aNEmuZyF8htCJfhbWV9i40huEx/z585Nr6y1d5lbrsmPyfZwX+q7TIs7D09hEwC3/fqGbv3RJkkTLli3tt51coYWSI1BQAcLTyJgxY8ymccQRR7j11lvPbbXVViYosHnUr/+rRu3HH380QztCheVo4/3aa6/t1lhjDffTTz8lP8JIz4wmXaP/pk2b/m8Tlo878X/vc7D0ww8/2FMXAi2X7cpcdub7YiYHywo8cnyMXHTHE+2iRYvswYEHjTg3Hnr4zvLdjHODJw9z0QewfIw3/J7z0bf6jAeBgvwimUk8/vjjrkePHvZEggDYdttt3YwZM9wuu+xihnNmIq1atTIqzBJ23XVXxxQ4OmPgi88NpUWLFrbtV199laTIdq1bt06+T7XAFzrfP248wgpxnFTnV5N1cESA5JtHTcaUatvwAMGNGeeLODcECE4gcWfKwwMPbHEfZ5yvtcb2K4GCGNH5UeHCO3nyZDsq6qeXXnrJdezY0d5jDL/33nvNPoG77uzZs12nTp3c9ttvb7aON954w77w48ePN4HDDbp79+7uscceMzdfvLQmTZpUwSaiCywCIiACIpBfAvX8VDaR30P82jsuttddd53ZNlBF/O53v3P9+vWzDxEoZ5xxhgvqn8GDB7s99tjDPps6daq76KKLTD2FUR0bCrEiDPvyyy93U6ZMsScpDOpR1+BCnFOqYzCTQsAx1jg3WDOjq27WVuxzYAZCLBCzzrjPQL744gtTteVbNVTbawJPZiD8jtREoDYECiZAwiC5cVX1A8O7Cp18Zc8NjN/c7FB9VW5LliwxVVfUCF95m0K+lwDJLW0JkNzypDcJkNwzLdceC2IDicKtSniwTTQyPboPtpBUwoNtGjVqFN1UyyIgAiIgAgUiUPAZSIHOq2iHCXEmCL04N1QY/MXdswlVJUzrQkwBjgmoL/mLc6sr39E4M9TYfiUgAaJvggiIgAiIQFYE4v2olNUpaScREAEREIFCEJAAKQRlHUMEREAESpCABEgJXlSdkgiIgAgUgoAESCEo6xgiIAIiUIIEJEBK8KLqlERABESgEAQkQApBWccQAREQgRIk8H+qSUNzoOFJugAAAABJRU5ErkJggg==)

    # Fehlende Werte prüfen

    Welche Spalten haben viele fehlende Werte?

    ``` text
    vis_miss(d_train)
    ```

    ![](data:image/png;base64,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fvWrX7kDDzzQ/exnP0tfZ9WjqkVgCT/Qo6rtvTouBBoYgR9//NEtuWS2YP/hhx+66667zs2ZM8cNGzbMdejQoYGfqtsJgeZBIHukN08b9NSUIPDee++5d955JyW9qXs3/vvf/7oLLrigxoVrrbWWMY7999/fnXDCCW7WrFk1ztEOIZBEBKTCSuJbq9A2L1y40P3zn/+0CfIXv/iFO+CAA9x6661Xoa1t+GYttdRS7uOPPza7R8uWLWs8YL/99jPp5KKLLnI33nijW3bZZWucox1CIEkILHWupyQ1WG2tXATWXHNN16VLF9e9e3eHNMJEyUT6y1/+snIb3cAt++KLL4yJBDXVu+++6z744AO3xhpr2JM22mgjN2PGDDd37ly39dZbN/DTdTsh0LQIyAbStHin7mn5dP6hk+j8zz77bNejRw939NFHh92p+vzPf/7jJk6c6Nq1a+d22GEHYxajRo1yF154oZs2bZp79NFH3ZdffulWXnllN3ToUOs7nln9+/d3d911Vw17SarAUWdSj4BsIKl/xY3bwauuusp9/vnneR/CKvzPf/6zu/fee1Or96d/G264oXvkkUdM4lp77bXdp59+6r755hv31FNPmefVpZde6hYvXmzfAQqpbPPNN3dvvPFGXty0UwgkBQExkKS8qQpt5zrrrOOefPLJgq1jQj3ttNNsRc4kmjZasGCB22CDDUy6QFWFEwFqvOnTp7s999zTwTxw5/31r3/tkFYC7bbbbu6VV14JX/UpBBKJgBhIIl9b5TR6++23d4899limQV9//bVNnngkBdpll13cuuuu62bOnBl2pebzkEMOcYMHD3bPP/+8GcVXWWUVU2WByRZbbOGOO+44N2LECPfyyy87cAiE/WPvvfcOXxP1We3edol6WY3cWHlhNTLAabv9Dz/84B5++GFHbANeVj//+c/N6wjGgT0EaWPjjTd2V199tRs5cqRr3bq1QcBq/Nlnn3XbbLNNoiEhbAoDeDCSwxTatm1rdpCDDz7YrbTSSvaHJAJWSB785RIeW8svv3zu7kR8r3Zvu0S8pCZqpLywmgjotDzmwQcfdPPnzzc9Pl5WPXv2NAbCpELENWqqQYMGmdF4woQJthqn76i6sIVgUE8yoYY69NBDze7Rpk0b68pqq61mTCIwS3bCQJZYYgmTvJLc33xtl7ddPlSqc59UWNX53svuNW6puKT+9re/NQMxqTrwPsLbCLXM008/7R5//HGTNHBpDbT00ku7P/zhD+FrYj8xgCOFnH/++UVtP2DyzDPPJLafuQ1Huswl0rL06dPHXX755W7MmDHuhhtuyD1F31OOgBhIyl9wQ3cPxnH77be78ePHu6+++sqYCS6s6MVZcV922WXmvkp4Ea6qcVpxxRXjXxO5jfSF5AEDKcZENtlkE4dKKw1UKMI+9K0avO1CX6v9k4XEHXfcYbY9bH9SYVX7iCih/7jpBgN4q1at3B577GGGciQRvInQ5+NpxETTsWNH161bN9vPuWmjjz76yNR0RJUTbQ+jxAsrqLNCf2GmK6ywQvia6E9yeyFp/uY3vymYDBLJjJQtuHX36tXLxkSiO/1T41kYMf6J4xE5y6CAQ8jhhx/uvv/+ezEQDYriCLz55pvuxBNPdG+//bb729/+5t566y1TWZFdlqhqmAfEZIl9hEkmzYT+f6uttrIAQDzLijGRNOFQW4Q9fYWR4iiBTQibVxoIBjJlyhR3yy232NinX9XMTM455xxzTcd55uabb3ZSYaVhlDdiH66//nrzrLrmmmvc3//+d/ftt9+6448/vkbwIJ5X//rXvxqxJZVz68A0aRGMNKizXnzxxcppZD1bgrPA6NGjzbaFzQebTnDXJsL+r3/9q9k86HucgrddfF+StxnXJ510ktl5cJIgGSbOIdVCqGwDoWHAsxA7KN6Wu+++uxhIAEef+RFg5UkwIISUQYoOdN7nnXeeue2Gq1DZ5MtEG44n6RM9L8wAUb2UagcwkUsuucSkkST1s1hby4mw537bbrtt4jMyy2Hg/0fGv//9b2OeFEYbN26caRt23XVX97vf/c7tvPPODjWubCDFfkVVemzq1KmmzyZbLJHWRJrvtNNOhgaMomvXrm7SpEnmvrvppptmUGrRokVmO6kbrLBYcbLKxouKfFWdO3c2tUyxPiHSpym7Ll5VOEwgUSB54hTw3XffOeJ9eOd4XhFxj3cd+0LCTOwlMJEkY3HllVeaena55Zar8cpRz2233Xbu4osvtkBRVJppJZxeeJ/UsMG2ueWWW9rfSy+9ZNIoKXvEQNL69uvRL+wcrD7WX399myyYTDAkElkNMahI0/6Pf/zD4kDq8aiKu3Ty5MnGGDEGs8KChg8fbhNkWvT6pYCOURyPOuw8r7/+uqkrcJogceRBBx2UMZij0uzbt69bZpllMrdNMvOgEyyaSEuDfSsfpdVhIF9f582bZwGvBA8jaeMYg+PM6quvbjnfENFFQiALAb+yiHwwYGaf14NG3rMm8llmIy/e234f9xH5lXrmnLRseEeByNt9srrjEyVGPmAy8hNLZv9zzz2X2U7LhrdhRT6OJ/Lu2dYlv5CIvKQRvfDCC5kuHnnkkZEPFs18T+OGz7IQ/f73v890DTy8NBp56TSzj40zzzwz8k4DWfvS+sV74UV77bVX5DNsZ3VREkg+tlvl+0ixgdsmUgaGQ7xOSNlx2223uXvuucdWpESVn3LKKZlUJWmBDJUMDgOsskKqkXY+zgXDOZ44uKjikYYPPPrgtLjq8m5JPYOB9C9/+YtDHYmqhjQsaY+wR21JITSyJ5NZedVVV7WsCahtUduh80fSuvbaaw0PJBCIQEpqu6DKSxORUYKg3z/96U9mNEfzgDMBKr0//vGP9ltAEjWPyyx2oi9C4CcEWIn6EqwR0kgg74URsfL2BrXI54MKu1Pz6d2QI/roGUjk65dEPiV7pm+sPr1KK4OH1/tnjiV9w3tc2erST5LWldmzZ1tfvSG9Rte8/jvKt7/GiQnacf/990e+Zn105513Rr179458/ZbIe6BFnqlETzzxRKa/fPeJMTM9QxKLSyqZAwna8CmIIv4CMQYGDBgQ+QVF5BOEmuR9xRVXhMOGiffCtGPslBtvmpYODdgXVp5k2h0yZIj77LPP7M7YPkhXQvoKfP7TRBgE/Q/FVpzHHHOMSV0nn3zy/+t5fUfxzKHGB6tVKEgn9iXh/1hds6pmRQ2xCvcTqvOTp9m54t1LU4R96Fc1p+fBQeLUU081ux94IInx/vv162eBwUjfpCnCacLzC/O+QkInFgoSAzEY9M+vwrLcckGEeA8GkF+ROK8HTzVIeJVRihfGgLoKUR1vI9K1sw1TIQI/TV439913n71T3LRJgomhNBD9xDWZOCAm2EAsIkJ53rAv6Z/VnJ6HiHJ+44GJoLJjsUTVTJwozjrrLFNVo7qmumiui7NsIEkf/Q3UfvSd2DoYTIGwB6AHxxsL/ThxEXjb4I3ERJIW4kdBfMvAgQMd9TwgUpagA+/WrZuVpN1xxx3NrTUtfaYfY8eONZdb3jNumuf6tCxImIFBgMXHH39sOc/QgaeJlJ7n/99mSLlDFgkCRWEojHWyTrRv395+A6QpYpGBt134fYSxIAYSkKjyT5gHEwpG4lzClROXViYWcmKRcTdfjYvc6yrxOxMifYjnrqJ6IBG3Xv9thlTiAG699VZz3SW+oVOnTlnnV2K/ymkTkygOAfQR90xqmVD8iu/BZfmBBx6wmi9pYiBKz/O/0UIGZVK18LvHeI4bO84hDz30kCVHxV3Xe1+6I444Iu9vYAkMIf+7nbaqCQGq6KHTxruCYUD2WLyLNttss9TCQAZhyswOHTo000f6jB2AlRbMkkqBeJiwMk8zEeuAnQcPrGD/IGiUjALUbEetReEw0paE42nAgzQc++yzj6VnIQiSdCz0k+j7+Aqb38Sxxx5rarw09Du3D9j0wME7D1i/6S+SOIsKxgVF4fhdkAuPGJB8lB49RL7eaV8NBEJuGwzjJEND/0vOI+95YgyEVO1pJtxTQ/Gr0E9Ss5AYkgkEvS9qq7QzD/qOey7GUKKqA6GyxLDKJ0wU19U0MQ/6WY3pecL7jX/yXmEaQR2NOotcX9i8CKTlD0m8EPPgXlJhxRFN+TbR5dToJjUHPu8+EMqiyykAhQcSEwrpO0hVkuaMo4jqrLRJuQGRogHdf/DvT/kwyOoeDAQJI2QaYBIhkpwobJhq0qPKQ2erOT1PwCD3k3eNFAo2LBiwb8JMsIeQzieu5s29NnyXBBKQSPHnrFmzzBBKvibUVDARJA4I3TaJEW+66SbL749IT8GYNBP6XhgIjLPaiUBIHCTAg4A5svCmkcgkS6p5CH3+PJ+iAwk8EBIn6ioWVtVEqKpQ62IgZw5AvccCcptttikJBkkgJcGU7JNwxURsh1nww8FVNeS2ITkcROI0RFUmV4zI2AHSsvrMfXuI7qGOB666FEKqZkLv79NUmB0AdRZMhGhsDKhpIfrC74AU5DALJC/UlcT/MFmyGse4zmLLp61JS7dr7QdSB+7pIbcVaftxJimVxEBKRSrB5yGe4pKHUeyAAw5wPXr0yKQlgGkEJkIXMajjZYX4Gk9hkeDu5206fSPWAYMxldVQ6zGJpJVwwSaug9gPjKcsJuL9RXVBygomE4znqDUImsSFOw3Eoqla0/PU9v4YB8wPMNV2MTf+2q7juBhIKSgl/BzEd4zmRJQSEEQufybMfLltyP3PD80nzbPjCe960eZjPIeZkteLegdMnPi7pynKHABYWeNpxOKB1Tb2LiaNfN52jAmyDJCFIC3MIwwCXJUJCsVNlXeMQwWSV9D1EwNBPIyodATEQErHKpFn4mUBM8BIevrppztcd+NMBPUNUegHHnigTZ78yHDtS4NBmQBBXBTxYyctB33DDhQnJhESJ+K2ihsvK3Qm1rQkSaSvGMlRTaCWJK4D5oGagroObdu2jcORim3UtHF33NApXLQxGuNlhp4fJgIWLBpwZ0dtV82E/ZPFI1iUSooDKRWpBJ6HDzcFkQgKusVnkoVQS2A0J9IaHTATaFqJifONN96wvD5UGKSuCW6JYcWZ1n7n9gs1HUGgpGgBD3z9fYp6+2M7bYSTCNmjsXXhihxX0ZKqAwkMYzkZZ1HbpJVQWzLeYQxoHZBAYZj5iHPwysSYDnMtlSSBlIpUQs/Do4oCUei2WVWj62Y1iiSCux6r77TSOeecY0GDSB143JDXCnsHahqcBtJMqK3w58fWw3snxgWJDCM5zhG4ayNl4sKcNiJzAIskCkMhWcdr2GNAxyaY9vQ8dVFblss8GDdiICn79TBJ3HjjjRZRTsoOoqyJLCVFAauQ4OsNE8HPP61iO3YfJA5qNbDKxvuGdCwExjGhYjRMM2HLOtfntmIyZZXNxIn66r333rOMq7i0kmmZ8ZA2Qsp+5513HKospBAwyKU0pefJ7RvfS1Vb1od58BwxEFBIETFwfGU55+sUONQ2lJ1lImGbIjAkCAxMJK3Mg9eJpEXgJPYPou1ZiULov6nzHVdr2IGU/WvnvWnIZ8VKnAkUwzGMBBddVHjYw9Jk54m/PtSyqLAIFMVoznjPx0SQTJDQCCJNam63eL/j2zjMQCwig9oSrQPqbLCB6ss8uIcYCCgklEi5jJgeJkMCgi666CJz1yUxHgZkDITYQYYNG2ZMhPgPPI/SSHhRTZs2zew6qKhQz2AoJsso/v7UuMB9FQaSRkJtwfsNkyVqGtR3LCCId8HzjskSI2naJI98DhNI2DARAiWJg2IxBQ5ptfsxzqnnwW8eF/Xa1JY4luA8UhebR+7vRgwkF5EEfQ+GwJCCm+hymAXR5hSAIcaD6FoiTFFfoLLg3DRKHqgtqNmBJxX9RWXDhImNJwRJwTgxEqaVWEAwWeJ5x0QJoapDIsWJAgkkTfVM4u8RtS1GY1xxsXOBAypbJDHSk48fP96yDFsZ1viFKdmmHAPxW3iWEc+Di3ptaksWGJStrhf5wSZKMAJ+VWVlJ72Yar3w3lUR295gHPlJNfI/psinK0hlCdr4a6PUqpe+bJefMCPvihz5xJDxU6pi2+v9I++uG/l6Dpn+UobVqy6sVGtmZ8o2vJNI5FP1R14qj/xCIvKu6pFX40Q+y27KelqzO4z9o446ysoxey+zyDvORL5AVOQXjdErr7wS+Rr3VobaLzBqXlzPPenOV10v1pqMi/Hth8hjhFsutRxef/1124cXDjp/9LtpK0FrHfT/SIxIiU36inoKYmWFq+Ypp5xi3w866CD7TOM/+o+TAOor7DxUjyQVDX3HeQLpCwkEF01WpGkkHCaQQBkDOEkEhwmq6eG2m1aVbXiX2DLoJ9oHvC7RMGDrRCpBjY1bc2ORkik2FrJNcF8mDYzjMBFUVTAR9qH3pa4xidIInkvzBIqqgj6isqEsLbmMIALkYCKoLtKaIJB+kp4E1RSR5rhls4jASI69ByMxkwsYpZF5MNbR49NPnAQY/6it8LaDsHuxmEgzeQHCVNXYMSg7zcIBRxoCRXGSiLswNwoO9ZRgdHkzIuCDwSKv449mzJhhrchVZzVj0xrl0d41NaOG8fmcIh8kFfliN5lneQYSocrgvECo8dJI9N/bNSK/usx0zzPKyNu/Il8wK/JG5cz+NG6gqkNl6e0bkTceR+DhU5BHPjVJ5OtYRD7jruGQxr7Tp+eeey7y3oWRZ5aRX0RmuumZSIRKywdJRn4BldnfWBsyojcKW26am+a6anbzhZAIDkOlgfE4bW6a8azCIEzahVdffdX6imcNUhfiO2VZMSRiMMadN61EShokLrzKMJ7yxxjAiYAKe8TApJFwS8UhhLxeeJlhQCe78tFHH10VDhOoqJEqBw0aZNI3waF43uGSjMSNtxkSWb9+/QpGnjfYuGgszqT7Ng4CGMi9XjPr5l51EXXv3j0jiQSDetZJCf7iPasin5bFnAJYaXr3RJNEvNtu5CeSyE8cUdxA6HN7RZ6xJLjH+Zvudf1mDPXqysjbNOx903+MxvH+I4l4xpL/Jgnc64Mfs1rtbRsR0nYgVtzezmGSSNiX5k9fsyPyHlfWRc9IIu+mHfnYjsy+pux7epdnDcZiK+tGpOHwHjZu7NixmYZhJCQ9A1HnrEgxpKeJ8G+nb0RXEwyF4Rh9N4ZD/+OxVRiFcND3QxhRQyxEmnBAsvCqC3NXRtrynjaWKBNJK95/4oKCQ0HS+z9nzhzrIwFxgbDn4LIciOSXuOeS2wp80k64KRP3gtuuV+W5oUOHWvZkfiPYAZuUmpJb6VkNgwD632py1cQ1EVuHT78S+bxeEZKHz3NlK28f+2LfWYmzMkszFXJVZYWe5v774NDILwoyun5fPdFsXT6zbuZ148Z62223mUu7zzyd2Z/GDVz1sXF5Q7n9HuijT5hpdhF+D01JsoE0Kbsu72EESKHXZ3XhVTjmZYXXhTeWOlZorMz5o44xEkraCE8S7yjgiK5HAiEVA26KbGMH8Oo7+0PySmOQJO+zWG4vou5x301r/0n+iIsuwZBIG9g+wAOPMzzsPOOw6HKkMLyykM5y0/Yn+TeRWwyMYGCIAnFoHkiWSnJMbEBNXkW0KbmVnlV3BAiE8sawyP8wIp+mIPK+/qbz5E4c8wbzyPt7WxBV3e+erCuQRJAyvPHQbCJBEvHqrGR1pA6t9Wo5C4jjEu+yG3kjudlBwi2wfyCVpZWw5bDS9uo7865CCgteR16VaZ5oEyZMMCl04cKF5plEQGFaCHsm/ceuFySvECTqa9dYwCweV80VMKl6IBW8NMHPnUBAVtVehWMtRc/PSoM/PG7STPmC5ND/nn322Wb/YMWN9w0rzrT6+8+dO9e8bQgS85OiO+OMM0zvjZcdMUDYerAHpZV41wTChoBZP4ma3Yv4F/I4Qd6d3bzxyDBMqhrPZBILBx5meFcGTQLJIBnf1PII9W0GDhxoY4CM2s1NMqI39xso8nxUE6humCiYPCBcc/v06WNZNotcmopD+YLkSAJIwkhyPFFdDnVGWpkHL5F+wijJZcakQoK8sJg49NBDU8086D/vOx4EicqGJJlkmw4ZF1BX8bvAtTXJzIP++vQ7tkigGByEqo6FVGAeuOjDZKZMmWLHm/1fWkS9tPbDZ9u1YCHy2wTyqSoiP6DC19R9VnuQHGqruCs2gaKoMdMeHBgGMv0Pbrpetx/16tUr8mlZwuHIZ5a2PGdNbTDONKARN8hd55mjBUXyOyBg0Nv77DsqXAgV1g033NCIrSj91jKiNzsLz27AZ599Zik4/AAxsZwVNm6prManT5/upk6daoZzVBkUy0krVWuQHO8T90zck3FJxUWXFTdpSnDPrYZyvN6LyqQJVt777ruvZdcdPny4GcxRV+E4ggRC4GTaCIcRVNOPP/64FYGjiiaSZ6UWA5MNpMJGIPmryOvEpIH9A+8q/P+9wdhyW5Gi3LtsZon1FdaFspuDhxkMEn03yfGYRL1B1FLTh6h68htRKCotcQ6FwCLGhUmD5HioMjt27GgTp0/TUeiSVO3nHaPrZzI9/vjjTV2FpxGTqc+0nLosC7kvj987JZmxebJ4hGniYYY91EtkFdN/MZDcN9eM333qZaugRyK8QGQXZfCQWZNypDAYBhBum2kjmAWuyGHSCEwEV01clgMTSVu/6Q+SJ6lacMmEOR555JFulVVWMdsXEsm4ceMsUSaSWRoLIqHzJyUJ/Q4GZJgISUJxGICJpJnyvX/ec5yJBFwqCQcZ0SvobSCy506SiLD4gUOUKGUFigENv/i0EeoaUpGjpvA1DEzKQgohJTnRtmklVptEldN/sqnOnz/fSs56TbTlMiLmB1zSyjx4r6huqGOOajYYkDGO42EG84S5pJUKvX+cB4j/Yk7gd1CJJAbSjG+FdASoqZAm+OGw4qB2Q9zDghUpE0sgmAiBU/WuJBZu2Myf3jhqAVHxSYPJEvVNnIkEz6Nmbm6DPp6JA6kLTzvevc8ga/f3kcaWuuXee+/Nel4aJA9S7aCWgVgwUbOdpH9ImAQCMlnyWwjn4IWF1+H222+fhUUavpTy/uk/TIRqm5VIMqI341vxgUCWw5+CL+T2GTVqlBUFuvnmm83Pmx/b6NGjbTUK4wiUlgyz9I1o2iWWWMIMhtRyYNWFzp+6zkhbMNk0luFFukBdg+pirbXWcr56nsW04KaJm/K6665r8R/Ucom7sYYxkNRPVLJIUmQSIHcVLsrEbhDzhOoWYzl1LVhY8ZtgjDB5EguRJqrL+ye6vGIzLJTusKUzGxIB/yMy1zxvJM/cFndNclwRWUzkrZ9co9mzZ2eOp2mDKFqvron8xGFld4PrYsgq6+u9W/85njbCPXPMmDFR//79rWu4re6///6RT8seUY4X8ipKO562eiZ+1R2RTdfbNCIvWVhfwz/ym/nAQYsqv8XXOuE79S3SRml6/1JhNdOyBhdEn4baggRDE6hhQelZxHfUWieccELqVl6hr6yqWWniIBDEdNQXqKpQ0REwR00DIs3TRvQd7zoCIVHjMBZQUyCJIX2gwsMDifff6BXlmhhc+k71RBwEqFkSt+UhieOqzjmeuZo0gjdi2ihN718qrGYanR06dLACMESYEl0bPG6I/6BAED7/aSYYA0ZSJstQGAi1xqJFi5yXupzPrprKlOy8U1SQeJoRUTx58mQrw4rKDm8jPM8gvI9w504j0X9fSdAWD6juSMVOTNM8n5qc2BdfaS+N3c70KU3vX268mdfaPBsYzC+//HL7ETFxUt+aSmPVQmQYxg5CZtWNNtqoWrpt/YRZYAfwSQDN1z/XAy/tYNB/vOtISYKRHGcC3HVZUFUDpeH9i4FUwEiFiZA0DZ9vUpNXGwUm4mucuzXWWKOquh8mEXIeUZq02igwEZ+WxPmaFlaSuZowSPr7rxcD8cYte9fobkX1QwAmgjqHqNM0VtOrDR2krzTaO2rrN8eZRLAFpDkpZDEc1P/kvv86MRDvOWIFS/DLxkc9GPkw/JEZVFQ/BGAiPomcxT/U7066WggIASHQ+AiUzEDGjx/v9ttvP0upAePAdx0PCXL1o8PHoyhtvtqND3/NJ7Aaw0tDJASEgBCodARKnqmQOMjDRMoFXx3LkTGToCCYBqknHnvsMTGQBnjbYh4NAKJuIQSEQJMgUHIcCIn8QgZUGAjxCkHiwOWUSnEiISAEhIAQqB4ESmYgGDgnTpxoxr67777b7bXXXoYSif6mTZvmevToUT2oqadCQAgIASHgSraBkNQPX21SLGP/oP4wEdNIJT4Ng6Nms0gICAEhIASqB4GSGQiQfPHFF5ZanGL2LVu2dBQAInK0uYq7v/rqq27ChAmWdI0iRF26dEnkm6t2d2j1v7rd4fX+k/v+68RAKml2RhLCG4yMpgxAivEQiEV2z6QRBZMg6l5UI6n/ev8a/8n8/ZfshcULXrBggdVmJvVCWDWECQ+bSDCqh32N+RlSQvfs2dMeQ10FPMUGDx7cmI/VvYWAEBACQuAnBEpmIGROJUcN3lakmyCDapxgHk3JQPAKIwlbIJITYpcpRqSLoMZApRGxHxCMuRpJ/df71/ivzN8/tXmK1R8qmYGQ8A7bB9HSZI5tbkKFhR0mEB0lNqUYITWFSme551FOs7koSHPVmhJG/U+uDrwhfjN6/83//tu0aZP3VZLgs0EYCCqifffdtyKYBz2lhkI89oSSqCuttFJeEMJOgvTwIMtHeJmFgZzvuPYJASEgBNKIAAvXQvNibf0tOQ4EF17qVFcKtWrVylE7OhAMrnXr1uGrPoWAEBACQqCREShZhUUeLF9m0lGjmWIwuWos7BHrrbdeIzf3f7enfjbFlwhgpGobKcHTXojmf73XlhAQAkKg+REomYFQYpQKavzdeeedNVrOvqZkINtuu6174okn3MEHH2zqLBjYLrvsUqNd2iEEhIAQEAKNg0Bi40ACHBjFkUAoiVkfevzxx2UDqQ+AulYICIFEIoANBBNFOVSyDYSbY2c48cQTzRuL4jf77LOPFUD68ccfy3l2g1yDl0B9mUeDNEQ3EQJCQAhUGQIlM5DPPvvM6n/cfPPNDpcvbCEffvihBe4ddthhWr1X2cBRd4WAEBACJdtALr30UkcgHlJIixYtMsjNmDHDbbXVVu700083ySRzQBtCQAgIASGQagRKlkBefPFFd9xxx2UxD5ChKiEeURSUEgkBISAEhED1IFAyA1l55ZXdK6+8UgOZxYsXm2cWkeAiISAEhIAQqB4ESlZhUfMDuwf1z3v16mUVCUnlftNNN1kKke7du1c8aqjgCqU7URR6xb8+NVAICIFGQIC5L2TEzr098X54uRaiOrnxnn322W7kyJEOryvsICQmRDK57rrrXJ8+fQo9IxH75cabiNekRgoBIdDACNTHjbdODIR2z5492z3//PPu/fffd+3atbOo9DXXXLOBu9T0txMDaXrM9UQhIASaH4H6MJCiKqzp06e7+fPnu969e1vlQZhHIPJOfffdd1YfhH0EohTK6Biu0acQEAJCQAikB4GiDITcV6QogYGMHj3aXXvttQV7Pm7cODGQgujogBAQAkIgfQjUWYWVPgj+v0dSYaX1zapfQkAIFEOgPiqskt14izUAV17qcYiEgBAQAkKgehAomYGcdtpp7qqrrsqLDJUKb7vttrzHtFMICAEhIATSiUBRGwieViNGjLCeE2lOxb/XX389C4lFixa5N9980+qkZx0o8IX8WaNGjcrcN5w2YcIES89OvfUBAwZk7vfpp5+6e++91567xRZbuL59+2ZKLL766quO63An3nvvvV2XLl3C7fQpBISAEBACjYxAUQlk7bXXtskapkEyRSoAsh3/ozb5qaee6nr27FlrU+fNm+fOOOMMN2vWrKxzYQL8EUuyzDLLuEGDBlmsCSfBwL744gvXr18/S5dy44032rU8d9iwYa5z586O2iAXXHCBMbKsG+uLEBACQkAINBoCRSUQnoq0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Rw934YUXZvZzH+65cOHCzL7PP//cHXbYYZnvlb7x+9//3sYC42HnnXe2d//nP//Zff/9983e9OnTp7tvvvmmYDvKGQvc7w9/+IPbdddd3TnnnOM+/PDDzP2LHcuc5DeKnffyyy/b2DniiCPc+++/n7nsoosucuPHj898T9o4EQPJvDptLFiwwD3zzDPuuuuuywKDifmGG25wTzzxhO0ninm77bbLOqfUL/W5ttAzHn30Ubf66qu7NdZYI+8pTOTffvttjWNM6P/5z38ck+V9993nhg4dWuOcsOP11193e+65p2PyCsR9mQAmT57snnzySTdr1iw7dPvtt7utttrKrbTSSuFUt8oqq7h27dq5Bx54ILOvkjdeeuklR2DrmWee6c444wyb/K6++mrDqrnb3bVr14IMJD4WPvvsM7d48eKSmgvzIHgT5rHiiiu6Xr16ZcZMsWPxmxc77+yzzzYsCeDktwQx9hh3jKtASRsnYiDhzenTEGCAP//88+7jjz/OIIJEwko00M9+9jO3wQYbhK9u6tSp7vLLL3f33HNP1g823/74ta+88op76623jDFdddVVWZMzN6cdTFovvviie+qpp9x7772XeWbYiKLIJrjjjjsu7Mp8MqGfcMIJ1lZ+rHHi3m+88YbjufTtlltucddcc43773//Gz/NtmEO22+/vdttt92yjhHZ3759e7fMMsu4Tp06WXt/+OEHx0r99NNPzzqXL7SRCbk2SafGhc20Y+ONN3a77767SVOHHHKIGz58uE14NGfSpElu3rx5tthAMoNYaIwePdpdf/317t1337V9/Pvyyy/drbfealjHGTDHYFSjRo1yd955Z5Z0A1P+9NNP3R133GHPCKv2f/7zn4YfE29uupfcscBiCKZ97rnnug8++IDH5SXe+dixY+29Mf4HDx5s44DxW+xY/Ga1nffaa685UgkxTp577jm7FKmXcbLUUkvFb5WocSIGkvXq9GX55Zd3PXv2NGYQ0Bg3bpzr27dv+GoTBxMz9Mc//tGxukK1geSyzz77FN3PpBOu5Ue73377uREjRjikH1RBEyZMsOsvu+wyt//++9t+Jq8DDjgg88OzE376B3P57rvvMgyNHzKquF122cXtvffeNoHAKNZZZ534ZW7u3Llus802c0sssYTtZ7X91VdfuY8++ijrPL6su+66DgkEiSWcz/4t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)

    Mit `{VIM}` kann man einen Datensatz gut auf fehlende Werte hin
    untersuchen:

    ``` text
    aggr(d_train)
    ```

    ![](data:image/png;base64,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)

    # Rezept

    ## Rezept definieren {#rezept-definieren}

    ``` text
    rec1 <-
      recipe(revenue ~ ., data = d_train) %>% 
      #update_role(all_predictors(), new_role = "id") %>% 
      #update_role(popularity, runtime, revenue, budget, original_language) %>% 
      #update_role(revenue, new_role = "outcome") %>% 
      step_mutate(budget = if_else(budget < 10, 10, budget)) %>% 
      step_log(budget) %>% 
      step_mutate(release_date = mdy(release_date)) %>% 
      step_date(release_date, features = c("year", "month"), keep_original_cols = FALSE) %>% 
      step_impute_knn(all_predictors()) %>% 
      step_dummy(all_nominal())

    rec1
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

    ``` text
    tidy(rec1)
    ```

        ## # A tibble: 6 × 6
        ##   number operation type       trained skip  id              
        ##    <int> <chr>     <chr>      <lgl>   <lgl> <chr>           
        ## 1      1 step      mutate     FALSE   FALSE mutate_FvTZg    
        ## 2      2 step      log        FALSE   FALSE log_2da9i       
        ## 3      3 step      mutate     FALSE   FALSE mutate_AYZMJ    
        ## 4      4 step      date       FALSE   FALSE date_24EWq      
        ## 5      5 step      impute_knn FALSE   FALSE impute_knn_YNZ0Z
        ## 6      6 step      dummy      FALSE   FALSE dummy_oxgYz

    ## Check das Rezept {#check-das-rezept}

    ``` text
    prep(rec1, verbose = TRUE)
    ```

        ## oper 1 step mutate [training] 
        ## oper 2 step log [training] 
        ## oper 3 step mutate [training] 
        ## oper 4 step date [training] 
        ## oper 5 step impute knn [training] 
        ## oper 6 step dummy [training] 
        ## The retained training set is ~ 0.38 Mb  in memory.

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
        ## K-nearest neighbor imputation for runtime, budget, release_date_year,... [trained]
        ## Dummy variables from release_date_month [trained]

    ``` text
    d_train_baked <- 
    prep(rec1) %>% 
      bake(new_data = NULL) 

    d_train_baked
    ```

        ## # A tibble: 3,000 × 16
        ##    popularity runtime budget  revenue release_date_year
        ##         <dbl>   <dbl>  <dbl>    <dbl>             <dbl>
        ##  1      6.58       93  16.5  12314651              2015
        ##  2      8.25      113  17.5  95149435              2004
        ##  3     64.3       105  15.0  13092000              2014
        ##  4      3.17      122  14.0  16000000              2012
        ##  5      1.15      118   2.30  3923970              2009
        ##  6      0.743      83  15.9   3261638              1987
        ##  7      7.29       92  16.5  85446075              2012
        ##  8      1.95       84   2.30  2586511              2004
        ##  9      6.90      100   2.30 34327391              1996
        ## 10      4.67       91  15.6  18750246              2003
        ## # … with 2,990 more rows, and 11 more variables:
        ## #   release_date_month_Feb <dbl>, release_date_month_Mar <dbl>,
        ## #   release_date_month_Apr <dbl>, release_date_month_May <dbl>,
        ## #   release_date_month_Jun <dbl>, release_date_month_Jul <dbl>,
        ## #   release_date_month_Aug <dbl>, release_date_month_Sep <dbl>,
        ## #   release_date_month_Oct <dbl>, release_date_month_Nov <dbl>,
        ## #   release_date_month_Dec <dbl>

    ``` text
    d_train_baked %>% 
      map_df(~ sum(is.na(.)))
    ```

        ## # A tibble: 1 × 16
        ##   popularity runtime budget revenue release_date_ye… release_date_mo…
        ##        <int>   <int>  <int>   <int>            <int>            <int>
        ## 1          0       0      0       0                0                0
        ## # … with 10 more variables: release_date_month_Mar <int>,
        ## #   release_date_month_Apr <int>, release_date_month_May <int>,
        ## #   release_date_month_Jun <int>, release_date_month_Jul <int>,
        ## #   release_date_month_Aug <int>, release_date_month_Sep <int>,
        ## #   release_date_month_Oct <int>, release_date_month_Nov <int>,
        ## #   release_date_month_Dec <int>

    Keine fehlenden Werte mehr *in den Prädiktoren*.

    Nach fehlenden Werten könnte man z.B. auch so suchen:

    ``` text
    datawizard::describe_distribution(d_train_baked)
    ```

        ## Variable               |     Mean |       SD |      IQR |              Range | Skewness | Kurtosis |    n | n_Missing
        ## ---------------------------------------------------------------------------------------------------------------------
        ## popularity             |     8.46 |    12.10 |     6.88 | [1.00e-06, 294.34] |    14.38 |   280.10 | 3000 |         0
        ## runtime                |   107.84 |    22.09 |    24.00 |     [0.00, 338.00] |     1.02 |     8.19 | 3000 |         0
        ## budget                 |    12.51 |     6.44 |    14.88 |      [2.30, 19.76] |    -0.87 |    -1.09 | 3000 |         0
        ## revenue                | 6.67e+07 | 1.38e+08 | 6.66e+07 |   [1.00, 1.52e+09] |     4.54 |    27.78 | 3000 |         0
        ## release_date_year      |  2004.58 |    15.48 |    17.00 | [1969.00, 2068.00] |     1.22 |     3.94 | 3000 |         0
        ## release_date_month_Feb |     0.08 |     0.26 |     0.00 |       [0.00, 1.00] |     3.22 |     8.37 | 3000 |         0
        ## release_date_month_Mar |     0.08 |     0.27 |     0.00 |       [0.00, 1.00] |     3.11 |     7.71 | 3000 |         0
        ## release_date_month_Apr |     0.08 |     0.27 |     0.00 |       [0.00, 1.00] |     3.06 |     7.35 | 3000 |         0
        ## release_date_month_May |     0.07 |     0.26 |     0.00 |       [0.00, 1.00] |     3.24 |     8.49 | 3000 |         0
        ## release_date_month_Jun |     0.08 |     0.27 |     0.00 |       [0.00, 1.00] |     3.12 |     7.76 | 3000 |         0
        ## release_date_month_Jul |     0.07 |     0.25 |     0.00 |       [0.00, 1.00] |     3.38 |     9.45 | 3000 |         0
        ## release_date_month_Aug |     0.09 |     0.28 |     0.00 |       [0.00, 1.00] |     2.97 |     6.83 | 3000 |         0
        ## release_date_month_Sep |     0.12 |     0.33 |     0.00 |       [0.00, 1.00] |     2.33 |     3.43 | 3000 |         0
        ## release_date_month_Oct |     0.10 |     0.30 |     0.00 |       [0.00, 1.00] |     2.63 |     4.90 | 3000 |         0
        ## release_date_month_Nov |     0.07 |     0.26 |     0.00 |       [0.00, 1.00] |     3.27 |     8.67 | 3000 |         0
        ## release_date_month_Dec |     0.09 |     0.28 |     0.00 |       [0.00, 1.00] |     2.92 |     6.52 | 3000 |         0

    So bekommt man gleich noch ein paar Infos über die Verteilung der
    Variablen. Praktische Sache.

    ## Check Test-Sample

    Das Test-Sample backen wir auch mal. Das hat *nur* den Zwecke, zu
    prüfen, ob unser Rezept auch richtig funktioniert. Das Preppen und
    Backen des Test-Samples wir *automatisch* von `predict()` bzw.
    `last_fit()` erledigt.

    Wichtig: Wir preppen den Datensatz mit dem *Train-Sample*, auch wenn
    wir das Test-Sample backen wollen.

    ``` text
    d_test_baked <-
      bake(rec1_prepped, new_data = d_test)
    ```

        ## Error in bake(rec1_prepped, new_data = d_test): object 'rec1_prepped' not found

    ``` text
    d_test_baked %>% 
      head()
    ```

        ## Error in head(.): object 'd_test_baked' not found

    # Kreuzvalidierung {#kreuzvalidierung}

    ``` text
    cv_scheme <- vfold_cv(d_train,
                          v = 5, 
                          repeats = 3)
    ```

    # Modelle {#modelle}

    ## Baum {#baum}

    ``` text
    mod_tree <-
      decision_tree(cost_complexity = tune(),
                    tree_depth = tune(),
                    mode = "regression")
    ```

    ## Random Forest {#random-forest}

    ``` text
    doParallel::registerDoParallel()
    ```

    ``` text
    mod_rf <-
      rand_forest(mtry = tune(),
                  min_n = tune(),
                  trees = 1000,
                  mode = "regression") %>% 
      set_engine("ranger", num.threads = 4)
    ```

    ## XGBoost

    ``` text
    mod_boost <- boost_tree(mtry = tune(),
                            min_n = tune(),
                            trees = tune()) %>% 
      set_engine("xgboost", nthreads = parallel::detectCores()) %>% 
      set_mode("regression")
    ```

    ## LM

    ``` text
    mod_lm <-
      linear_reg()
    ```

    # Workflow-Set

    ``` text
    preproc <- list(rec1 = rec1)
    models <- list(tree1 = mod_tree, rf1 = mod_rf, boost1 = mod_boost, lm1 = mod_lm)
     
     
    all_workflows <- workflow_set(preproc, models)
    ```

    # Fitten und tunen {#fitten-und-tunen}

    Wenn man das Ergebnis-Objekt abgespeichert hat, dann kann man es
    einfach laden, spart Rechenzeit (der Tag ist kurz):

    ``` text
    result_obj_file <- "tmdb_model_set.rds"
    ```

    (Davon ausgehend, dass die Datei im Arbeitsverzeichnis liegt.)

    ``` text
    if (file.exists(result_obj_file)) {
      tmdb_model_set <- read_rds(result_obj_file)
    } else {
      tic()
      tmdb_model_set <-
        all_workflows %>% 
        workflow_map(
          resamples = cv_scheme,
          grid = 10,
        #  metrics = metric_set(rmse),
          seed = 42,  # reproducibility
          verbose = TRUE)
      toc()
    }
    ```

    Um Rechenzeit zu sparen, kann man das Ergebnisobjekt abspeichern,
    dann muss man beim nächsten Mal nicht wieder von Neuem berechnen:

    ``` text
    #write_rds(tmdb_model_set, "objects/tmdb_model_set.rds")
    ```

    # Finalisieren {#finalisieren}

    ## Welcher Algorithmus schneidet am besten ab?

    Genauer geagt, welches Modell, denn es ist ja nicht nur ein
    Algorithmus, sondern ein Algorithmus plus ein Rezept plus die
    Parameterinstatiierung plus ein spezifischer Datensatz.

    ``` text
    tune::autoplot(tmdb_model_set) +
      theme(legend.position = "bottom")
    ```

    ![](data:image/png;base64,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daOW5QgBfgoWpxFc+6jKprFozvctvEeOE5FHVV4vqm7uHSeC45KIQJiAHEiYiLZFQAREQARiEVAKKxYmFRIBERABEQgTkAMJE9G2CIiACIhALAJyILEwqZAIiIAIiECYgBxImIi2RUAEREAEYhGQA4mFSYVEQAREQATCBORAwkS0LQIiIAIiEIuAHEgsTCokAiIgAiIQJiAHEiaibREQAREQgVgE5EBiYVIhERABERCBMAE5kDARbYuACIiACMQiIAcSC5MKiYAIiIAIhAnIgYSJaFsEREAERCAWATmQWJhUSAREQAREIExADiRMRNsiIAIiIAKxCMiBxMKkQiIgAiIgAmECciBhItoWAREQARGIRUAOJBYmFRIBERABEQgTkAMJE9G2CIiACIhALAJyILEwqZAIiIAIiECYgBxImIi2RUAEREAEYhGQA4mFSYVEQAREQATCBORAwkS0LQIiIAIiEIuAHEgsTCokAiIgAiIQJlAY3lFbtktKSqr0VgsLay3aKuXqVy79+SSq913cq5d3rl+t1lq5pUuXVqlumjZtWqX11/bKpb/s9ABxzw73XL2qUli5qhm1SwREQARynIAcSI4rSM0TAREQgVwlIAeSq5pRu0RABEQgxwnIgeS4gtQ8ERABEchVAnIguaoZtUsEREAEcpyAHEiOK0jNEwEREIFcJSAHkquaUbtEQAREIMcJVLkD+eOPP+ybb75JiyFuubQVZbhASelqmzjzSfvk5/tt7uL091HZyz/xxBN2zz33VPZ0O/nkk23atGmR58cpE1lBxMFc1d/ytWvthXnzbeScuTZ9xYqIO6jYofvvv98eeeQRd1JVcq1Yq3Kn9LLfCmzeuLq2YHwdKyvNnXYla8lvv/1mRxxxRLJD5fZNnz7d9tlnH9t2221t4cKF5Y5leqO0tNQ+/PDDTFeb8fqq/IuE5513nvXp08c6duwY2fi45SIryfDB1SXLbci47raqZKmVlpbYmtLr7NCOt1n3dmdk+EpmM2bMsHnz5lW63h49eliTJk0iz49TJrKCiIO5qL+Fa9bYQRMnW0lZma31XoN+mWH3br+t7V+0acSdxDv0008/Wb169VzhquQarzW5VWruuDo269WNLa/ArMxr2vRn6ttuty+ygnW4cquxXmuWL19un376adp2DR8+3I2xRx991DbZZJO05TekwCuvvGJc7913392QajJ67sqVK61u3bqWl5eXqLdgs802G4jh2XTTfwYV/67grbfesvfff9+aN29ezjD9+eef9swzz9iPP/5o22yzjfn/suOHH36wp59+2qZOnWpenda4cWP7/vvv7fHHHzfqw2tTVzIJl5s7d64tXrzYxowZY4sWLbK2bdt6BrzUbb/55pu21ptVtmnTJlEVs9/nn3/evvjiC3ftdIaUE4GRTu4e292WrJxnJaUrrbRs3b8++XH+WNu+ZV9rVK9F5Om+cYkqNHv2bNduHMecOXNs2bJldvDBB7tTJk+ebC+88IL9+uuvjl1BgTca/yNEGi+99JKtWrXKtthiC6dQGMBp4403tmS64NRgGbbRFdzWeIZ2yy23ZJd9/fXXtmTJEvv2229t9OjRbh/XiJI4+ovSUdSxVNdNp78yz2F0Hj/BVnn9ZrX3GSeCvPvnQuu3WZE1TvOvZtLp7+2333Z9f999901wRR8Yovz8fDdGmLFut912bptrR/VhymI0Pv74Y4o6vfLOGKhTp449++yzbvxE/YeDZGVT9aMVXjTGGP/ggw/cWHrjjTdshx124JKRko770hkF9vP/NfQ8R54XeXiGhldemS2fVWhFXdZE1s3BdNyT3eNHH31kr776qovAfduD3YjSBffPPX/yySfOVmG7Lr300pTtgyO2DMeBTv3xkmwMTZkyZT37FdXH33nnHdd+7B42lX702GOPGfWwvfXWW6dsV1Uf6N+/v7333nv24IMP2plnnmnDhg2zWbNm2QEHHODsTj6GghkUzgIBCHBGjhxpn332me26666JUGrIkCG2884723fffWdDhw61bt26OaPHOb1797b58+c7A0QZLvLXX3/Z33//7WbWAEwl4XKjRo2yww47zCkMI4YxOPTQQ+2WW25x1zj++OPtpptuctUxE+zcubO7yYkTJ1qXLl2cI0l1rfD+KbNfsoFj2iR9LVox05tBrS13SpmV2gMf9U1aftgH+5QrG7UBd9hOmDDBsbzvvvsSxR9++GF3vzgYZiE9e/a01atXu+NPPfWUi+h++eUXx4D0CXLBBRc4x5FKF8EyOOD99tvPTjnlFKenY4891q688kpXD/UTzt98883u2P7772+vvfaaO5bqTzr9Reko6liq6wX3j5ozzzp9+vl6r13Gf+Fmv+vcxj9nrPH60oFeVJLsnNO+iU4B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)

    R-Quadrat ist nicht entscheidend; `rmse` ist wichtiger.

    Die Ergebnislage ist nicht ganz klar, aber einiges spricht für das
    Boosting-Modell, `rec1_boost1`.

    ``` text
    tmdb_model_set %>% 
      collect_metrics() %>% 
      arrange(-mean) %>% 
      head(10)
    ```

        ## # A tibble: 10 × 9
        ##    wflow_id    .config  preproc model .metric .estimator   mean     n
        ##    <chr>       <chr>    <chr>   <chr> <chr>   <chr>       <dbl> <int>
        ##  1 rec1_lm1    Preproc… recipe  line… rmse    standard   1.15e8    15
        ##  2 rec1_tree1  Preproc… recipe  deci… rmse    standard   1.12e8    15
        ##  3 rec1_rf1    Preproc… recipe  rand… rmse    standard   1.10e8    15
        ##  4 rec1_tree1  Preproc… recipe  deci… rmse    standard   9.46e7    15
        ##  5 rec1_tree1  Preproc… recipe  deci… rmse    standard   9.33e7    15
        ##  6 rec1_boost1 Preproc… recipe  boos… rmse    standard   9.30e7    15
        ##  7 rec1_boost1 Preproc… recipe  boos… rmse    standard   9.27e7    15
        ##  8 rec1_tree1  Preproc… recipe  deci… rmse    standard   9.21e7    15
        ##  9 rec1_tree1  Preproc… recipe  deci… rmse    standard   9.21e7    15
        ## 10 rec1_boost1 Preproc… recipe  boos… rmse    standard   9.21e7    15
        ## # … with 1 more variable: std_err <dbl>

    ``` text
    best_model_params <-
    extract_workflow_set_result(tmdb_model_set, "rec1_boost1") %>% 
      select_best()
    ```

        ## Warning: No value of `metric` was given; metric 'rmse' will be used.

    ``` text
    best_model_params
    ```

        ## # A tibble: 1 × 4
        ##    mtry trees min_n .config              
        ##   <int> <int> <int> <chr>                
        ## 1     6   100     4 Preprocessor1_Model04

    ## Finalisieren {#finalisieren-1}

    ``` text
    best_wf <- 
    all_workflows %>% 
      extract_workflow("rec1_boost1")

    best_wf
    ```

        ## ══ Workflow ═════════════════════════════════════════════════════════
        ## Preprocessor: Recipe
        ## Model: boost_tree()
        ## 
        ## ── Preprocessor ─────────────────────────────────────────────────────
        ## 6 Recipe Steps
        ## 
        ## • step_mutate()
        ## • step_log()
        ## • step_mutate()
        ## • step_date()
        ## • step_impute_knn()
        ## • step_dummy()
        ## 
        ## ── Model ────────────────────────────────────────────────────────────
        ## Boosted Tree Model Specification (regression)
        ## 
        ## Main Arguments:
        ##   mtry = tune()
        ##   trees = tune()
        ##   min_n = tune()
        ## 
        ## Engine-Specific Arguments:
        ##   nthreads = parallel::detectCores()
        ## 
        ## Computational engine: xgboost

    ``` text
    best_wf_finalized <- 
      best_wf %>% 
      finalize_workflow(best_model_params)

    best_wf_finalized
    ```

        ## ══ Workflow ═════════════════════════════════════════════════════════
        ## Preprocessor: Recipe
        ## Model: boost_tree()
        ## 
        ## ── Preprocessor ─────────────────────────────────────────────────────
        ## 6 Recipe Steps
        ## 
        ## • step_mutate()
        ## • step_log()
        ## • step_mutate()
        ## • step_date()
        ## • step_impute_knn()
        ## • step_dummy()
        ## 
        ## ── Model ────────────────────────────────────────────────────────────
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

    ## Final Fit {#final-fit}

    ``` text
    fit_final <-
      best_wf_finalized %>% 
      fit(d_train)
    ```

        ## [00:22:34] WARNING: amalgamation/../src/learner.cc:576: 
        ## Parameters: { "nthreads" } might not be used.
        ## 
        ##   This could be a false alarm, with some parameters getting used by language bindings but
        ##   then being mistakenly passed down to XGBoost core, or some parameter actually being used
        ##   but getting flagged wrongly here. Please open an issue if you find any such cases.

    ``` text
    fit_final
    ```

        ## ══ Workflow [trained] ═══════════════════════════════════════════════
        ## Preprocessor: Recipe
        ## Model: boost_tree()
        ## 
        ## ── Preprocessor ─────────────────────────────────────────────────────
        ## 6 Recipe Steps
        ## 
        ## • step_mutate()
        ## • step_log()
        ## • step_mutate()
        ## • step_date()
        ## • step_impute_knn()
        ## • step_dummy()
        ## 
        ## ── Model ────────────────────────────────────────────────────────────
        ## ##### xgb.Booster
        ## raw: 335.2 Kb 
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
        ##        1     121008592
        ##        2     100068656
        ## ---                   
        ##       99      29287630
        ##      100      29151778

    ``` text
    d_test$revenue <- NA

    final_preds <- 
      fit_final %>% 
      predict(new_data = d_test) %>% 
      bind_cols(d_test)
    ```

    ## Submission

    ``` text
    submission_df <-
      final_preds %>% 
      select(id, revenue = .pred)
    ```

    Abspeichern und einreichen:

    ``` text
    write_csv(submission_df, file = "submission.csv")
    ```

    # Kaggle Score {#kaggle-score}

    Diese Submission erzielte einen Score von **4.79227** (RMSLE).

    ``` text
    sol <- 4.79227
    ```

4.  **Aufgabe**\

    Wir bearbeiten hier die Fallstudie [TMDB Box Office Prediction - Can
    you predict a movie's worldwide box office
    revenue?](https://www.kaggle.com/competitions/tmdb-box-office-prediction/overview),
    ein [Kaggle](https://www.kaggle.com/)-Prognosewettbewerb.

    Ziel ist es, genaue Vorhersagen zu machen, in diesem Fall für Filme.

    Die Daten können Sie von der Kaggle-Projektseite beziehen oder so:

    ``` text
    d_train_path <- "https://raw.githubusercontent.com/sebastiansauer/Lehre/main/data/tmdb-box-office-prediction/train.csv"
    d_test_path <- "https://raw.githubusercontent.com/sebastiansauer/Lehre/main/data/tmdb-box-office-prediction/test.csv"
    ```

    # Aufgabe {#aufgabe}

    Reichen Sie bei Kaggle eine Submission für die Fallstudie ein!
    Berichten Sie den Score!

    Hinweise:

    -   Sie müssen sich bei Kaggle ein Konto anlegen (kostenlos und
        anonym möglich); alternativ können Sie sich mit einem
        Google-Konto anmelden.
    -   Halten Sie das Modell so *einfach* wie möglich. Verwenden Sie
        als Algorithmus die *lineare Regression* ohne weitere Schnörkel.
    -   Logarithmieren Sie `budget` und `revenue`.
    -   Minimieren Sie die Vorverarbeitung (`steps`) so weit als
        möglich.
    -   Verwenden Sie `tidymodels`.
    -   Die Zielgröße ist `revenue` in Dollars; nicht in "Log-Dollars".
        Sie müssen also rücktransformieren, wenn Sie `revenue`
        logarithmiert haben, bevor Sie Ihre Prognose einreichen.

    \
    **Lösung**

    # Vorbereitung {#vorbereitung}

    ``` text
    library(tidyverse)
    library(tidymodels)
    ```

    ``` text
    d_train_raw <- read_csv(d_train_path)
    d_test_raw <- read_csv(d_test_path)

    # d_test$revenue <- NA
    ```

    ``` text
    d_train_backup <- d_train_raw
    ```

    Mal einen Blick werfen:

    ``` text
    glimpse(d_train_raw)
    ```

        ## Rows: 3,000
        ## Columns: 23
        ## $ id                    <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12…
        ## $ belongs_to_collection <chr> "[{'id': 313576, 'name': 'Hot Tub Tim…
        ## $ budget                <dbl> 1.40e+07, 4.00e+07, 3.30e+06, 1.20e+0…
        ## $ genres                <chr> "[{'id': 35, 'name': 'Comedy'}]", "[{…
        ## $ homepage              <chr> NA, NA, "http://sonyclassics.com/whip…
        ## $ imdb_id               <chr> "tt2637294", "tt0368933", "tt2582802"…
        ## $ original_language     <chr> "en", "en", "en", "hi", "ko", "en", "…
        ## $ original_title        <chr> "Hot Tub Time Machine 2", "The Prince…
        ## $ overview              <chr> "When Lou, who has become the \"fathe…
        ## $ popularity            <dbl> 6.575393, 8.248895, 64.299990, 3.1749…
        ## $ poster_path           <chr> "/tQtWuwvMf0hCc2QR2tkolwl7c3c.jpg", "…
        ## $ production_companies  <chr> "[{'name': 'Paramount Pictures', 'id'…
        ## $ production_countries  <chr> "[{'iso_3166_1': 'US', 'name': 'Unite…
        ## $ release_date          <chr> "2/20/15", "8/6/04", "10/10/14", "3/9…
        ## $ runtime               <dbl> 93, 113, 105, 122, 118, 83, 92, 84, 1…
        ## $ spoken_languages      <chr> "[{'iso_639_1': 'en', 'name': 'Englis…
        ## $ status                <chr> "Released", "Released", "Released", "…
        ## $ tagline               <chr> "The Laws of Space and Time are About…
        ## $ title                 <chr> "Hot Tub Time Machine 2", "The Prince…
        ## $ Keywords              <chr> "[{'id': 4379, 'name': 'time travel'}…
        ## $ cast                  <chr> "[{'cast_id': 4, 'character': 'Lou', …
        ## $ crew                  <chr> "[{'credit_id': '59ac067c92514107af02…
        ## $ revenue               <dbl> 12314651, 95149435, 13092000, 1600000…

    ## Train-Set verschlanken {#train-set-verschlanken}

    ``` text
    d_train_raw_reduced <-
      d_train_raw %>% 
      select(id, popularity, runtime, revenue, budget) 
    ```

    ## Test-Set verschlanken

    ``` text
    d_test <-
      d_test_raw %>% 
      select(id,popularity, runtime, budget) 
    ```

    ## Outcome logarithmieren

    Der Outcome [sollte *nicht* im Rezept transformiert werden (vgl.
    Part 3, S. 30, in dieser
    Unterlage)](https://github.com/topepo/nyr-2020).

    ``` text
    d_train <-
      d_train_raw_reduced %>% 
      mutate(revenue = if_else(revenue < 10, 10, revenue)) %>% 
      mutate(revenue = log(revenue)) 
    ```

    Prüfen, ob das funktioniert hat:

    ``` text
    d_train$revenue %>% is.infinite() %>% any()
    ```

        ## [1] FALSE

    Keine unendlichen Werte mehr

    # Fehlende Werte prüfen {#fehlende-werte-prüfen}

    Welche Spalten haben viele fehlende Werte?

    ``` text
    sum_isna <- function(x) {sum(is.na(x))}
    ```

    ``` text
    d_train %>% 
      summarise(across(everything(), sum_isna))
    ```

        ## # A tibble: 1 × 5
        ##      id popularity runtime revenue budget
        ##   <int>      <int>   <int>   <int>  <int>
        ## 1     0          0       2       0      0

    # Rezept {#rezept}

    ## Rezept definieren {#rezept-definieren}

    ``` text
    rec2 <-
      recipe(revenue ~ ., data = d_train) %>% 
      step_mutate(budget = ifelse(budget == 0, NA, budget)) %>%  # log mag keine 0
      step_log(budget) %>% 
      step_impute_knn(all_predictors()) %>% 
      step_dummy(all_nominal_predictors())  %>% 
      update_role(id, new_role = "id")

    rec2
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
        ## Variable mutation for ifelse(budget == 0, NA, budget)
        ## Log transformation on budget
        ## K-nearest neighbor imputation for all_predictors()
        ## Dummy variables from all_nominal_predictors()

    Schauen Sie mal, der Log mag keine Nullen:

    ``` text
    x <- c(1,2, NA, 0)

    log(x)
    ```

        ## [1] 0.0000000 0.6931472        NA      -Inf

    Da $log(0) = - \infty$. Aus dem Grund wandeln wir 0 lieber in `NA`
    um.

    ``` text
    tidy(rec2)
    ```

        ## # A tibble: 4 × 6
        ##   number operation type       trained skip  id              
        ##    <int> <chr>     <chr>      <lgl>   <lgl> <chr>           
        ## 1      1 step      mutate     FALSE   FALSE mutate_N4aGk    
        ## 2      2 step      log        FALSE   FALSE log_l64vG       
        ## 3      3 step      impute_knn FALSE   FALSE impute_knn_nWdrG
        ## 4      4 step      dummy      FALSE   FALSE dummy_jaFQP

    ## Check das Rezept {#check-das-rezept}

    Wir berechnen das Rezept:

    ``` text
    rec2_prepped <-
      prep(rec2, verbose = TRUE)
    ```

        ## oper 1 step mutate [training] 
        ## oper 2 step log [training] 
        ## oper 3 step impute knn [training] 
        ## oper 4 step dummy [training] 
        ## The retained training set is ~ 0.12 Mb  in memory.

    ``` text
    rec2_prepped
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
        ## Training data contained 3000 data points and 2 incomplete rows. 
        ## 
        ## Operations:
        ## 
        ## Variable mutation for ~ifelse(budget == 0, NA, budget) [trained]
        ## Log transformation on budget [trained]
        ## K-nearest neighbor imputation for runtime, budget, popularity [trained]
        ## Dummy variables from <none> [trained]

    Das ist noch *nicht* auf einen Datensatz angewendet! Lediglich die
    `steps` wurden *vorbereitet*, "präpariert": z.B. "Diese
    Dummy-Variablen impliziert das Rezept".

    So sieht das dann aus, wenn man das *präparierte* Rezept auf das
    Train-Sample anwendet:

    ``` text
    d_train_baked2 <-
      rec2_prepped %>% 
      bake(new_data = NULL) 

    head(d_train_baked2)
    ```

        ## # A tibble: 6 × 5
        ##      id popularity runtime budget revenue
        ##   <dbl>      <dbl>   <dbl>  <dbl>   <dbl>
        ## 1     1      6.58       93   16.5    16.3
        ## 2     2      8.25      113   17.5    18.4
        ## 3     3     64.3       105   15.0    16.4
        ## 4     4      3.17      122   14.0    16.6
        ## 5     5      1.15      118   15.8    15.2
        ## 6     6      0.743      83   15.9    15.0

    ``` text
    d_train_baked2 %>% 
      map_df(sum_isna)
    ```

        ## # A tibble: 1 × 5
        ##      id popularity runtime budget revenue
        ##   <int>      <int>   <int>  <int>   <int>
        ## 1     0          0       0      0       0

    Keine fehlenden Werte mehr *in den Prädiktoren*.

    Nach fehlenden Werten könnte man z.B. auch so suchen:

    ``` text
    datawizard::describe_distribution(d_train_baked2)
    ```

        ## Variable   |    Mean |     SD |     IQR |              Range | Skewness | Kurtosis |    n | n_Missing
        ## -----------------------------------------------------------------------------------------------------
        ## id         | 1500.50 | 866.17 | 1500.50 |    [1.00, 3000.00] |     0.00 |    -1.20 | 3000 |         0
        ## popularity |    8.46 |  12.10 |    6.88 | [1.00e-06, 294.34] |    14.38 |   280.10 | 3000 |         0
        ## runtime    |  107.85 |  22.08 |   24.00 |     [0.00, 338.00] |     1.02 |     8.20 | 3000 |         0
        ## budget     |   16.09 |   1.89 |    1.90 |      [0.00, 19.76] |    -2.93 |    18.71 | 3000 |         0
        ## revenue    |   15.97 |   3.04 |    3.37 |      [2.30, 21.14] |    -1.60 |     3.82 | 3000 |         0

    So bekommt man gleich noch ein paar Infos über die Verteilung der
    Variablen. Praktische Sache.

    ## Check Test-Sample {#check-test-sample}

    Das Test-Sample backen wir auch mal, um zu prüfen, das alles läuft:

    ``` text
    d_test_baked2 <-
      bake(rec2_prepped, new_data = d_test)

    d_test_baked2 %>% 
      head()
    ```

        ## # A tibble: 6 × 4
        ##      id popularity runtime budget
        ##   <dbl>      <dbl>   <dbl>  <dbl>
        ## 1  3001       3.85      90   15.8
        ## 2  3002       3.56      65   11.4
        ## 3  3003       8.09     100   16.4
        ## 4  3004       8.60     130   15.7
        ## 5  3005       3.22      92   14.5
        ## 6  3006       8.68     121   16.1

    Sieht soweit gut aus.

    # Kreuzvalidierung {#kreuzvalidierung}

    ``` text
    cv_scheme <- vfold_cv(d_train,
                          v = 5, 
                          repeats = 3)
    ```

    # Modelle {#modelle}

    ## LM {#lm}

    ``` text
    mod_lm <-
      linear_reg()
    ```

    # Workflow-Set {#workflow-set}

    Hier nur ein sehr kleiner Workflow-Set.

    Das ist übrigens eine gute Strategie: Erstmal mit einem kleinen
    Prozess anfangen, und dann sukzessive erweitern.

    ``` text
    preproc2 <- list(rec1 = rec2)
    models2 <- list(lm1 = mod_lm)
     
     
    all_workflows2 <- workflow_set(preproc2, models2)
    ```

    # Fitten und tunen {#fitten-und-tunen}

    ``` text
    tmdb_model_set2 <-
        all_workflows2 %>% 
        workflow_map(resamples = cv_scheme)
    ```

    # Finalisieren {#finalisieren}

    ``` text
    tmdb_model_set2 %>% 
      collect_metrics() %>% 
      arrange(-mean) %>% 
      head(10)
    ```

        ## # A tibble: 2 × 9
        ##   wflow_id .config       preproc model .metric .estimator  mean     n
        ##   <chr>    <chr>         <chr>   <chr> <chr>   <chr>      <dbl> <int>
        ## 1 rec1_lm1 Preprocessor… recipe  line… rmse    standard   2.48     15
        ## 2 rec1_lm1 Preprocessor… recipe  line… rsq     standard   0.340    15
        ## # … with 1 more variable: std_err <dbl>

    ``` text
    best_model_params2 <-
    extract_workflow_set_result(tmdb_model_set2, "rec1_lm1") %>% 
      select_best()
    ```

        ## Warning: No value of `metric` was given; metric 'rmse' will be used.

    ``` text
    best_model_params2
    ```

        ## # A tibble: 1 × 1
        ##   .config             
        ##   <chr>               
        ## 1 Preprocessor1_Model1

    ## Finalisieren {#finalisieren-1}

    Finalisieren bedeutet:

    -   Besten Workflow identifizieren (zur Erinnerung: Workflow =
        Rezept + Modell)
    -   Den besten Workflow mit den optimalen Modell-Parametern
        ausstatten
    -   Damit dann den ganzen Train-Datensatz fitten
    -   Auf dieser Basis das Test-Sample vorhersagen

    ``` text
    best_wf2 <- 
    all_workflows2 %>% 
      extract_workflow("rec1_lm1")

    best_wf2
    ```

        ## ══ Workflow ═════════════════════════════════════════════════════════
        ## Preprocessor: Recipe
        ## Model: linear_reg()
        ## 
        ## ── Preprocessor ─────────────────────────────────────────────────────
        ## 4 Recipe Steps
        ## 
        ## • step_mutate()
        ## • step_log()
        ## • step_impute_knn()
        ## • step_dummy()
        ## 
        ## ── Model ────────────────────────────────────────────────────────────
        ## Linear Regression Model Specification (regression)
        ## 
        ## Computational engine: lm

    ``` text
    best_wf_finalized2 <- 
      best_wf2 %>% 
      finalize_workflow(best_model_params2)

    best_wf_finalized2
    ```

        ## ══ Workflow ═════════════════════════════════════════════════════════
        ## Preprocessor: Recipe
        ## Model: linear_reg()
        ## 
        ## ── Preprocessor ─────────────────────────────────────────────────────
        ## 4 Recipe Steps
        ## 
        ## • step_mutate()
        ## • step_log()
        ## • step_impute_knn()
        ## • step_dummy()
        ## 
        ## ── Model ────────────────────────────────────────────────────────────
        ## Linear Regression Model Specification (regression)
        ## 
        ## Computational engine: lm

    ## Final Fit {#final-fit}

    ``` text
    fit_final2 <-
      best_wf_finalized2 %>% 
      fit(d_train)

    fit_final2
    ```

        ## ══ Workflow [trained] ═══════════════════════════════════════════════
        ## Preprocessor: Recipe
        ## Model: linear_reg()
        ## 
        ## ── Preprocessor ─────────────────────────────────────────────────────
        ## 4 Recipe Steps
        ## 
        ## • step_mutate()
        ## • step_log()
        ## • step_impute_knn()
        ## • step_dummy()
        ## 
        ## ── Model ────────────────────────────────────────────────────────────
        ## 
        ## Call:
        ## stats::lm(formula = ..y ~ ., data = data)
        ## 
        ## Coefficients:
        ## (Intercept)   popularity      runtime       budget  
        ##     1.26186      0.03755      0.01289      0.80752

    ``` text
    preds <- 
    fit_final2 %>% 
      predict(new_data = d_test)

    head(preds)
    ```

        ## # A tibble: 6 × 1
        ##   .pred
        ##   <dbl>
        ## 1  15.3
        ## 2  11.4
        ## 3  16.1
        ## 4  16.0
        ## 5  14.3
        ## 6  16.1

    Achtung, wenn die Outcome-Variable im Rezept verändert wurde, dann
    würde obiger Code *nicht* durchlaufen.

    Grund ist [hier](https://github.com/tidymodels/workflows/issues/63)
    beschrieben:

    > When predict() is used, it only has access to the predictors
    > (mirroring how this would work with new samples). Even if the
    > outcome column is present, it is not exposed to the recipe. This
    > is generally a good idea so that we can avoid information leakage.

    > One approach is the use the skip = TRUE option in step_log() so
    > that it will avoid that step during predict() and/or bake().
    > However, if you are using this recipe with the tune package, there
    > will still be an issue because the metric function(s) would get
    > the predictions in log units and the observed outcome in the
    > original units.

    > The better approach is, for simple transformations like yours, to
    > log the outcome outside of the recipe (before data analysis and
    > the initial split).

    ## Submission df {#submission-df}

    ``` text
    submission_df <-
      d_test %>% 
      select(id) %>% 
      bind_cols(preds) %>% 
      rename(revenue = .pred)

    head(submission_df)
    ```

        ## # A tibble: 6 × 2
        ##      id revenue
        ##   <dbl>   <dbl>
        ## 1  3001    15.3
        ## 2  3002    11.4
        ## 3  3003    16.1
        ## 4  3004    16.0
        ## 5  3005    14.3
        ## 6  3006    16.1

    ## Zurücktransformieren

    ``` text
    submission_df <-
      submission_df %>% 
      mutate(revenue = exp(revenue)-1)

    head(submission_df)
    ```

        ## # A tibble: 6 × 2
        ##      id   revenue
        ##   <dbl>     <dbl>
        ## 1  3001  4435143.
        ## 2  3002    91755.
        ## 3  3003  9782986.
        ## 4  3004  8573795.
        ## 5  3005  1598106.
        ## 6  3006 10061439.

    [Hier](https://numpy.org/doc/stable/reference/generated/numpy.expm1.html)
    ein Beispiel, warum $e^{x} - 1$ genauer ist für kleine Zahlen als
    $e^{x}$.

    Abspeichern und einreichen:

    ``` text
    write_csv(submission_df, file = "submission.csv")
    ```

    # Kaggle Score {#kaggle-score}

    Diese Submission erzielte einen Score von **Score: 2.46249**
    (RMSLE).

    ``` text
    sol <- 2.5
    ```

5.  **Aufgabe**\

    Melden Sie sich an für die Kaggle Competition [TMDB Box Office
    Prediction - Can you predict a movie's worldwide box office
    revenue?](https://www.kaggle.com/competitions/tmdb-box-office-prediction/overview).

    Sie benötigen dazu ein Konto; es ist auch möglich, sich mit seinem
    Google-Konto anzumelden.

    Bei diesem Prognosewettbewerb geht es darum, vorherzusagen, wieviel
    Umsatz wohl einige Filme machen werden. Als Prädiktoren stehen
    einige Infos wie Budget, Genre, Titel etc. zur Verfügung. Eine
    klassische "predictive Competition" also :-) Allerdings können immer
    ein paar Schwierigkeiten auftreten ;-)

    *Aufgabe*

    Erstellen Sie ein Random-Forest-Modell mit Tidymodels!

    *Hinweise*

    -   Verzichten Sie auf Vorverarbeitung.
    -   Tunen Sie die typischen Parameter.
    -   Reichen Sie das Modell ein und berichten Sie Ihren Score.
    -   Begrenzen Sie sich auf folgende Prädiktoren.
    -   Verwenden Sie (langweiligerweise) nur ein lineares Modell.

    ``` text
    preds_chosen <- 
      c("id", "budget", "popularity", "runtime")
    ```

    \
    **Lösung**

    # Pakete starten {#pakete-starten}

    ``` text
    library(tidyverse)
    library(tidymodels)
    library(tictoc)
    ```

    # Daten importieren {#daten-importieren}

    ``` text
    d_train_path <- "https://raw.githubusercontent.com/sebastiansauer/Lehre/main/data/tmdb-box-office-prediction/train.csv"
    d_test_path <- "https://raw.githubusercontent.com/sebastiansauer/Lehre/main/data/tmdb-box-office-prediction/test.csv"

    d_train <- read_csv(d_train_path)
    d_test <- read_csv(d_test_path)
    ```

    Werfen wir einen Blick in die Daten:

    ``` text
    glimpse(d_train)
    ```

        ## Rows: 3,000
        ## Columns: 23
        ## $ id                    <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12…
        ## $ belongs_to_collection <chr> "[{'id': 313576, 'name': 'Hot Tub Tim…
        ## $ budget                <dbl> 1.40e+07, 4.00e+07, 3.30e+06, 1.20e+0…
        ## $ genres                <chr> "[{'id': 35, 'name': 'Comedy'}]", "[{…
        ## $ homepage              <chr> NA, NA, "http://sonyclassics.com/whip…
        ## $ imdb_id               <chr> "tt2637294", "tt0368933", "tt2582802"…
        ## $ original_language     <chr> "en", "en", "en", "hi", "ko", "en", "…
        ## $ original_title        <chr> "Hot Tub Time Machine 2", "The Prince…
        ## $ overview              <chr> "When Lou, who has become the \"fathe…
        ## $ popularity            <dbl> 6.575393, 8.248895, 64.299990, 3.1749…
        ## $ poster_path           <chr> "/tQtWuwvMf0hCc2QR2tkolwl7c3c.jpg", "…
        ## $ production_companies  <chr> "[{'name': 'Paramount Pictures', 'id'…
        ## $ production_countries  <chr> "[{'iso_3166_1': 'US', 'name': 'Unite…
        ## $ release_date          <chr> "2/20/15", "8/6/04", "10/10/14", "3/9…
        ## $ runtime               <dbl> 93, 113, 105, 122, 118, 83, 92, 84, 1…
        ## $ spoken_languages      <chr> "[{'iso_639_1': 'en', 'name': 'Englis…
        ## $ status                <chr> "Released", "Released", "Released", "…
        ## $ tagline               <chr> "The Laws of Space and Time are About…
        ## $ title                 <chr> "Hot Tub Time Machine 2", "The Prince…
        ## $ Keywords              <chr> "[{'id': 4379, 'name': 'time travel'}…
        ## $ cast                  <chr> "[{'cast_id': 4, 'character': 'Lou', …
        ## $ crew                  <chr> "[{'credit_id': '59ac067c92514107af02…
        ## $ revenue               <dbl> 12314651, 95149435, 13092000, 1600000…

    ``` text
    glimpse(d_test)
    ```

        ## Rows: 4,398
        ## Columns: 22
        ## $ id                    <dbl> 3001, 3002, 3003, 3004, 3005, 3006, 3…
        ## $ belongs_to_collection <chr> "[{'id': 34055, 'name': 'Pokémon Coll…
        ## $ budget                <dbl> 0.00e+00, 8.80e+04, 0.00e+00, 6.80e+0…
        ## $ genres                <chr> "[{'id': 12, 'name': 'Adventure'}, {'…
        ## $ homepage              <chr> "http://www.pokemon.com/us/movies/mov…
        ## $ imdb_id               <chr> "tt1226251", "tt0051380", "tt0118556"…
        ## $ original_language     <chr> "ja", "en", "en", "fr", "en", "en", "…
        ## $ original_title        <chr> "ディアルガVSパルキアVSダークライ", "…
        ## $ overview              <chr> "Ash and friends (this time accompani…
        ## $ popularity            <dbl> 3.851534, 3.559789, 8.085194, 8.59601…
        ## $ poster_path           <chr> "/tnftmLMemPLduW6MRyZE0ZUD19z.jpg", "…
        ## $ production_companies  <chr> NA, "[{'name': 'Woolner Brothers Pict…
        ## $ production_countries  <chr> "[{'iso_3166_1': 'JP', 'name': 'Japan…
        ## $ release_date          <chr> "7/14/07", "5/19/58", "5/23/97", "9/4…
        ## $ runtime               <dbl> 90, 65, 100, 130, 92, 121, 119, 77, 1…
        ## $ spoken_languages      <chr> "[{'iso_639_1': 'en', 'name': 'Englis…
        ## $ status                <chr> "Released", "Released", "Released", "…
        ## $ tagline               <chr> "Somewhere Between Time & Space... A …
        ## $ title                 <chr> "Pokémon: The Rise of Darkrai", "Atta…
        ## $ Keywords              <chr> "[{'id': 11451, 'name': 'pok√©mon'}, …
        ## $ cast                  <chr> "[{'cast_id': 3, 'character': 'Tonio'…
        ## $ crew                  <chr> "[{'credit_id': '52fe44e7c3a368484e03…

    `preds_chosen` sind alle Prädiktoren im Datensatz, oder nicht? Das
    prüfen wir mal kurz:

    ``` text
    preds_chosen %in% names(d_train) %>% 
      all()
    ```

        ## [1] TRUE

    Ja, alle Elemente von `preds_chosen` sind Prädiktoren im
    (Train-)Datensatz.

    # CV {#cv}

    ``` text
    cv_scheme <- vfold_cv(d_train)
    ```

    # Rezept 1 {#rezept-1}

    ``` text
    rec1 <- 
      recipe(revenue ~ budget + popularity + runtime, data = d_train) %>% 
      step_impute_bag(all_predictors()) %>% 
      step_naomit(all_predictors()) 
    rec1
    ```

        ## Recipe
        ## 
        ## Inputs:
        ## 
        ##       role #variables
        ##    outcome          1
        ##  predictor          3
        ## 
        ## Operations:
        ## 
        ## Bagged tree imputation for all_predictors()
        ## Removing rows with NA values in all_predictors()

    Man beachte, dass noch 21 Prädiktoren angezeigt werden, da das
    Rezept noch nicht auf den Datensatz angewandt ("gebacken") wurde.

    ``` text
    tidy(rec1)
    ```

        ## # A tibble: 2 × 6
        ##   number operation type       trained skip  id              
        ##    <int> <chr>     <chr>      <lgl>   <lgl> <chr>           
        ## 1      1 step      impute_bag FALSE   FALSE impute_bag_sXqWu
        ## 2      2 step      naomit     FALSE   FALSE naomit_INEp7

    Rezept checken:

    ``` text
    prep(rec1)
    ```

        ## Recipe
        ## 
        ## Inputs:
        ## 
        ##       role #variables
        ##    outcome          1
        ##  predictor          3
        ## 
        ## Training data contained 3000 data points and 2 incomplete rows. 
        ## 
        ## Operations:
        ## 
        ## Bagged tree imputation for budget, popularity, runtime [trained]
        ## Removing rows with NA values in budget, popularity, runtime [trained]

    ``` text
    d_train_baked <-
      rec1 %>% 
      prep() %>% 
      bake(new_data = NULL)

    glimpse(d_train_baked)
    ```

        ## Rows: 3,000
        ## Columns: 4
        ## $ budget     <dbl> 1.40e+07, 4.00e+07, 3.30e+06, 1.20e+06, 0.00e+00…
        ## $ popularity <dbl> 6.575393, 8.248895, 64.299990, 3.174936, 1.14807…
        ## $ runtime    <dbl> 93, 113, 105, 122, 118, 83, 92, 84, 100, 91, 119…
        ## $ revenue    <dbl> 12314651, 95149435, 13092000, 16000000, 3923970,…

    Fehlende Werte noch übrig?

    ``` text
    library(easystats)
    describe_distribution(d_train_baked) %>% 
      select(Variable, n_Missing)
    ```

        ## Variable   | n_Missing
        ## ----------------------
        ## budget     |         0
        ## popularity |         0
        ## runtime    |         0
        ## revenue    |         0

    # Modell 1

    ``` text
    model_lm <- linear_reg()
    ```

    # Workflow 1 {#workflow-1}

    ``` text
    wf1 <-
      workflow() %>% 
      add_model(model_lm) %>% 
      add_recipe(rec1)
    ```

    # Modell fitten (und tunen) {#modell-fitten-und-tunen}

    ``` text
    doParallel::registerDoParallel(4)
    tic()
    lm_fit1 <-
      wf1 %>% 
      tune_grid(resamples = cv_scheme)
    ```

        ## Warning: No tuning parameters have been detected, performance will
        ## be evaluated using the resamples with no tuning. Did you want to
        ## [tune()] parameters?

    ``` text
    toc()
    ```

        ## 2.579 sec elapsed

    ``` text
    lm_fit1[[".notes"]][1]
    ```

        ## [[1]]
        ## # A tibble: 0 × 3
        ## # … with 3 variables: location <chr>, type <chr>, note <chr>

    # Final Fit {#final-fit}

    ``` text
    fit1_final <-
      wf1 %>% 
      fit(d_train)

    fit1_final
    ```

        ## ══ Workflow [trained] ═══════════════════════════════════════════════
        ## Preprocessor: Recipe
        ## Model: linear_reg()
        ## 
        ## ── Preprocessor ─────────────────────────────────────────────────────
        ## 2 Recipe Steps
        ## 
        ## • step_impute_bag()
        ## • step_naomit()
        ## 
        ## ── Model ────────────────────────────────────────────────────────────
        ## 
        ## Call:
        ## stats::lm(formula = ..y ~ ., data = data)
        ## 
        ## Coefficients:
        ## (Intercept)       budget   popularity      runtime  
        ##  -2.901e+07    2.482e+00    2.604e+06    1.648e+05

    ``` text
    preds <-
      fit1_final %>% 
      predict(d_test)
    ```

    # Submission df {#submission-df}

    ``` text
    submission_df <-
      d_test %>% 
      select(id) %>% 
      bind_cols(preds) %>% 
      rename(revenue = .pred)

    head(submission_df)
    ```

        ## # A tibble: 6 × 2
        ##      id   revenue
        ##   <dbl>     <dbl>
        ## 1  3001 -4147693.
        ## 2  3002 -8808622.
        ## 3  3003  8523906.
        ## 4  3004 31675369.
        ## 5  3005  -504520.
        ## 6  3006 13531528.

    Abspeichern und einreichen:

    ``` text
    #write_csv(submission_df, file = "submission.csv")
    ```

    # Kaggle Score {#kaggle-score}

    Diese Submission erzielte einen Score von **Score: 6.14787**
    (RMSLE).

    ``` text
    sol <- 6.14787
    ```

6.  **Aufgabe**\

    Ein merkwürdiger Fehler bzw. eine merkwürdige Fehlermeldung in
    Tidymodels - das untersuchen wir hier genauer und versuchen das
    Phänomen zu erklären.

    *Aufgabe*

    Erläutern Sie die Ursachen des Fehlers! Schalten Sie den Fehler an
    und ab, um zu zeigen, dass Sie Ihn verstehen.

    # Startup

    ``` text
    library(tidyverse)
    library(tidymodels)
    ```

    # Data import

    ``` text
    data("mtcars")

    d_train <- mtcars %>% slice(1:20)
    d_test <- mtcars %>% slice(21:nrow(mtcars))
    ```

    # Recipe

    ``` text
    preds_chosen <- c("hp", "disp", "am")
    ```

    ``` text
    rec1 <- 
      recipe( ~ ., data = d_train) %>% 
      update_role(all_predictors(), new_role = "id") %>% 
      update_role(all_of(preds_chosen), new_role = "predictor") %>% 
      update_role(mpg, new_role = "outcome")
    rec1
    ```

        ## Recipe
        ## 
        ## Inputs:
        ## 
        ##       role #variables
        ##         id          7
        ##    outcome          1
        ##  predictor          3

    ``` text
    d_train_baked <-
      rec1 %>% 
      prep() %>% 
      bake(new_data = NULL)

    glimpse(d_train_baked)
    ```

        ## Rows: 20
        ## Columns: 11
        ## $ mpg  <dbl> 21.0, 21.0, 22.8, 21.4, 18.7, 18.1, 14.3, 24.4, 22.8, …
        ## $ cyl  <dbl> 6, 6, 4, 6, 8, 6, 8, 4, 4, 6, 6, 8, 8, 8, 8, 8, 8, 4, …
        ## $ disp <dbl> 160.0, 160.0, 108.0, 258.0, 360.0, 225.0, 360.0, 146.7…
        ## $ hp   <dbl> 110, 110, 93, 110, 175, 105, 245, 62, 95, 123, 123, 18…
        ## $ drat <dbl> 3.90, 3.90, 3.85, 3.08, 3.15, 2.76, 3.21, 3.69, 3.92, …
        ## $ wt   <dbl> 2.620, 2.875, 2.320, 3.215, 3.440, 3.460, 3.570, 3.190…
        ## $ qsec <dbl> 16.46, 17.02, 18.61, 19.44, 17.02, 20.22, 15.84, 20.00…
        ## $ vs   <dbl> 0, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, …
        ## $ am   <dbl> 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, …
        ## $ gear <dbl> 4, 4, 4, 3, 3, 3, 3, 4, 4, 4, 4, 3, 3, 3, 3, 3, 3, 4, …
        ## $ carb <dbl> 4, 4, 1, 1, 2, 1, 4, 2, 2, 4, 4, 3, 3, 3, 4, 4, 4, 1, …

    # Model 1

    ``` text
    model_lm <- linear_reg()
    ```

    # Workflow 1 {#workflow-1}

    ``` text
    wf1 <-
      workflow() %>% 
      add_model(model_lm) %>% 
      add_recipe(rec1)
    ```

    # Fit

    ``` text
    lm_fit1 <-
      wf1 %>% 
      fit(d_train)
    ```

    ``` text
    preds <-
      lm_fit1 %>% 
      predict(d_test)

    head(preds)
    ```

        ## # A tibble: 6 × 1
        ##   .pred
        ##   <dbl>
        ## 1  22.6
        ## 2  17.2
        ## 3  17.4
        ## 4  12.1
        ## 5  14.9
        ## 6  28.2

    Aus Gründen der Reproduzierbarkeit bietet es sich an, eine
    `SessionInfo` anzugeben:

    ``` text
    sessionInfo()
    ```

        ## R version 4.1.3 (2022-03-10)
        ## Platform: x86_64-apple-darwin17.0 (64-bit)
        ## Running under: macOS Monterey 12.3.1
        ## 
        ## Matrix products: default
        ## LAPACK: /Library/Frameworks/R.framework/Versions/4.1/Resources/lib/libRlapack.dylib
        ## 
        ## locale:
        ## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
        ## 
        ## attached base packages:
        ## [1] grid      stats     graphics  grDevices utils     datasets 
        ## [7] methods   base     
        ## 
        ## other attached packages:
        ##  [1] visdat_0.5.3        VIM_6.1.1           colorspace_2.0-3   
        ##  [4] lubridate_1.8.0     rpart_4.1.16        ranger_0.13.1      
        ##  [7] report_0.5.1.1      see_0.7.0.1         correlation_0.8.0.1
        ## [10] modelbased_0.8.0    effectsize_0.6.0.1  parameters_0.17.0.9
        ## [13] performance_0.9.0.2 bayestestR_0.12.1   datawizard_0.4.0.17
        ## [16] insight_0.17.0.6    easystats_0.4.3     tictoc_1.0.1       
        ## [19] yardstick_0.0.9     workflowsets_0.1.0  workflows_0.2.6    
        ## [22] tune_0.2.0.9000     rsample_0.1.1       recipes_0.2.0      
        ## [25] parsnip_0.2.1       modeldata_0.1.1     infer_1.0.0        
        ## [28] dials_0.1.1         scales_1.2.0        broom_0.8.0        
        ## [31] tidymodels_0.1.4    forcats_0.5.1       stringr_1.4.0      
        ## [34] purrr_0.3.4         readr_2.1.2         tidyr_1.2.0        
        ## [37] tibble_3.1.7        ggplot2_3.3.6       tidyverse_1.3.1    
        ## [40] exams_2.3-6         dplyr_1.0.9         colorout_1.2-2     
        ## 
        ## loaded via a namespace (and not attached):
        ##   [1] readxl_1.3.1       backports_1.4.1    primes_1.1.0      
        ##   [4] plyr_1.8.7         sp_1.4-6           splines_4.1.3     
        ##   [7] listenv_0.8.0      TH.data_1.1-1      digest_0.6.29     
        ##  [10] foreach_1.5.2      htmltools_0.5.2    fansi_1.0.3       
        ##  [13] magrittr_2.0.3     doParallel_1.0.17  openxlsx_4.2.5    
        ##  [16] tzdb_0.1.2         globals_0.14.0     modelr_0.1.8      
        ##  [19] gower_1.0.0        vroom_1.5.7        sandwich_3.0-1    
        ##  [22] hardhat_0.2.0      rvest_1.0.2        haven_2.4.3       
        ##  [25] xfun_0.30          crayon_1.5.1       jsonlite_1.8.0    
        ##  [28] survival_3.2-13    zoo_1.8-9          iterators_1.0.14  
        ##  [31] glue_1.6.2         gtable_0.3.0       ipred_0.9-12      
        ##  [34] emmeans_1.7.3      car_3.0-11         future.apply_1.8.1
        ##  [37] DEoptimR_1.0-10    abind_1.4-5        mvtnorm_1.1-3     
        ##  [40] DBI_1.1.2          Rcpp_1.0.8.3       laeken_0.5.2      
        ##  [43] xtable_1.8-4       foreign_0.8-82     proxy_0.4-26      
        ##  [46] GPfit_1.0-8        bit_4.0.4          lava_1.6.10       
        ##  [49] prodlim_2019.11.13 vcd_1.4-9          httr_1.4.3        
        ##  [52] ellipsis_0.3.2     farver_2.1.0       pkgconfig_2.0.3   
        ##  [55] nnet_7.3-17        dbplyr_2.1.1       utf8_1.2.2        
        ##  [58] labeling_0.4.2     tidyselect_1.1.2   rlang_1.0.2       
        ##  [61] DiceDesign_1.9     munsell_0.5.0      cellranger_1.1.0  
        ##  [64] tools_4.1.3        xgboost_1.5.2.1    cli_3.3.0         
        ##  [67] generics_0.1.2     evaluate_0.15      fastmap_1.1.0     
        ##  [70] knitr_1.39         bit64_4.0.5        fs_1.5.2          
        ##  [73] zip_2.2.0          robustbase_0.93-9  future_1.24.0     
        ##  [76] xml2_1.3.3         compiler_4.1.3     rstudioapi_0.13   
        ##  [79] curl_4.3.2         e1071_1.7-9        reprex_2.0.1      
        ##  [82] lhs_1.1.5          stringi_1.7.6      highr_0.9         
        ##  [85] lattice_0.20-45    Matrix_1.4-0       vctrs_0.4.1       
        ##  [88] pillar_1.7.0       lifecycle_1.0.1    furrr_0.2.3       
        ##  [91] lmtest_0.9-39      estimability_1.3   data.table_1.14.2 
        ##  [94] R6_2.5.1           rio_0.5.29         parallelly_1.31.0 
        ##  [97] codetools_0.2-18   boot_1.3-28        MASS_7.3-55       
        ## [100] assertthat_0.2.1   withr_2.5.0        multcomp_1.4-19   
        ## [103] parallel_4.1.3     hms_1.1.1          timeDate_3043.102 
        ## [106] coda_0.19-4        class_7.3-20       rmarkdown_2.14    
        ## [109] carData_3.0-4      pROC_1.18.0        base64enc_0.1-3

    \
    **Lösung**

    Definiert man das Rezept so:

    ``` text
    rec2 <- recipe(mpg ~ hp + disp + am, data = d_train)
    ```

    Dann läuft `predict()` brav durch.

    Auch dieser Code funktioniert:

    ``` text
    rec3 <- 
      recipe(mpg ~ ., data = d_train) %>% 
      update_role(all_predictors(), new_role = "id") %>% 
      update_role(all_of(preds_chosen), new_role = "predictor") %>% 
      update_role(mpg, new_role = "outcome")
    ```

    Das Problem von `rec1` scheint darin zu legen, dass die *Rollen* der
    Variablen nicht richtig gelöscht werden, was `predict()` verwirrt:

    ``` text
    rec1 <- 
      recipe(mpg ~ ., data = d_train) %>% 
      update_role(all_predictors(), new_role = "id") %>% 
      update_role(all_of(preds_chosen), new_role = "predictor") %>% 
      update_role(mpg, new_role = "outcome")
    rec1
    ```

        ## Recipe
        ## 
        ## Inputs:
        ## 
        ##       role #variables
        ##         id          7
        ##    outcome          1
        ##  predictor          3

    Daher läuft das Rezept `rec3` durch, wenn man zunächst alle
    Prädiktoren in ID-Variablen umwandelt: Damit sind alle Rollen wieder
    sauber.
