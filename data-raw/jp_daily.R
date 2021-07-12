library(dplyr)
library(purrr)
library(readr)
load("data/pref.rda") # load pref dataset
utils <- modules::use("data-raw/utils.R")

base_url <- "https://toyokeizai.net/sp/visual/tko/covid19/csv/"
files <- c(
  "pcr_tested_daily.csv",
  "pcr_positive_daily.csv",
  "cases_total.csv",
  "severe_daily.csv",
  "death_total.csv",
  "recovery_total.csv",
  "effective_reproduction_number.csv"
)

jp_daily <- map(
  files,
  ~ read_csv(paste0(base_url, .x),
    skip = 1,
    col_names = c("date", .x),
    col_types = list(col_date("%Y/%m/%d"), col_double())
  )
) %>%
  reduce(full_join, by = "date") %>%
  filter(across(everything(), ~ !is.na(.x))) %>%
  transmute(
    date = date,
    tests = pcr_tested_daily.csv,
    newCases = pcr_positive_daily.csv,
    activeCases = cases_total.csv,
    severeCases = severe_daily.csv,
    recovered = recovery_total.csv,
    deaths = death_total.csv,
    rt = effective_reproduction_number.csv
  ) %>%
  arrange(date)

utils$write_files(jp_daily, "data-raw/dist")
usethis::use_data(jp_daily, compress = "xz", overwrite = TRUE)
