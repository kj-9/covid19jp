box::use(
  readr[write_csv],
  jsonlite[write_json],
  log4r
)


#' @export
write_files <- function(df, path_prefix) {
  paths <-
    paste0(path_prefix, c(".csv", ".json"))

  write_csv(df, paths[1])
  write_json(df, paths[2])
}

#' @export
info <- function(message) {
  logger <- log4r$logger()
  log4r$info(logger, message)
}

#' @export
warn <- function(message) {
  logger <- log4r$logger()
  log4r$warn(logger, message)
}

#' @export
error <- function(message) {
  logger <- log4r$logger()
  log4r$error(logger, message)
}
