#### Preamble ####
# Purpose: To construct a Bayesian logistic regression model assessing the impact of sleep-related variables on reported sleep trouble using rstanarm
# Author: Terry Tu
# Date: 2 April 2024
# Contact: xiangyu.tu@mail.utoronto.ca
# License: MIT
# Pre-requisites: The 'rstanarm' package for Bayesian modeling, 'readr' for data manipulation, and 'here' for path management
# The 'cleaned_data' dataset must be pre-processed before using it in the model.

#### Workspace setup ####
library(readr)
library(rstanarm)
library(here)

#### Read data ####
cleaned_data <- read_csv(here("data", "analysis_data", "cleaned_data.csv"))

# Ensure reproducibility
set.seed(2024)

#### Model data ####
bayesian_logistic_model <- stan_glm(
  ReportedSleepTrouble ~ WeekdaySleepDuration + WeekendSleepDuration + SnoringFrequency + BreathingPauseFrequency + OverlySleepFrequency,
  data = cleaned_data,
  family = binomial(), # Indicating a logistic regression model
  prior = normal(0, 1), # Set the prior for the regression coefficients
  prior_intercept = normal(0, 1), # Set the prior for the intercept
)

# Summary of the model to check for immediate red flags
summary(bayesian_logistic_model)

#### Save model ####
# Save the Bayesian logistic regression model as an .rds file to the 'models' folder
saveRDS(
  bayesian_logistic_model,
  file = here("models", "bayesian_logistic_model.rds")
)
