#### Preamble ####
# Purpose: To perform a series of data integrity tests on the cleaned NHANES sleep disorder data
# Author: Terry Tu
# Date: 2 April 2024
# Contact: xiangyu.tu@mail.utoronto.ca
# License: MIT
# Pre-requisites: 'dplyr', 'here', 'readr', 'testthat'
# The cleaned dataset must be located in the 'data/analysis_data' directory before running this script

#### Workspace setup ####
library(readr)
library(testthat)
library(dplyr)
library(here)

# Load the cleaned data
cleaned_data <- read_csv(here("data", "analysis_data", "cleaned_data.csv"))

# Test 1: Check if every column has a valid integer ID (SEQN)
test_that("Every column has a valid integer ID", {
  expect_true(all(!is.na(cleaned_data$RespondentID) & cleaned_data$RespondentID == as.integer(cleaned_data$RespondentID)))
})

# Test 2: Check for valid values in WeekdaySleepDuration (SLD012)
test_that("Valid values in WeekdaySleepDuration", {
  expect_true(all(!is.na(cleaned_data$WeekdaySleepDuration) & cleaned_data$WeekdaySleepDuration >= 2 & cleaned_data$WeekdaySleepDuration <= 14))
})

# Test 3: Check for valid values in WeekendSleepDuration (SLD013)
test_that("Valid values in WeekendSleepDuration", {
  expect_true(all(!is.na(cleaned_data$WeekendSleepDuration) & cleaned_data$WeekendSleepDuration >= 2 & cleaned_data$WeekendSleepDuration <= 14))
})

# Test 4: Check for valid values in SnoringFrequency (SLQ030)
test_that("Valid values in SnoringFrequency", {
  expect_true(all(!is.na(cleaned_data$SnoringFrequency) & cleaned_data$SnoringFrequency %in% 0:3))
})

# Test 5: Check for valid values in BreathingPauseFrequency (SLQ040)
test_that("Valid values in BreathingPauseFrequency", {
  expect_true(all(!is.na(cleaned_data$BreathingPauseFrequency) & cleaned_data$BreathingPauseFrequency %in% 0:3))
})

# Test 6: Check for valid values in ReportedSleepTrouble (SLQ050)
test_that("Valid values in ReportedSleepTrouble", {
  expect_true(all(!is.na(cleaned_data$ReportedSleepTrouble) & cleaned_data$ReportedSleepTrouble %in% c(1, 2)))
})

# Test 7: Check for valid values in OverlySleepFrequency (SLQ120)
test_that("Valid values in OverlySleepFrequency", {
  expect_true(all(!is.na(cleaned_data$OverlySleepFrequency) & cleaned_data$OverlySleepFrequency %in% 0:4))
})

