new_point <- c(2, 4)
attrs <- c("Perimeter", "Concavity")

euclidDist <- function(point1, point2) {
  # Returns the Euclidean distance between point1 and point2.
  # Each argument is an array containing the coordinates of a point."""
  (sqrt(sum((point1 - point2)^2)))
}
distance_from_point <- function(row) {
  euclidDist(new_point, row)
}
all_distances <- function(training, new_point) {
  # Returns an array of distances
  # between each point in the training set
  # and the new point (which is a row of attributes)
  distance_from_point <- function(row) {
    euclidDist(new_point, row)
  }
  apply(training, MARGIN = 1, distance_from_point)
}

table_with_distances <- function(training, new_point) {
  # Augments the training table
  # with a column of distances from new_point
  data.frame(training, Distance = all_distances(training, new_point))
}

my_distances <- table_with_distances(cancer[, attrs], new_point)
neighbors <- cancer[order(my_distances$Distance), ]

perim_concav_with_new_point2 <- bind_rows(cancer, 
                                          tibble(Perimeter = new_point[1], 
                                                 Concavity = new_point[2], 
                                                 Class = "unknown")) |>
  ggplot(aes(x = Perimeter, 
             y = Concavity, 
             color = Class, 
             shape = Class, size = Class)) +
  geom_point(alpha = 0.6) +
  labs(color = "Diagnosis", 
       x = "Perimeter (standardized)", 
       y = "Concavity (standardized)") +
  scale_color_manual(name = "Diagnosis", 
                     labels = c("Benign", "Malignant", "Unknown"), 
                     values = c("steelblue2", "orange2", "red")) +
  scale_shape_manual(name = "Diagnosis", 
                     labels = c("Benign", "Malignant", "Unknown"),
                     values= c(16, 16, 18))+ 
  scale_size_manual(name = "Diagnosis", 
                    labels = c("Benign", "Malignant", "Unknown"),
                    values= c(2, 2, 2.5))

cancer3_plot <- 
  perim_concav_with_new_point2 +  
  geom_segment(aes(
    x = new_point[1],
    y = new_point[2],
    xend = pull(neighbors[1, attrs[1]]),
    yend = pull(neighbors[1, attrs[2]])
  ), color = "black", size = 0.5)

print(cancer3_plot)
