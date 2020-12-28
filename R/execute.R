get_list <- function() {
  url_base <- "https://www.mhlw.go.jp"
  url_home <- "/stf/seisakunitsuite/newpage_00023.html"

  res_nodes <- xml2::read_html(paste0(url_base, url_home)) %>%
    rvest::html_nodes("div .m-grid__col1 ul li a")

  url_data <- rvest::html_attr(res_nodes, "href") %>%
    paste0(url_base, .)

  link_text <- res_nodes %>%
    rvest::html_text()

  out <- dplyr::tibble(url = url_data, fileName = link_text)

  return(out)

}

# 9月2日以降
ingest <- function(url) {
  logger <- log4r::logger()

  info(logger, paste0("start ingesting url: ", url))

  raw_data <- tabulizer::extract_tables(url, method = "lattice")

  df <- dplyr::as_tibble(raw_data[[1]])

  tryCatch({
    out <-
      df %>%
      dplyr::mutate(#都道府県名
        prefectureNameJP = str_extract(V1, "\\p{Han}+")) %>%
      dplyr::filter(prefectureNameJP %in% util$pref_names) %>%
      dplyr::transmute(
        #都道府県名
        prefectureNameJP = prefectureNameJP,
        #PCR検査陽性者数（退院者等除く）
        testedPositive = readr::parse_number(V2),
        #入院者数（入院確定者数を含む）
        hospitalized = readr::parse_number(V3),
        #入院者現フェーズ
        bedCurrentPhase = split_slash(V4, 1),
        #入院者最終フェーズ
        bedFinalPhase = split_slash(V4, 2),
        #入院者確保病床数
        bedCapacity = readr::parse_number(V5),
        #確保病床数に対する入院者使用率
        bedUtilizationRate = readr::parse_number(V6) * 0.01,
        #最終フェーズにおける入院者即応病床（計画）数
        plannedBedCapacity = readr::parse_number(V7),
        #重症者数
        severeCase = readr::parse_number(V8),
        #重症者現フェーズ
        severeCaseBedCurrentPhase = split_slash(V9, 1),
        #重症者最終フェーズ
        severeCaseBedFinalPhase = split_slash(V9, 2),
        #重症者確保病床数
        severeCaseBedCapacity = readr::parse_number(V10),
        #確保病床数に対する重症者使用率
        severeCaseBedUtilizationRate = readr::parse_number(V11) * 0.01,
        #最終フェーズにおける重症者即応病床（計画）数
        plannedSevereCaseBedCapacity = readr::parse_number(V12),
        #宿泊療養者数
        accomondated = readr::parse_number(V13),
        #宿泊療養現フェーズ
        accomondationCurrentPhase = split_slash(V14, 1),
        #宿泊療養最終フェーズ
        accomondationFinalPhase = split_slash(V14, 2),
        #宿泊療養確保居室数
        accomondationRoomCapacity = readr::parse_number(V15),
        #確保居室数に対する宿泊療養者使用率
        accomondationRoomUtilizationRate = readr::parse_number(V16) * 0.01,
        #最終フェーズにおける宿泊療養施設居室（計画）数
        plannedaccomondationRoomCapacity = readr::parse_number(V17),
        #自宅療養者数
        atHome = readr::parse_number(V18),
        #社会福祉施設等療養者数
        atWelfareFacility =  readr::parse_number(V19),
        #確認中の人数
        unconfirmed = readr::parse_number(V20)
      )
    check_pref_names(out, "prefectureNameJP")

  },
  error = function(e) {
    error(logger,
          paste0(e, " return raw data."))
    out <- raw_data
  })

  return(out)
}

execute <- function() {

  logger <- log4r::logger()

  info(logger, "start job ingest::medical_treatment")

  # get list of pdf files
  info(logger, "get url list of pdf files..")
  url_list <- get_list()

  # ingest
  info(logger, "ingest pdf files...")
  url_list <-
    url_list %>%
    # add updateDate
    dplyr::mutate(
      updateDate = fileName %>%  stringi::stri_trans_nfkc() %>%
        stringr::str_extract("[0-9]{1,2}月[0-9]{1,2}日") %>%
        stringr::str_replace("月", replacement = "-") %>%
        stringr::str_remove("日") %>%
        paste0("2020-", .) %>%
        lubridate::ymd()
    ) %>%
    # currently, ingest function only support data after 2020-09-02.
    dplyr::filter(updateDate >= "2020-09-02") %>%
    dplyr::arrange(updateDate)

  df <- url_list %>%
    dplyr::mutate(data = map(url, ingest$ingest))

  out <- df %>%
    tidyr::unnest(cols = c(data))


  readr::write_csv(out, "data/source/japan_prefecture_medical_treatment/file.csv")
  jsonlite::write_json(out, 'data/source/japan_prefecture_medical_treatment/file.json')


  info(logger, "finish job ingest::medical_treatment")

}

