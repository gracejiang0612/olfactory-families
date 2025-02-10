# Load required libraries
library(ggplot2)
library(RColorBrewer)
library(ggtext)

# Create the data manually to ensure correct order
data_top10 <- data.frame(
  Ingredient = c("Jasmine(Grandiflorum)", "Pear", "Pink Pepper", "Jasmine (Sambac)", 
                 "Musk", "Mandarin", "Vanilla", "Patchouli", "Bergamot", "Jasmine"),
  Count = c(16, 14, 12, 12, 10, 10, 10, 8, 8, 6)
)

# Create custom labels with colored and bold Jasmine
axis_labels <- data_top10$Ingredient
jasmine_indices <- grep("jasmine|Jasmine", axis_labels, ignore.case = TRUE)
if(length(jasmine_indices) > 0) {
  axis_labels[jasmine_indices] <- paste0("<span style='color:#006400'><strong>", axis_labels[jasmine_indices], "</strong></span>")
}

# Create the bar chart
ggplot(data_top10, aes(x = reorder(Ingredient, Count), y = Count, fill = Count)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = Count), hjust = -0.2) +
  coord_flip() +
  scale_fill_gradientn(colors = brewer.pal(9, "Greens")) +
  theme_minimal() +
  labs(
    x = "",
    y = "",
    title = "<span style='color:#006400'><strong>Jasmine</span>, the Queen Note in Modern Perfumery",
    subtitle = "Key Ingredients in 16 Top-Selling Fragrances in United States",
    caption = "Olfactory classification data: Wikiparfum"
  ) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  scale_x_discrete(labels = axis_labels) +
  theme(
    panel.grid.major.y = element_blank(),
    panel.grid.minor.y = element_blank(),
    axis.text.y = element_markdown(size = 10),
    axis.text.x = element_text(size = 10),
    plot.margin = margin(10, 10, 10, 10),
    legend.position = "none",
    plot.title = element_markdown(size = 14),
    plot.subtitle = element_text(size = 11),
    plot.caption = element_text(size = 9, hjust = 1)
  )