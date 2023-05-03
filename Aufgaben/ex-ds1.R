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




# baueme ------------------------------------------------------------------


ex_baeume <-
  c("regr-tree01.Rmd",
    "regr-tree02.Rmd",
    "regr-tree03.Rmd"
    )


# Moodle:
teachertools::render_exs(ex_baeume,
                         my_edir = ex_dir,
                         output_path = path_datenwerk,
                         render_html = FALSE,
                         render_moodle = FALSE,
                         render_pdf_print = FALSE,
                         render_markdown = FALSE,
                         render_yamlrmd = TRUE,
                         thema_nr = "1")

