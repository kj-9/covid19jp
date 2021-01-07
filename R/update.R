#' Update the covid19jp datasets
#' @param force A logical value. FALSE by default. if set to TRUE, install
#'   updates without prompt question
#' @description  Update the package datasets on the global environment with the
#'   most recent data on the development version.
#' @details As the CRAN version is being updated every one-two months, the
#'   development version of the package is being updated on a daily bases. This
#'   function enables to refresh the package dataset to the most up-to-date
#'   data. Changes will be available on the global environment.
#' @export update_data
#' @return No return value, called for updating covid19jp package datasets.
#' @examples
#' \donttest{
#' # update with a question prompt
#' update_data(force = FALSE)
#'
#' # update without a question prompt
#' update_data(force = TRUE)
#' }
#'
update_data <- function(force = FALSE) {
  hash_current <- readLines(system.file("DATA_HASH", package = "covid19jp"))
  hash_latest <- readLines("https://raw.githubusercontent.com/kj-9/covid19jp/master/inst/DATA_HASH")

  if (hash_current != hash_latest) {
    if (!force) {
      q <- tolower(readline("Updates are available. Want to update? n/Y: "))
    } else {
      q <- "y"
    }

    if (q == "y" | q == "yes") {
      tryCatch(
        expr = {
          devtools::install_github("kj-9/covid19jp",
            upgrade = "never",
            ref = "master"
          )

          # If library is loaded, auto onload and load the library to have the new data available
          if ("covid19jp" %in% names(utils::sessionInfo()$otherPkgs)) {
            detach(package:covid19jp, unload = TRUE)
            library(covid19jp)
          }
        },
        error = function(e) {
          message("Caught an error!")
          print(e)
        },
        warning = function(w) {
          message("Caught an warning!")
          print(w)
        }
      )
    } else {
      message("Stop update.")
      return()
    }
  } else {
    message("Your datasets are latest version.")
  }
}
