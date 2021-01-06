library(dplyr)
load("data/pref.rda") # load pref dataset
utils <- modules::use("data-raw/utils.R")

#' split a string by "/" and parse as number
#'
#' @param x A string.
#' @param which An integer selecting which split strings is returned.
#' @return A split string parsed as number
split_slash <- function(x, which) {
  purrr::map_dbl(x, ~ readr::parse_number(stringr::str_split(.x, "/", simplify = T)[which]))
}


get_list <- function() {
  url_base <- "https://www.mhlw.go.jp"
  url_home <- "/stf/seisakunitsuite/newpage_00023.html"

  utils$info("get url list of pdf files...")

  res_nodes <- xml2::read_html(paste0(url_base, url_home)) %>%
    rvest::html_nodes("div .m-grid__col1 ul li a")

  url_data <- rvest::html_attr(res_nodes, "href") %>%
    paste0(url_base, .)

  link_text <- res_nodes %>%
    rvest::html_text()

  out <- tibble(url = url_data, fileName = link_text) %>%
    mutate(
      date = fileName %>% stringi::stri_trans_nfkc() %>%
        stringr::str_extract("[0-9]{1,2}月[0-9]{1,2}日") %>% # need to change for CRAN
        paste0("2020-", .) %>% # This will break next year!
        readr::parse_date(format = "%Y-%m月%d日") %>%
        as.Date()
    ) %>%
    return(out)
}


extract_table <- function(url) {
  utils$info(paste0("extracting table from: ", url))

  df <- tabulizer::extract_tables(url, method = "lattice") %>%
    .[[1]] %>%
    as_tibble()

  return(df)
}


# 9月2日以降
clean <- function(df) {
  utils$info("cleaning data...")
  out <- df

  tryCatch(
    {
      out <-
        df %>%
        mutate(prefectureNameJP = stringr::str_extract(V1, "\\p{Han}+")) %>%
        filter(prefectureNameJP %in% pref$prefJP) %>%
        transmute(
          prefJP = prefectureNameJP,
          activeCases = readr::parse_number(V2),
          hospitalizedCases = readr::parse_number(V3),
          hospitalizedCasesPhase = split_slash(V4, 1),
          hospitalizedCasesMaxPhase = split_slash(V4, 2),
          hospitalizedCasesCap = readr::parse_number(V5),
          hospitalizedCasesCapPlanned = readr::parse_number(V7),
          hospitalizedCasesUTE = readr::parse_number(V6) * 0.01,
          severeCases = readr::parse_number(V8),
          severeCasesPhase = split_slash(V9, 1),
          severeCasesMaxPhase = split_slash(V9, 2),
          severeCasesCap = readr::parse_number(V10),
          severeCaseaCapPlanned = readr::parse_number(V12),
          severeCasesUTE = readr::parse_number(V11) * 0.01,
          atHotelCases = readr::parse_number(V13),
          atHotelCasesPhase = split_slash(V14, 1),
          atHotelCasesMaxPhase = split_slash(V14, 2),
          atHotelCasesCap = readr::parse_number(V15),
          atHotelCasesCapPlanned = readr::parse_number(V17),
          atHotelCasesUTE = readr::parse_number(V16) * 0.01,
          atHomeCases = readr::parse_number(V18),
          atWelfareFacilityCases = readr::parse_number(V19),
          unconfirmedCases = readr::parse_number(V20)
        )

      utils$info("cleaning succeeded.")
    },
    error = function(e) {
      utils$error(paste0(e, "returning raw data."))
    }
  )

  return(out)
}

udf_list <-
  tibble(
    url = c(
      "https://www.mhlw.go.jp/content/10900000/000712272.pdf",
      "https://www.mhlw.go.jp/content/10900000/000714776.pdf"
    ),
    fileName = c(
      "新型コロナウイルス感染症患者の療養状況等及び入院患者受入病床数等に関する調査結果（12月23日０時時点）",
      "新型コロナウイルス感染症患者の療養状況等及び入院患者受入病床数等に関する調査結果（2020年12月30日０時時点）"
    ),

    date = as.Date(c("2020-12-23", "2020-12-30"))
  )


ingest <- function() {
  utils$info("start job ingest::medical_treatment")

  # get list of pdf files
  url_list <- get_list() %>%
    # currently, this function only support data after 2020-09-02.
    filter(date >= "2020-09-02") %>%
    rbind(udf_list) %>%
    arrange(date)

  df <- url_list %>%
    mutate(data = purrr::map(url, ~ .x %>%
      extract_table() %>%
      clean())) %>%
    tidyr::unnest(cols = c(data)) %>%
    left_join(pref, by = "prefJP") %>%
    select(
      prefCode,
      prefJP,
      prefEN,
      everything(), -url, -fileName, -population
    ) %>%
    arrange(prefCode, date)


  utils$info("finish job ingest::medical_treatment")

  return(df)
}


pref_weekly <- ingest()
utils$write_files(pref_weekly, "data-raw/dist/")

usethis::use_data(pref_weekly, overwrite = TRUE)
