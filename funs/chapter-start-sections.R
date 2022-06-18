

chapter_start_sections <- function(i = NULL, title = NULL){
  
  source("funs/define-constants.R")
  source(render_file)
  
  stopifnot(file.exists(course_dates_file))
  stopifnot(file.exists(content_file))
  
  render_section(course_dates_file,
                 content_file,
                 i = i, 
                 title = title,
                 name = "Vorbereitung",
                 header_level = 2)
  
  render_section(course_dates_file,
                 content_file,
                 i = i, 
                 title = title,                
                 name = "Lernziele",
                 header_level = 2)
  
  
  render_section(course_dates_file,
                 content_file,
                 i = i, 
                 title = title,                
                 name = "Literatur",
                 header_level = 2)
  
  render_section(course_dates_file,
                 content_file,
                 i = i, 
                 title = title,                
                 name = "Hinweise",
                 header_level = 2)
}
