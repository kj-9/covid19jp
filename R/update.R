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
