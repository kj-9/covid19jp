library(dplyr)
utils <- modules::use("data-raw/utils.R")

url <- "https://github.com/kaz-ogiwara/covid19/raw/master/data/prefectures.csv"
pref_daily <- readr::read_csv(url, na = "-") %>%
  left_join(pref, by = c("prefectureNameJ" = "prefJP")) %>%
  transmute(
    prefCode,
    prefJP = prefectureNameJ,
    prefEN,
    date = as.Date(paste(year, month, date, sep = "-")),
    tests = peopleTested,
    newCases = testedPositive,
    activeCases = hospitalized,
    severeCases = serious,
    recovered = discharged,
    deaths = deaths,
    rt = effectiveReproductionNumber
  ) %>%
  arrange(prefCode, date)


utils$write_files(pref_daily, "data-raw/dist")

usethis::use_data(pref_daily, compress = "xz", overwrite = TRUE)
