bookdown::preview_chapter("03-Thema01.Rmd")
bookdown::preview_chapter("01-Modulueberblick.Rmd")
bookdown::preview_chapter("02-Modulzeitplan.Rmd")

bookdown::render_book("index.Rmd", output_format = "bookdown::gitbook")
bookdown::render_book("index.Rmd", output_format = "bookdown::pdf_book")
