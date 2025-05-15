# -----------------------------------------------
#  Preparing data for SQL db and querying
#  EDS 213
#  By Takeen Shamloo
# -----------------------------------------------

# ---- Load packages ----
library(readr)    
library(dplyr)     
library(janitor)
library(here)    
library(lubridate)
library(tidyr)

# ---- Read in data ----

# Actual shortage contains: org_id, pwsid, start/end date, and shortage level.
clean_shortage = read_csv(here("data", "actual_water_shortage_level.csv")) |>
  clean_names() |>
  drop_na()

# Limiting forecasted monthly data to only look at the same columns as actual shortage.
clean_monthly_outlook = read_csv(here("data", "monthly_water_shortage_outlook.csv")) |>
  clean_names() |>
  select(c(
    org_id, 
    pwsid, 
    supplier_name, 
    forecast_start_date, 
    forecast_end_date, 
    state_standard_shortage_level)
    ) |>
  rename(
    start_date = forecast_start_date, # renaming for consistency.
    end_date = forecast_end_date # renaming for consistency.
    ) |>
  drop_na()

# ---- Inspect data types first ----
str(clean_shortage)
str(clean_monthly_outlook)

# ---- Export cleaned CSV ----
write_csv(clean_shortage, here("data", "cleaned", "actual_shortage_clean.csv"))
write_csv(clean_monthly_outlook,  here("data", "cleaned", "monthly_outlook_clean.csv"))