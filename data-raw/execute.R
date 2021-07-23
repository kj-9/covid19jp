# set box.path option
options(box.path = getwd())
box::use(`data-raw`/jp_daily,
         `data-raw`/pref_daily,
         `data-raw`/pref_weekly,
         `data-raw`/utils[write_files],
         purrr[map, walk2],
         usethis[use_data])

jp_daily <- jp_daily$ingest()
pref_daily <- pref_daily$ingest()
pref_weekly <- pref_weekly$ingest()

dfs <- list("jp_daily" = jp_daily, "pref_daily" = pref_daily, "pref_weekly" = pref_weekly)

walk2(dfs, names(dfs), ~ write_files(.x, paste0("data-raw/dist/", .y)))


use_data(jp_daily, compress = "xz", overwrite = TRUE)
use_data(pref_daily, compress = "xz", overwrite = TRUE)
use_data(pref_weekly, compress = "xz", overwrite = TRUE)
