# Define constants


render_file <- "https://raw.githubusercontent.com/sebastiansauer/Lehre/main/R-Code/render-course-sections.R"

course_dates_file <- here::here("course-dates.yaml")
content_file <- here::here("_modul-ueberblick.yaml")
link_stump <- "https://sebastiansauer.github.io/datascience1/"
yml_file <- "_modul-ueberblick.yml"

stopifnot(file.exists(course_dates_file))
stopifnot(file.exists(content_file))
