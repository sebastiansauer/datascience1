render_course_table <- function(yml_file){

  require(glue)
  require(tidyverse)

  stopifnot(file.exists(yml_file))
  modul_zsfg <- yaml::read_yaml(paste0(here::here(), "/", yml_file))


  titel_nr <- modul_zsfg %>% names() %>% seq_along()


  datum <- vector()
  thema <- vector()
  kw <- vector()

  for (i in titel_nr){
    datum[i] <- modul_zsfg[[i]][["Datum"]]
    kw[i] <- modul_zsfg[[i]][["Kalenderwoche"]]
    thema[i] <- modul_zsfg[[i]][["Titel"]]
  }


  cat("Nr. | Kalenderwoche | Datum | Thema")
  cat("\n")
  cat("---|---|---|--")
  cat("\n")

  for (j in titel_nr){
    cat(glue("{titel_nr[j]} | {kw[j]} | {datum[j]} | {thema[j]}"))
    cat("\n")
    #cat("---|---|---|--")
    #cat("\n")
  }

}
