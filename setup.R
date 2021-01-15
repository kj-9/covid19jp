install.packages(
  c(
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
    "modules"
  )
)
remotes::install_deps(dependencies = TRUE)
