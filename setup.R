# example: Rscript setup.R ubuntu 20.04
# then, args <-  c("ubuntu", "20.04")

install.packages("remotes")

args <- commandArgs(trailingOnly = TRUE)
cmds <- remotes::system_requirements(args[1], args[2])

for (cmd in cmds) {
  system(paste("sudo", cmd))
}

# install jre
system("sudo apt-get install -y default-jre")

# install pre-build dependencies
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

# install package dependencies
remotes::install_deps(dependencies = TRUE)
