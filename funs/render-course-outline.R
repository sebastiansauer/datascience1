render_course_outline <- function(yml_file, header_level = 2){


  render_section <- function(d = modul_zsfg, name){

    out <- d[[i]][[name]]

    if (!is.null(out)){
      cat(paste0(str_c(rep("#", header_level + 1), collapse = "")," ", name, " \n"))
      cat("\n")
      for (i in out) {
        cat(paste0("- ", i))
        cat("\n")
      }

      cat("\n")
      cat("\n")
    }
  }


  stopifnot(file.exists(yml_file))
  modul_zsfg <- yaml::read_yaml(paste0(here::here(), "/", yml_file))



  chapters <- modul_zsfg %>% names()

  for (i in seq_along(chapters)){

    # oberabschnitt:
    titel <- modul_zsfg[[i]][["Titel"]]
    cat(paste0(str_c(rep("#", header_level), collapse = "")," ", titel, "\n"))
    cat("\n")


    # unterabschnitte, eine Ebene tiefer:
    render_section(name = "Datum")
    render_section(name = "Lernziele")
    render_section(name = "Vorbereitung")
    render_section(name = "Literatur")
    render_section(name = "Skript")
    render_section(name = "Videos")
    render_section(name = "Syntax")
    render_section(name = "Fallstudien")
    render_section(name = "Aufgaben")
    render_section(name = "Vertiefung")
    render_section(name = "Hinweise")


    # Leerzeilen, bevor neues Thema anfängt
    cat("\n")
    cat("\n")

  }


}
