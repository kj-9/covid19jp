write.csv(data.frame(a=1), "inst/extdata/test.csv")


#' split a string by "/" and parse as number
#'
#' @param x A string.
#' @param which An integer selecting which split strings is returned.
#' @return A split string parsed as number
#' @examples
#' split_slash("1/2/3", 1)
#' split_slash("1/2/3", 3)
#'
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
#'
check_pref_names <- function(df, pref_column) {
  logger <- log4r::logger()

  stopifnot(is.data.frame(df))

  if (!all(sort(df[[pref_column]]) == sort(pref_names))) {
    log4r::warn(
      logger,
      paste0(e, "Prefectures in the data.frame is not correct.")
    )

    return(false)
  }

  is_na <- df %>%
    purrr::map(is.na) %>%
    purrr::map_lgl(all) %>%
    colnames(df)[.]

  if (length(is_na) > 0) {
    warn(logger, paste0("There is na in data: ", paste0(is_na, collapse = ", ")))
  }

  return(true)
}
