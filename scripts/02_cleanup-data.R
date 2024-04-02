#### Preamble ####
# Purpose: To clean the NHANES sleep disorder data by renaming columns for better understanding and saving the data as a parquet file
# Author: Terry Tu
# Date: 2 April 2024
# Contact: xiangyu.tu@mail.utoronto.ca
# License: MIT
# Pre-requisites: 'readr', 'dplyr', 'here', 'haven', and 'arrow' for parquet files
# The raw dataset must be located in the 'data/raw_data' directory before running this script

#### Workspace setup ####
library(readr)
library(dplyr)
library(here)
library(haven)
library(arrow)

#### Data Import ####
data <- read_xpt(here("data", "raw_data", "P_SLQ.XPT"))

#### Data Cleaning ####
# Rename columns for clarity
cleaned_data <- data %>%
  rename(
    RespondentID = SEQN,
    WeekdaySleepTime = SLQ300,
    WeekdayWakeTime = SLQ310,
    WeekdaySleepDuration = SLD012,
    WeekendSleepTime = SLQ320,
    WeekendWakeTime = SLQ330,
    WeekendSleepDuration = SLD013,
    SnoringFrequency = SLQ030,
    BreathingPauseFrequency = SLQ040,
    ReportedSleepTrouble = SLQ050,
    DaytimeSleepiness = SLQ120
  ) %>%
  # Remove NA values, if necessary (depending on the analysis you're doing)
  filter(complete.cases(.))

#### Data Export ####
# Save the cleaned data as CSV
write_csv(cleaned_data, here("data", "analysis_data", "cleaned_data.csv"))
# Save the cleaned data as a parquet file
write_parquet(cleaned_data, here("data", "analysis_data", "cleaned_data.parquet"))
