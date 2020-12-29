library(readr)

pref <- read_csv("data-raw/dist/pref.csv")

usethis::use_data(pref, compress = "xz", overwrite = TRUE)
