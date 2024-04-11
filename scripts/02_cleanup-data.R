#### Preamble ####
# Purpose: To clean the NHANES sleep disorder data by renaming columns, removing missing/refused/don't know responses, removing unnecessary columns, and saving the data as a parquet file
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
# Rename columns for clarity, remove missing/refused/don't know responses, and select only the relevant columns
cleaned_data <- data %>%
  rename(
    RespondentID = SEQN,
    WeekdaySleepDuration = SLD012,
    WeekendSleepDuration = SLD013,
    SnoringFrequency = SLQ030,
    BreathingPauseFrequency = SLQ040,
    ReportedSleepTrouble = SLQ050,
    OverlySleepFrequency = SLQ120
  ) %>%
  filter(
    !is.na(WeekdaySleepDuration),
    !is.na(WeekendSleepDuration),
    !is.na(SnoringFrequency) & SnoringFrequency != 7 & SnoringFrequency != 9,
    !is.na(BreathingPauseFrequency) & BreathingPauseFrequency != 7 & BreathingPauseFrequency != 9,
    !is.na(ReportedSleepTrouble) & ReportedSleepTrouble != 7 & ReportedSleepTrouble != 9,
    !is.na(OverlySleepFrequency) & OverlySleepFrequency != 7 & OverlySleepFrequency != 9
  ) %>%
  select(
    RespondentID,
    WeekdaySleepDuration,
    WeekendSleepDuration,
    SnoringFrequency,
    BreathingPauseFrequency,
    ReportedSleepTrouble,
    OverlySleepFrequency
  )

#### Data Export ####
# Save the cleaned data as CSV
write_csv(cleaned_data, here("data", "analysis_data", "cleaned_data.csv"))
# Save the cleaned data as a parquet file
write_parquet(cleaned_data, here("data", "analysis_data", "cleaned_data.parquet"))

