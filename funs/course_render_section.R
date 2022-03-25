render_course_section <- function(yml_file, chapter, section, header_level = 2){
  
  
  render_section <- function(d = modul_zsfg, thema, name){
    
    out <- d[[thema]][[name]]
    
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
  
  # for (i in seq_along(chapters)){
  #   
  #   # oberabschnitt:
  #   titel <- modul_zsfg[[i]][["Titel"]]
  #   cat(paste0(str_c(rep("#", header_level), collapse = "")," ", titel, "\n"))
  #   cat("\n")
    
  cat("\n")  
  
    # unterabschnitte, eine Ebene tiefer:
    render_section(thema = chapter, name = section)
  
    
    
    # Leerzeilen, bevor neues Thema anfängt
    cat("\n")
    cat("\n")
    
  
}
