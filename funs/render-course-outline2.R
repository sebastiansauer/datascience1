render_course_outline2 <- function(course_dates_file, content_file, header_level = 2, small_table = FALSE){
  
  
  render_section <- function(d = master_table, name, id){
    
    
    if (class(d[[name]]) != "list") {
      
      cat("\n")
      cat(paste0(str_c(rep("#", header_level + 1), collapse = "")," ", name, " \n"))
      cat("\n")
      out <- as.character(unname(d[[name]][id]))
      cat(out)
      cat("\n")
    }
    
    if (class(master_table[[name]]) == "list") {
      
      out <- d[[name]][[1]][[id]]
      
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
    
    cat("\n")
    
  }
  
  
  
  course_dates <- read_csv(course_dates_file,)
  course_topics_l <- yaml::read_yaml(content_file)
  
  
  course_topics <-
    tibble(
      Titel = course_topics_l %>% map_chr("Titel")) %>%
    mutate(Lernziele = list(course_topics_l %>% map("Lernziele"))) %>%
    mutate(Vorbereitung = list(course_topics_l %>% map("Vorbereitung"))) %>%
    mutate(Literatur = list(course_topics_l %>% map("Literatur"))) %>%
    mutate(Videos = list(course_topics_l %>% map("Videos"))) %>%
    mutate(Skript = list(course_topics_l %>% map("Skript"))) %>%
    mutate(Aufgaben = list(course_topics_l %>% map("Aufgaben"))) %>%
    mutate(Vertiefung = list(course_topics_l %>% map("Vertiefung"))) %>%
    mutate(Hinweise = list(course_topics_l %>% map("Hinweise")))
  
  
  master_table <-
    course_dates %>%
    left_join(course_topics, by = "ID")
  
  
  chapters <-
    master_table %>%
    pull(Titel) %>%
    simplify()
  
  subsections <-
    master_table %>%
    names()
  
  if (small_table == FALSE){
    
    for (i in seq_along(chapters)){
      
      # oberabschnitt:
      
      cat(paste0(str_c(rep("#", header_level), collapse = "")," ", chapters[i], "\n"))
      cat("\n")
      
      
      # unterabschnitte, eine Ebene tiefer:
      
      
      for (j in subsections){
        
        render_section(d = master_table,
                       name = j,
                       id = i)
      }
      
      
      # Leerzeilen, bevor neues Thema anfängt
      cat("\n")
      cat("\n")
      
    }
  } else {
    master_table %>%
      filter(Lehre == TRUE) %>%
      select(Kurswoche, KW, Titel, Wochenbeginn_Datum) %>%
      gt::gt()
    
  }
  
}
