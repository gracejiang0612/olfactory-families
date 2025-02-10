# Load required libraries
library(ggplot2)
library(RColorBrewer)

# Read the CSV file
data <- read.csv("top_ingredients.csv")

# Sort data by Count in descending order and keep top 10
data <- data[order(-data$Count), ]
data_top10 <- head(data, 10)

# Create the bar chart
ggplot(data_top10, aes(x = reorder(Ingredient, Count), y = Count, fill = Count)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = Count), hjust = -0.2) +
  coord_flip() +
  scale_fill_gradientn(colors = brewer.pal(11, "BuGn")) +
  theme_minimal() +
  labs(
    x = "",
    y = "",
    title = ""
  ) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  theme(
    panel.grid.major.y = element_blank(),
    panel.grid.minor.y = element_blank(),
    axis.text = element_text(size = 10),
    plot.margin = margin(10, 10, 10, 10),
    legend.position = "none"
  )