#### Preamble ####
# Purpose: To download the 2017-2020 NHANES Sleep Disorders Data
# Author: Terry Tu
# Date: 17 April 2024
# Contact: xiangyu.tu@mail.utoronto.ca
# License: MIT
# Pre-requisites: 'here' package, Internet connection required

# Load the here package
library(here)

# Define the URL of the NHANES Sleep Disorders Data
url <- "https://wwwn.cdc.gov/Nchs/Nhanes/2017-2018/P_SLQ.XPT"

# Use the here function to create a file path
destination <- here("data", "raw_data", "P_SLQ.XPT")

# Create the directory if it doesn't exist
if (!dir.exists(dirname(destination))) {
  dir.create(dirname(destination), recursive = TRUE)
}

# Download the file
download.file(url, destfile = destination, mode = "wb")
