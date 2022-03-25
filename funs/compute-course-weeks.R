compute_course_dates <- function(dates_file,
                                 output_file = "course_dates.csv"){
  
  
  library(tidyverse)
  library(lubridate)
  library(yaml)
  
  yml_file <- dates_file
  
  dates <- read_yaml(yml_file)
  
  week1 <-  week(ymd(dates$first_day))
  
  weeks_vec <- week(ymd(dates$first_day)):(week(ymd(dates$first_day))+dates$weeks_n-1)
  
  weeks_vec
  
  teaching_vec <- rep(TRUE, dates$weeks_n)
  
  
  teaching_vec[dates$weeks_off] <- FALSE
  
  teaching_comments <- rep(NA, dates$weeks_n)
  
  
  
  course_dates <-
    tibble(
      ID = 1:length(weeks_vec),
      KW = weeks_vec,
      Lehre = teaching_vec,
      lehrfrei = !Lehre,
      Kurswoche = cumsum(Lehre),
      Wochenbeginn_Datum = ymd(dates$first_day) + ID * 7 - 7,
      Wochenabschluss_Datum = (ymd(dates$first_day)+6) + ID * 7 - 7
    )
  
  
  write_csv(course_dates, output_file)
  
}



compute_course_dates(dates_file = "course-dates.yaml")
