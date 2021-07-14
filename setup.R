remotes::update_packages(c(
  "usethis",
  "purrr",
  "dplyr",
  "readr",
  "tidyr",
  "rvest",
  "stringr",
  "stringi",
  "xml2",
  "rJava",
  "tabulizer",
  "log4r",
  "box",
  "devtools"
),
upgrade = "always"
)
remotes::install_deps(dependencies = TRUE)
