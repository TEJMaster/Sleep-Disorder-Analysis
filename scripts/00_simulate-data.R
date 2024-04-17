#### Preamble ####
# Purpose: To simulate a dataset resembling NHANES sleep disorder data
# Author: Terry Tu
# Date: 17 April 2024
# Contact: xiangyu.tu@mail.utoronto.ca
# License: MIT
# Pre-requisites: tidyverse package

# Load necessary libraries
library(tidyverse)

# Set a seed for reproducibility
set.seed(2024)

# Define the number of individuals to simulate
n_people <- 1000

# Simulate weekday and weekend sleep duration based on normal distributions
weekday_sleep <- rnorm(n_people, mean = 7, sd = 1.5)
weekend_sleep <- rnorm(n_people, mean = 8, sd = 2)

# Simulate snoring frequency based on a categorical distribution
snoring_frequency <- sample(0:3, n_people, replace = TRUE, prob = c(0.5, 0.2, 0.2, 0.1))

# Simulate breathing pause frequency assuming it's less common
breathing_pause_frequency <- sample(0:3, n_people, replace = TRUE, prob = c(0.7, 0.15, 0.1, 0.05))

# Simulate reported sleep trouble based on a binomial distribution where probability(p) depends on other factors
p_sleep_trouble <- plogis(-0.5 + 0.1 * weekday_sleep - 0.05 * weekend_sleep + 0.2 * snoring_frequency + 0.3 * breathing_pause_frequency)
reported_sleep_trouble <- rbinom(n_people, 1, p_sleep_trouble)

# Combine all variables into a data frame
simulated_sleep_data <- tibble(
  WeekdaySleepDuration = weekday_sleep,
  WeekendSleepDuration = weekend_sleep,
  SnoringFrequency = snoring_frequency,
  BreathingPauseFrequency = breathing_pause_frequency,
  ReportedSleepTrouble = reported_sleep_trouble
)

# Inspect the first few rows of the simulated data
head(simulated_sleep_data)

# Plot the relationship between sleep duration and reported trouble
ggplot(simulated_sleep_data, aes(x = WeekdaySleepDuration, fill = as.factor(ReportedSleepTrouble))) +
  geom_histogram(position = "identity", alpha = 0.5, bins = 30) +
  labs(title = "Simulated Data: Weekday Sleep Duration and Reported Sleep Trouble",
       x = "Weekday Sleep Duration (hours)",
       fill = "Reported Sleep Trouble") +
  theme_minimal()

