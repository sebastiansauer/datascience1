
alter <- c(42, 43, 44, 21, 20, 22, 22)

vektor_oh_no <- c(TRUE, TRUE, "hallo", 3.14)
vektor_oh_no

lgl_vec <- c(TRUE, TRUE, FALSE)


laender <- factor(c("Deutschland", "England", "Frankreich", NA))



library(tidyverse)


d <-
  tibble(
    laender = c("Deutschland", "England", "Frankreich", NA),
    kunden_n = c(42, 23, 3.14, NA))





ggplot(d) +
  aes(x = laender, y = kunden_n, fill = laender) +
  geom_col()







eine_liste <- list(titel = "Einführung",
                   woche = 1,
                   datum = c("2022-03-14", "2202-03-21"),
                   lernziele = c( obj1 = "dies", 
                                  obj2 = "jenes", 
                                  obj3 = "und noch mehr"),
                   lehre = c(TRUE, TRUE, TRUE)
)
str(eine_liste)


d2 <- as.data.frame(eine_liste)



ein_vektor <- c(1, 2, 3)

ein_vektor[c(1,1,1,1,1,1,1,1,1,1,1,1)]
ein_vektor[c(2)]
ein_vektor[c(TRUE, TRUE, FALSE)]
ein_vektor[c(TRUE, TRUE)]
ein_vektor[c(TRUE, TRUE, FALSE, TRUE)]

ein_vektor[0]


ein_vektor[4]





eine_liste[["lernziele"]][[1]]


pluck(eine_liste, "lernziele", "obj1")



data(mtcars)

mtcars %>% 
  summarise(across(.cols = everything(),
                   .fns = list(mean, sd)))

library(rstatix)

mtcars %>% 
  get_summary_stats(type = "mean_sd") %>% 
  pivot_longer(cols = c(n, mean, sd)) %>% 
  filter(variable == "cyl")

            


%>% 
  pivot_longer(everything(),
               names_to = "cols",
               values_to = "mean") %>% 
  pivot_wider(names_from = "cols",
              values_from = "mean")


