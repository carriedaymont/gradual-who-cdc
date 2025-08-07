# gradz function for gradual transition WHO-CDC z-score smoothing
# Requires that you have WHO and CDC z-scores

# 2025-07-06

# Input variables:
#   agedays = age in days (will be converted to ageyears = age in fractional years)
#   whowtz, whohtz, whobmiz = WHO z-score for wt, ht, bmi
#   cdcwtz, cdchtz, cdcbmiz = CDC z-score for wt, ht, bmi
#       (wt = weight, ht = length or height, bmi = body mass index)

# Output variables:
#   gwtz, ghtz, gbmiz = gradual z-scores (WHO ≤ 730 days, weighted average 731–1825 days, CDC ≥ 1826 days)

# Example usage, assuming 'df' is your dataset
#     result <- gradz(df)

library(dplyr)

gradz <- function(d) {
  # Convert age in days to fractional age in years
  d <- d %>%
    mutate(ageyears = agedays / 365.25)
  
  # Generate weights for the weighted average for ages 2-5 years
  d <- d %>%
    mutate(
      whoweight = 5 - ageyears,
      cdcweight = ageyears - 2
    )
  
  # Gradual transition smoothing for each variable (wt, ht, bmi)
  d <- d %>%
    mutate(
      gwtz = case_when(
        # If <= 2 years, use WHO only
        agedays <= 730 ~ whowtz,
        # If >= 5 years, use CDC only
        agedays >= 1826 ~ cdcwtz,
        # Between 2 and 5 years: if either z-score is missing, result is NA
        is.na(whowtz) | is.na(cdcwtz) ~ NA_real_,
        # Otherwise, compute weighted average
        TRUE ~ (whowtz * whoweight / 3) + (cdcwtz * cdcweight / 3)
      ),
      ghtz = case_when(
        agedays <= 730 ~ whohtz,
        agedays >= 1826 ~ cdchtz,
        is.na(whohtz) | is.na(cdchtz) ~ NA_real_,
        TRUE ~ (whohtz * whoweight / 3) + (cdchtz * cdcweight / 3)
      ),
      gbmiz = case_when(
        agedays <= 730 ~ whobmiz,
        agedays >= 1826 ~ cdcbmiz,
        is.na(whobmiz) | is.na(cdcbmiz) ~ NA_real_,
        TRUE ~ (whobmiz * whoweight / 3) + (cdcbmiz * cdcweight / 3)
      )
    )
  
  # Drop intermediate weight variables
  d <- d %>%
    select(-whoweight, -cdcweight)
  
  # Return the processed data
  return(d)
}

# Example usage, assuming 'df' is your dataset
#     result <- gradz(df)
