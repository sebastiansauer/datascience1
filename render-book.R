bookdown::preview_chapter("index.Rmd")

bookdown::preview_chapter("01-Modulueberblick.Rmd")
bookdown::preview_chapter("02-Modulzeitplan.Rmd")

bookdown::render_book("index.Rmd", output_format = "bookdown::gitbook")
bookdown::render_book("index.Rmd", output_format = "bookdown::pdf_book")
