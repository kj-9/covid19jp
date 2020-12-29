library(readr)

pref <- read_csv("data-raw/dist/pref.csv")

usethis::use_data(pref, overwrite = TRUE)
