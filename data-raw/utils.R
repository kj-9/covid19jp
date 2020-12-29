write_files <- function(df, path) {
  df_sym <- rlang::ensym(df)
  paths <-
    paste0(file.path(path, df_sym), c(".csv", ".json"))

  readr::write_csv(df, paths[1])
  jsonlite::write_json(df, paths[2])
}

info <- function(message) {
  logger <- log4r::logger()
  log4r::info(logger, message)
}

warn <- function(message) {
  logger <- log4r::logger()
  log4r::warn(logger, message)
}

error <- function(message) {
  logger <- log4r::logger()
  log4r::error(logger, message)
}

