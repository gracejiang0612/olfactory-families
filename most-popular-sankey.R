library(tidyverse)
library(ggsankey)
library(ggplot2)
library(RColorBrewer)

perfume_data <- read_csv("/Users/Grace/Desktop/2025-studio/project-1/Most-popular-perfume.csv")

# Get different color palettes
piyg_colors <- colorRampPalette(brewer.pal(11, "PiYG"))(nrow(perfume_data))  # For perfume flows
spectral_colors <- colorRampPalette(brewer.pal(11, "Spectral"))(length(c(all_families, all_subfamilies)))  # For nodes
brbg_colors <- brewer.pal(3, "BrBG")  # For stages

# Create the main dataset with actual perfume connections
df_main <- perfume_data %>%
  select(Perfume, Family, Subfamily) %>%
  mutate(
    Perfume = toupper(Perfume),
    Family = toupper(Family),
    Subfamily = toupper(Subfamily)
  )

# Define the desired order of families and subfamilies (all in caps)
all_families <- c("CITRUS", "AROMATIC FOUGERE", "FLORAL", "WOODY", "CHYPRE", "AMBERY (ORIENTAL)", "LEATHER")
all_subfamilies <- c("CITRUS", "GREEN", "WATERY", "AROMATIC FOUGERE", "ALDEHYDIC", 
                     "FLORAL", "FRUITY", "SPICY", "WOODY", "CHYPRE", "TOBACCO", 
                     "GOURMAND", "AMBERY (ORIENTAL)", "LEATHER", "MUSK SKIN")

# Instead of using NA for dummy connections, use empty string
df_missing_families <- tibble(
  Perfume = "",
  Family = setdiff(all_families, unique(df_main$Family)),
  Subfamily = ""
)

df_missing_subfamilies <- tibble(
  Perfume = "",
  Family = "",
  Subfamily = setdiff(all_subfamilies, unique(df_main$Subfamily))
)

# Combine all data
df <- bind_rows(
  df_main,
  df_missing_families,
  df_missing_subfamilies
) %>%
  filter(!(Perfume == "" & Family == "" & Subfamily == ""))

# Convert to long format
df_long <- df %>%
  make_long(Perfume, Family, Subfamily) %>%
  filter(node != "")

# Create color mapping for all nodes
node_colors <- c(
  # Colors for perfumes using PiYG
  setNames(piyg_colors, unique(df_main$Perfume)),
  # Colors for families and subfamilies using Spectral
  setNames(spectral_colors, c(all_families, all_subfamilies))
)

# Create the plot
ggplot(df_long, aes(x = x, 
                    next_x = next_x, 
                    node = node, 
                    next_node = next_node,
                    fill = factor(node),
                    label = node)) +
  geom_sankey(flow.alpha = 0.6,
              smooth = 3,
              width = 0.3,
              show.legend = FALSE) +
  geom_sankey_label(size = 3,
                    color = "black",
                    fill = "white") +
  scale_fill_manual(values = node_colors) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, 
                              size = 14,
                              face = "bold",
                              margin = margin(b = 5)),
    plot.subtitle = element_text(hjust = 0.5, 
                                 size = 11,
                                 margin = margin(b = 10)),
    plot.caption = element_text(hjust = 0, 
                                size = 9,
                                color = "gray30",
                                face = "italic",
                                margin = margin(t = 10)),
    axis.title = element_blank(),
    axis.text.y = element_blank(),
    axis.text.x = element_text(size = 10,
                               color = brbg_colors),  # Using BrBG colors for stage labels
    panel.grid = element_blank(),
    plot.margin = margin(t = 20, r = 10, b = 10, l = 10)
  ) +
  labs(
    title = "America's Love Affair with Floral Fragrances",
    subtitle = "Olfactory Families and Nuances of 16 Best-Selling Perfumes in United States",
    caption = "Valume based on bestseller rankings from major U.S. retailers (Sephora, Ulta Beauty, Macy's and Bloomingdale's).\nFragrances included appeared in top 10 lists of at least two retailers. \nOlfactory classification data: Wikiparfum."
  ) +
  scale_x_discrete(labels = c("Perfumes", "Families", "Subfamilies"))

# Save the plot with higher resolution
ggsave("perfume_sankey.png", width = 15, height = 12, dpi = 300)