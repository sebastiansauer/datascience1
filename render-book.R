bookdown::preview_chapter("index.Rmd")
bookdown::preview_chapter("010-Hinweise.Rmd")
bookdown::preview_chapter("020-Modulueberblick.Rmd")
bookdown::preview_chapter("040-Statistisches-Lernen.Rmd")
bookdown::preview_chapter("050-R-Vertiefung.Rmd")
bookdown::preview_chapter("060-tidymodels.Rmd")
bookdown::preview_chapter("070-knn.Rmd")
bookdown::preview_chapter("080-Resampling-Tuning.Rmd")
bookdown::preview_chapter("090-logistische-Regression.Rmd")
bookdown::preview_chapter("100-Entscheidungsbäume.Rmd")
bookdown::preview_chapter("110-Ensemble-Lerner.Rmd")
bookdown::preview_chapter("120-Regularisierte-Modelle.Rmd")
bookdown::preview_chapter("130-Kaggle.Rmd")
bookdown::preview_chapter("140-roter-Faden.Rmd")

bookdown::preview_chapter("150-Fallstudien.Rmd")

bookdown::preview_chapter("160-Dimensionsreduktion.Rmd")

bookdown::render_book("index.Rmd", 
                      output_format = "bookdown::bs4_book")

#bookdown::render_book("index.Rmd", output_format = "bookdown::gitbook")
#bookdown::render_book("index.Rmd", output_format = "bookdown::pdf_book")
