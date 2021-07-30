box::use(dplyr[...],
         readr[read_csv],
         . / utils)
load("data/pref.rda") # load pref dataset

url <-
  "https://toyokeizai.net/sp/visual/tko/covid19/csv/prefectures.csv"

#' @export
ingest <- function() {
  read_csv(url, na = "-") %>%
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
      rt = as.numeric(effectiveReproductionNumber)
    ) %>%
    arrange(prefCode, date)
}
