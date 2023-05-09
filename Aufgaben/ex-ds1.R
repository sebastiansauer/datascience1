#DS1 SoSe 23



# Setup -------------------------------------------------------------------




library(dplyr)

library(exams)
library(teachertools)
#options(digits = 2)


#Sys.setenv(R_CONFIG_ACTIVE = "dev")  # for testing
Sys.setenv(R_CONFIG_ACTIVE = "default")  # for production
#config <- config::get()
#config

# Maschine 1 (Macbook)
ex_dir <- "/Users/sebastiansaueruser/github-repos/rexams-exercises/exercises"

path_datenwerk <- "/Users/sebastiansaueruser/github-repos/datenwerk/posts"


# stat-learning -----------------------------------------------------------

ex_stat_learning <-
  c("Boostrap1.Rmd",
    "CV1.Rmd",
    "supervisedlearning.Rmd",
    "diamonds-tidymodels01.Rmd")

# Datenwerk:
teachertools::render_exs(ex_stat_learning[4],
                         my_edir = ex_dir,
                         output_path = path_datenwerk,
                         render_html = FALSE,
                         render_moodle = FALSE,
                         render_pdf_print = FALSE,
                         render_markdown = FALSE,
                         render_yamlrmd = TRUE,
                         thema_nr = "1")





# baueme ------------------------------------------------------------------


ex_baeume <-
  c("regr-tree01.Rmd",
    "regr-tree02.Rmd",
    "regr-tree03.Rmd",
    "Flex-vs-nichtflex-Methode.Rmd",
    "Flex-vs-nichtflex-Methode2.Rmd",    
    "Flex-vs-nichtflex-Methode3.Rmd", 
    "tidymodels-penguins07.Rmd"
    )

ex_baueme2 <-
  c("Tengku-Hanis01.Rmd",
    "bike01.Rmd",
    "bike02.Rmd",
    "bike03.Rmd",
    "bike04.Rmd")

# Datenwerk:
teachertools::render_exs( "nasa06.Rmd",
                         my_edir = ex_dir,
                         output_path = path_datenwerk,
                         render_html = FALSE,
                         render_moodle = FALSE,
                         render_pdf_print = FALSE,
                         render_markdown = FALSE,
                         render_yamlrmd = TRUE,
                         thema_nr = "1")





# Ensembles ---------------------------------------------------------------


exs_ensemble <-
  c(
    "tidymodels-vorlage.Rmd",
    "tidymodels-vorlage2.Rmd",
    "tidymodels-tree3.Rmd",
    "tidymodels-tree2.Rmd",   
    "tidymodels-tree1.Rmd",   
    "rf-usemodels.Rmd",
    "rf-finalize2.Rmd",
    "rf-finalize.Rmd",
    "tidymodels3.Rmd",
    "Bootstrap1.Rmd",
    "diamonds-tidymodels01.Rmd"
    )


exs_ensemble2 <-
  c(
    "rf-finalize3.Rmd",
    "wfsets_penguins01.Rmd",
    "wfsets_penguins02.Rmd"
  )


# Datenwerk:
teachertools::render_exs( exs_ensemble2,
                          my_edir = ex_dir,
                          output_path = path_datenwerk,
                          render_html = FALSE,
                          render_moodle = FALSE,
                          render_pdf_print = FALSE,
                          render_markdown = FALSE,
                          render_yamlrmd = TRUE,
                          thema_nr = "1")




# Kaggle tmdb -------------------------------------------------------------


exs_tmdb <-
  c(
    "tmdb01.Rmd",
    "tmdb02.Rmd",    
    "tmdb03.Rmd",    
    "tmdb04.Rmd",    
    "tmdb05.Rmd",
    "tmdb06.Rmd",
    "tmdb07.Rmd",
    "tmdb08.Rmd"
  )



# Datenwerk:
teachertools::render_exs(
  exs_tmdb,
  my_edir = ex_dir,
  output_path = path_datenwerk,
  render_html = FALSE,
  render_moodle = FALSE,
  render_pdf_print = FALSE,
  render_markdown = FALSE,
  render_yamlrmd = TRUE,
  thema_nr = "1")

