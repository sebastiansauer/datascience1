bookdown::preview_chapter("40-Thema01.Rmd")
bookdown::preview_chapter("20-Modulueberblick.Rmd")
bookdown::preview_chapter("060-tidymodels1.Rmd")



bookdown::render_book("index.Rmd", output_format = "bookdown::bs4_book")

bookdown::render_book("index.Rmd", output_format = "bookdown::gitbook")
bookdown::render_book("index.Rmd", output_format = "bookdown::pdf_book")
