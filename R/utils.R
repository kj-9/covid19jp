#' split a string by "/" and parse as number
#'
#' @param x A string.
#' @param which An integer selecting which split strings is returned.
#' @return A split string parsed as number
#' @examples
#' split_slash("1/2/3", 1)
#' split_slash("1/2/3", 3)
split_slash <- function(x, which) {
  purrr::map_dbl(x, ~ readr::parse_number(stringr::str_split(.x, "/", simplify = T)[which]))
}


#' Check if a given data.fame has unique 47 Japanese prefectures.
#'
#' @param df A data.frame
#' @param pref_column A string of prefecture column name in a data.frame
#' @return A logical value
#' @examples
#' split_slash("1/2/3", 1)
#' split_slash("1/2/3", 3)
check_pref_names <- function(df, pref_column) {
  stopifnot(is.data.frame(df))

  if (!all(sort(df[[pref_column]]) == sort(pref_names))) {
    warn(paste0(e, "Prefectures in the data.frame is not correct."))

    return(FALSE)
  }

  is_na <- df %>%
    purrr::map(is.na) %>%
    purrr::map_lgl(all) %>%
    colnames(df)[.]

  if (length(is_na) > 0) {
    warn(logger, paste0("There is na in data: ", paste0(is_na, collapse = ", ")))
  }

  return(TRUE)
}

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
