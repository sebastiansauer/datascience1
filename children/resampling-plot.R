illustrate_resampling <- function(n = 10, print_plot = TRUE) {
  
  library(tidyverse)
  n <- 10
  
  d <-
    tibble(
      id = 1:n,
      x = rep(1, n),
      xend = rep(10, n), 
      y = 1:n,
      yend = 1:n,
      original = "original",
      resample1 = sample(c(rep("Train", 7), rep("Test", 3))),
      resample2 = sample(c(rep("Train", 7), rep("Test", 3))),
      resample3 = sample(c(rep("Train", 7), rep("Test", 3))),
    )
  
  d_long <-
    d %>% 
    pivot_longer(cols = c(original, contains("resample")), 
                 values_to = "partition",
                 names_to = "sample")
  
    
  
  
  p2 <- 
    d_long %>%
    ggplot(aes(x = x, y = y, xend = xend, yend = y)) +
    theme_minimal() +
    scale_x_continuous(breaks = NULL, name = NULL) +
    scale_y_continuous(breaks = NULL, name = NULL) +
    geom_segment(aes(color = partition), size = 5) +
   # scale_color_discrete(guide = NULL) +
    facet_wrap(~ sample)
  
  #if (print_plot == TRUE) print(p2)
  return(p2)
  
}


