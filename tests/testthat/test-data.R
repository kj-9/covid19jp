library(pointblank)
library(purrr)

test_that("testing japan_daily", {

  schema <- col_schema(
    date = "Date",
    tests = "numeric",
    newCases = "numeric",
    activeCases = "numeric",
    severeCases = "numeric",
    recovered = "numeric",
    deaths = "numeric",
    rt = "numeric"
  )

  expect_rows_distinct(jp_daily)
  expect_col_schema_match(jp_daily, schema)
  expect_col_vals_not_null(jp_daily, vars(date))
  expect_col_vals_gte(jp_daily, keep(schema, ~ .x =="numeric") %>% names, 0)
})

test_that("testing pref", {
  expect_true(nrow(pref) == 47)
  expect_rows_distinct(pref)
  expect_col_schema_match(pref, col_schema(
    prefCode = "character",
    prefJP = "character",
    prefEN = "character",
    population = "numeric"
  ))
  expect_col_vals_not_null(pref, everything())
  expect_col_vals_regex(pref, prefCode, "[0-9]{2}")
  expect_col_vals_gt(pref, vars(population), 0)
})


test_that("testing pref_daily", {
  schema <- col_schema(
    prefCode = "character",
    prefJP = "character",
    prefEN = "character",
    date = "Date",
    tests = "numeric",
    newCases = "numeric",
    activeCases = "numeric",
    severeCases = "numeric",
    recovered = "numeric",
    deaths = "numeric",
    rt = "numeric"
  )
  expect_rows_distinct(pref_daily, vars(prefJP, date))
  expect_col_schema_match(pref_daily, schema)
  expect_col_vals_in_set(pref_daily, prefJP, pref$prefJP)
  expect_col_vals_not_null(pref_daily, vars(prefCode, prefJP, prefEN, date))
  expect_col_vals_gte(jp_daily, keep(schema, ~ .x =="numeric") %>% names, 0)
})


test_that("testing pref_weekly", {
  schema <- col_schema(
    prefCode = "character",
    prefJP = "character",
    prefEN = "character",
    date = "Date",
    activeCases = "numeric",
    hospitalizedCases = "numeric",
    hospitalizedCasesPhase = "numeric",
    hospitalizedCasesMaxPhase = "numeric",
    hospitalizedCasesCap = "numeric",
    hospitalizedCasesCapPlanned = "numeric",
    hospitalizedCasesUTE = "numeric",
    severeCases = "numeric",
    severeCasesPhase = "numeric",
    severeCasesMaxPhase = "numeric",
    severeCasesCap = "numeric",
    severeCaseaCapPlanned = "numeric",
    severeCasesUTE = "numeric",
    atHotelCases = "numeric",
    atHotelCasesPhase = "numeric",
    atHotelCasesMaxPhase = "numeric",
    atHotelCasesCap = "numeric",
    atHotelCasesCapPlanned = "numeric",
    atHotelCasesUTE = "numeric",
    atHomeCases = "numeric",
    atWelfareFacilityCases = "numeric",
    unconfirmedCases = "numeric"
  )
  expect_rows_distinct(pref_weekly, vars(prefJP, date))
  expect_col_schema_match(pref_weekly, schema)
  expect_col_vals_in_set(pref_weekly, prefJP, pref$prefJP)
  expect_col_vals_not_null(pref_weekly, vars(prefCode, prefJP, prefEN, date))
  expect_col_vals_gte(pref_weekly, keep(schema, ~ .x =="numeric") %>% names, 0)
})
