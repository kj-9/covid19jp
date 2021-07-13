box::use(dplyr[...],
         purrr[map, reduce],
         readr[read_csv, col_date, col_double],
         . / utils)
load("data/pref.rda") # load pref dataset

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

#' @export
ingest <- function() {
  map(files,
      ~ read_csv(
        paste0(base_url, .x),
        skip = 1,
        col_names = c("date", .x),
        col_types = list(col_date("%Y/%m/%d"), col_double())
      )) %>%
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
}
