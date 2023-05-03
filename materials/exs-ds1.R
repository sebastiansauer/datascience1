#DS1 SoSe 23



# Setup -------------------------------------------------------------------




library(dplyr)

library(exams)
library(teachertools)
#options(digits = 2)


#Sys.setenv(R_CONFIG_ACTIVE = "dev")  # for testing
#Sys.setenv(R_CONFIG_ACTIVE = "default")  # for production
#config <- config::get()
#config

# Maschine 1 (Macbook)
ex_dir <- "/Users/sebastiansaueruser/github-repos/rexams-exercises/exercises"

path_exams_rendered <- "/Users/sebastiansaueruser/Google Drive/Lehre/Lehre_AKTUELL/2023-SoSe/QM1/Aufgaben/exs-rendered"

path_datenwerk <- "/Users/sebastiansaueruser/github-repos/datenwerk/posts"



# Thema 4 stat-learning ---------------------------------------------------

exs_stat_learning <-
  c(
    "breiman.Rmd",
    "mse.Rmd",
    "Test-MSE1.Rmd"
  )


#  Thema 5 tidymodels  ---------------------------------------------------------



exs_tidymodels <-
  c(
    "tidymodels-ames-01.Rmd",
    "tidymodels-ames-02.Rmd",
    "tidymodels-ames-03.Rmd",
    "tidymodels-ames-04.Rmd",
    "bike01.Rmd"
  )

# Datenwerk:
teachertools::render_exs(exs_tidymodels,
           my_edir = ex_dir,
           output_path = path_datenwerk,
           render_html = FALSE,
           render_moodle = FALSE,
           render_pdf_print = FALSE,
           render_markdown = FALSE,
           render_yamlrmd = TRUE,
           thema_nr = "exs_tidymodels")



# Resampling und Tuning ---------------------------------------------------



exs_tuning <-
  c(
    "tidymodels-penguins01.Rmd",
    "tidymodels-penguins02.Rmd",
    "tidymodels-penguins03.Rmd",
    "tidymodels-penguins04.Rmd",
    "tidymodels-penguins05.Rmd", 
    "tidymodels-poly01.Rmd",
    "tidymodels-poly02.Rmd",
    "knn-ames01.Rmd"
    )



# Datenwerk:
teachertools::render_exs("knn-ames01.Rmd",
                         my_edir = ex_dir,
                         output_path = path_datenwerk,
                         render_html = FALSE,
                         render_moodle = FALSE,
                         render_pdf_print = FALSE,
                         render_markdown = FALSE,
                         render_yamlrmd = TRUE,
                         thema_nr = "exs_datenwerk")

