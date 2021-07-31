box::use(
  dplyr[...],
  purrr,
  readr,
  rvest,
  stringr,
  stringi,
  tidyr,
  xml2,
  pointblank,
  tabulizer,
  ./utils
)
load("data/pref.rda") # load pref dataset

#' split a string by "/" and parse as number
#'
#' @param x A string.
#' @param which An integer selecting which split strings is returned.
#' @return A split string parsed as number
split_slash <- function(x, which) {
  purrr$map_dbl(x, ~ readr$parse_number(stringr$str_split(.x, "/", simplify = T)[which]))
}


get_list <- function() {
  url_base <- "https://www.mhlw.go.jp"
  url_home <- "/stf/seisakunitsuite/newpage_00023.html"

  utils$info("get url list of pdf files...")

  res_nodes <- xml2$read_html(paste0(url_base, url_home)) %>%
    rvest$html_nodes("div .m-grid__col1 ul li")


  url_chr <- res_nodes %>%
    purrr$map(rvest$html_nodes, "a") %>%
    purrr$map(rvest$html_attr, "href") %>% # to preserve zero length character
    purrr$map_chr(~ ifelse(length(.x) == 0, NA, paste0(url_base, .x)))

  link_chr <- res_nodes %>%
    purrr$map_chr(rvest$html_text)

  stopifnot(length(url_chr) == length(link_chr))

  url_list <- tibble(url = url_chr, file_name = link_chr) %>%
    mutate(
      date = file_name %>% stringi$stri_trans_nfkc() %>%
        stringr$str_extract("[0-9]{4}年[0-9]{1,2}月[0-9]{1,2}日") %>% # need to change for CRAN
        readr$parse_date(format = "%Y年%m月%d日") %>%
        as.Date()
    )

  # after 2020-12-23, format of website changed.
  # need to further cleaning...
  pos <- which(url_list$date == "2020-12-16") - 1
  stopifnot(length(pos) == 1)

  url_list_after_20201223 <- url_list[seq_len(pos), ] %>%
    mutate(
      file_name_cp = file_name,
      file_name = lag(file_name, 1),
      date = lag(date, 1)
    ) %>%
    filter(stringr$str_detect(file_name_cp, "PDF形式")) %>%
    select(-file_name_cp)

  out <-
    rbind(url_list_after_20201223, url_list[-seq_len(pos), ]) %>%
    # currently, this function only support data after 2020-09-02.
    filter(date >= "2020-09-02") %>%
    arrange(date)

  pointblank$expect_rows_distinct(out, vars(url, file_name, date))

  return(out)
}


extract_table <- function(url, date) {
  utils$info(paste0("extracting table from: ", url))


  if (date == "2021-05-26") {
    df <- tabulizer$extract_tables(url,
                                   page = 1,
                                   area = list(c(
                                     71.31304, 172.56874, 642.47763, 1016.88051
                                   )))

  } else {
    df <- tabulizer$extract_tables(url, method = "lattice")
  }

  out <- df %>%
    .[[1]] %>%
    as_tibble() %>%
    confirm_columns(1) %>%
    confirm_rows()

  return(out)
}



confirm_columns <- function(df, date) {
  column_lst <-
    list(
      V1 = "prefectureNameJP",
      V2 = "activeCases",
      V3 = "hospitalizedCases",
      V4 = "hospitalizedCasesPhases",
      V5 = "hospitalizedCasesCap",
      V7 = "hospitalizedCasesCapPlanned",
      V8 = "severeCases",
      V9 = "severeCasesPhases",
      V10 = "severeCasesCap",
      V12 = "severeCaseaCapPlanned",
      V13 = "atHotelCases",
      V14 = "atHotelCasesPhases",
      V15 = "atHotelCasesCap",
      V17 = "atHotelCasesCapPlanned",
      V18 = "atHomeCases",
      V19 = "atWelfareFacilityCases",
      V20 = "unconfirmedCases"
    )

  df <- df[names(column_lst)]

  colnames(df) <- column_lst[colnames(df)]
  return(df)
}

confirm_rows <- function(df) {
  df %>%
    mutate(across(everything(), stringr$str_remove, "注[0-9]+")) %>%
    mutate(prefectureNameJP = stringr$str_extract(prefectureNameJP, "\\p{Han}+")) %>%
    filter(prefectureNameJP %in% pref$prefJP)
}



# 9月2日以降
clean <- function(df) {
  utils$info("cleaning data...")
  out <- df


  tryCatch({
    out <-
      df %>%
      transmute(
        prefJP = prefectureNameJP,
        activeCases = readr$parse_number(activeCases),
        hospitalizedCases = readr$parse_number(hospitalizedCases),
        hospitalizedCasesPhase = split_slash(hospitalizedCasesPhases, 1),
        hospitalizedCasesMaxPhase = split_slash(hospitalizedCasesPhases, 2),
        hospitalizedCasesCap = readr$parse_number(hospitalizedCasesCap),
        hospitalizedCasesCapPlanned = readr$parse_number(hospitalizedCasesCapPlanned),
        hospitalizedCasesUTE = hospitalizedCases / hospitalizedCasesCap,
        severeCases = readr$parse_number(severeCases),
        severeCasesPhase = split_slash(severeCasesPhases, 1),
        severeCasesMaxPhase = split_slash(severeCasesPhases, 2),
        severeCasesCap = readr$parse_number(severeCasesCap),
        severeCaseaCapPlanned = readr$parse_number(severeCaseaCapPlanned),
        severeCasesUTE = severeCases / severeCasesCap,
        atHotelCases = readr$parse_number(atHotelCases),
        atHotelCasesPhase = split_slash(atHotelCasesPhases, 1),
        atHotelCasesMaxPhase = split_slash(atHotelCasesPhases, 2),
        atHotelCasesCap = readr$parse_number(atHotelCasesCap),
        atHotelCasesCapPlanned = readr$parse_number(atHotelCasesCapPlanned),
        atHotelCasesUTE = atHotelCases / atHotelCasesCap,
        atHomeCases = readr$parse_number(atHomeCases),
        atWelfareFacilityCases = readr$parse_number(atWelfareFacilityCases),
        unconfirmedCases = readr$parse_number(unconfirmedCases)
      )

    utils$info("cleaning succeeded.")
  },
  error = function(e) {
    utils$error(paste0(e, "returning raw data."))
  })

  return(out)
}



#' @export
ingest <- function() {
  utils$info("start job ingest::medical_treatment")

  # get list of pdf files
  url_list <- get_list()

  df <- url_list %>%
    mutate(data = purrr$map2(url, date,
                            ~ extract_table(.x, .y) %>%
                              clean())) %>%
    tidyr$unnest(cols = c(data)) %>%
    left_join(pref, by = "prefJP") %>%
    select(prefCode,
           prefJP,
           prefEN,
           everything(),-url,-file_name,-population) %>%
    arrange(prefCode, date)


  utils$info("finish job ingest::medical_treatment")

  return(df)
}
