#### Preamble ####
# Purpose: Set up the environment by installing and loading required R packages
# Author: Terry Tu
# Date: 17 April 2024
# Contact: xiangyu.tu@mail.utoronto.ca
# License: MIT

# Define a vector of required packages
required_packages <- c(
  "ggplot2", "dplyr", "tidyverse", "here", "readr", "shinyjs",
  "knitr", "kableExtra", "rstanarm", "haven", "testthat",
  "arrow", "gridExtra", "modelsummary", "bayesplot", "shiny"
)

# Function to check and install any missing packages
install_and_load <- function(packages) {
  for (package in packages) {
    if (!require(package, character.only = TRUE)) {
      install.packages(package)
      library(package, character.only = TRUE)
    }
  }
}

# Install and load the packages
install_and_load(required_packages)

# Print a message to indicate completion
cat("All required packages are installed and loaded.\n")
