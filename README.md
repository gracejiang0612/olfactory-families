# Popular Fragrance Analysis

An analysis of the most popular fragrances in the United States based on bestseller rankings from major retailers.

## Overview

This project analyzes the most popular fragrances across major U.S. retailers, identifying common olfactory families and ingredients. By scraping data from retail websites and perfume databases, this research provides insights into fragrance trends and consumer preferences.

## Methodology

My inspiration came from a Reddit post: "A Brief Analysis of the Most Popular Femfrags in the U.S." Since there was no readily available ranking of popular fragrances, I manually gathered data from four major retailers:
- Sephora
- Ulta Beauty
- Macy's
- Bloomingdale's

Using the Fragrance section of each site, I filtered for the highest-rated products and then sorted them by Bestseller. I selected the top ten perfumes from each platform. From this dataset, I ranked 16 perfumes based on how frequently they appeared in the top ten across multiple platforms—each perfume was listed in at least two of the four stores' top-ten lists.

To analyze the olfactory families and ingredients of each fragrance, I used Wikiparfum, a digital platform for perfume enthusiasts. Since different versions of the same fragrance exist across generations, the URLs lacked a consistent pattern. I manually searched for and recorded each perfume's URL, then used BeautifulSoup to scrape the olfactory family and ingredient details.

For ingredient analysis, I used pandas. For data visualization, I used R Studio, creating a Sankey diagram with ggsankey and ranking ingredients with ggplot.

## Tools Used

- **Data Collection**: Manual research across retail websites
- **Web Scraping**: BeautifulSoup (Python)
- **Data Analysis**: pandas (Python)
- **Data Visualization**: R Studio with ggsankey and ggplot2

## Limitations

The four retail platforms I used cater primarily to female consumers. As a result, my findings are likely skewed toward female preferences.

## Results

[Include key findings, visualizations, and insights here]

## Repository Structure

```
├── data/                  # Raw and processed datasets
├── scripts/               # Python scripts for web scraping and data processing
├── R/                     # R scripts for visualization
├── visualizations/        # Output visualizations
└── README.md              # Project documentation
```

## Getting Started

### Prerequisites

- Python 3.x
- R 4.x
- Required Python packages:
  - pandas
  - BeautifulSoup4
  - requests
- Required R packages:
  - ggsankey
  - ggplot2
  - tidyverse

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/fragrance-analysis.git

# Install Python dependencies
pip install -r requirements.txt

# Install R dependencies (run in R)
install.packages(c("ggplot2", "ggsankey", "tidyverse"))
```

## Usage

[Provide examples of how to run your scripts and generate visualizations]

## License

[Add your license information here]

## Acknowledgements

- Wikiparfum for providing detailed fragrance information
- The original Reddit post that inspired this analysis
