render_course_outline <- function(yml_file){


  render_section <- function(d = modul_zsfg, name, level = 3){

    out <- d[[i]][[name]]

    if (!is.null(out)){
      cat(paste0(str_c(rep("#", level), collapse = "")," ", name, " \n"))
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

    titel <- modul_zsfg[[i]][["title"]]
    cat("###", titel, "\n")
    cat("\n")


    # unterabschnitte:
    render_section(name = "datum")
    render_section(name = "lernziele")
    render_section(name = "vorbereitung")
    render_section(name = "literatur")
    render_section(name = "skript")
    render_section(name = "videos")
    render_section(name = "syntax")
    render_section(name = "fallstudien")
    render_section(name = "aufgaben")
    render_section(name = "vertiefung")
    render_section(name = "hinweise")


    # Leerzeilen, bevor neues Thema anfängt
    cat("\n")
    cat("\n")

  }


}
