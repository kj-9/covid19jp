 <!-- badges: start -->

[![R build status](https://github.com/kj-9/covid19jp/workflows/R-CMD-check/badge.svg)](https://github.com/kj-9/covid19jp/actions)

  <!-- badges: end -->

# covid19jp : R package for Japanese Covid-19 Datasets

This package provides ready to use Japanese covid-19 datasets.

- `japan_daily`: Daily nation-level dataset of Japanese covid-19 situation.
- `pref_daily`: Daily prefecture-level dataset of Japanese covid-19 situation.
- `pref_weekly`: Weekly prefecture-level dataset of Japanese covid-19 situation (which contains some additional columns like hospital capacity not appear in `pref_daily`).
- `pref`: Master dataset for Japanese prefectures.

### Notes

- CSV/JSON format files are also available [here](https://github.com/kj-9/covid19jp/tree/master/data-raw/dist). See also `Dataset detail` below.

- Due to the data source format changes, updating datasets in development version might delay.

## Installation

```r
# From CRAN (may not be latest dataset)
instal.packages("covid19jp")

# Install the development version from GitHub
devtools::install_github("kj-9/covid19jp", ref = "master")
```

We update datasets in devolpment version daily. To get latest datasets, run `update_date`.

```r
# update your datasets
covid19jp::update_data()
```

## Dataset detail

### `japan_daily`

#### Columns

| name        | description                     | description in Japanese                |
| :---------- | :------------------------------ | :------------------------------------- |
| date        | Date in JST                     | 日本時間での日付                       |
| tests       | Number of tests                 | PCR 検査実施人数                       |
| newCases    | Number of new cases             | 陽性者数                               |
| activeCases | Number of current active cases  | 入院治療等を要する者の数               |
| severeCases | Number of current severe cases  | 重症者数                               |
| recovered   | Total number of recovered cases | 退院又は療養解除となった者の数（累積） |
| deaths      | Total number of deaths          | 死亡者数（累積）                       |
| rt          | Effective reproduction number   | 実効再生産数                           |

#### Data Source

- [Toyo Keizai Online "Coronavirus Disease (COVID-19) Situation Report in Japan" by Kazuki OGIWARA](https://github.com/kaz-ogiwara/covid19) (Originally from Japanese MHLW website. See above link to github repo.)

### `pref_daily`

#### Columns

| name        | description                     | description in Japanese                |
| :---------- | :------------------------------ | :------------------------------------- |
| prefCode    | Prefecture code                 | 都道府県番号                           |
| prefJP      | Prefecture name in Japanese     | 都道府県名(日本語)                     |
| prefEN      | Prefecture name in English      | 都道府県名(英語)                       |
| date        | Date in JST                     | 日本時間での日付                       |
| tests       | Total number of tests           | PCR 検査実施人数 （累積）              |
| newCases    | Total number of new cases       | 陽性者数（累積）                       |
| activeCases | Number of current active cases  | 入院治療等を要する者の数               |
| severeCases | Number of current severe cases  | 重症者数                               |
| recovered   | Total number of recovered cases | 退院又は療養解除となった者の数（累積） |
| deaths      | Total number of deaths          | 死亡者数（累積）                       |
| rt          | Effective reproduction number   | 実効再生産数                           |

#### Data Source

- [Toyo Keizai Online "Coronavirus Disease (COVID-19) Situation Report in Japan" by Kazuki OGIWARA](https://github.com/kaz-ogiwara/covid19) (Originally from Japanese MHLW website. See above link to github repo.)

### `pref_weekly`

Currently, only dataset after 2020-09-02 is available.

#### Columns

| name                        | description                                                                   | description in Japanese                        |
| :-------------------------- | :---------------------------------------------------------------------------- | :--------------------------------------------- |
| prefCode                    | prefecture code                                                               | 都道府県番号                                   |
| prefJP                      | Name of the prefecture in Japanese                                            | 都道府県名(日本語)                             |
| prefEN                      | Name of the prefecture in English                                             | 都道府県名(英語)                               |
| date                        | Date in JST                                                                   | 日本時間での日付                               |
| activeCases                 | Number of current active cases                                                | 入院治療等を要する者の数                       |
| hospitalizedCases           | Number of current hospitalized cases                                          | 入院者数（入院確定者数を含む）                 |
| hospitalizedCasesPhase      | Current alert phase level for hospitalized cases                              | 入院者現フェーズ                               |
| hospitalizedCasesMaxPhase   | Maximum alert phase level for hospitalized cases                              | 入院者最終フェーズ                             |
| hospitalizedCasesCap        | Current bed capacity for hospitalized cases                                   | 入院者確保病床数                               |
| hospitalizedCasesCapPlanned | Bed capacity for hospitalized cases planned for the maximum alert phase       | 最終フェーズにおける入院者即応病床（計画）数   |
| hospitalizedCasesUTE        | Current hospital (bed) utilization rate for hospitalized cases                | 確保病床数に対する入院者使用率                 |
| severeCases                 | Number of current severe cases                                                | 重症者数                                       |
| severeCasesPhase            | Current alert phase level for severe cases                                    | 重症者現フェーズ                               |
| severeCasesMaxPhase         | Maximum alert phase level for severe cases                                    | 重症者最終フェーズ                             |
| severeCasesCap              | Current bed capacity for severe cases                                         | 重症者確保病床数                               |
| severeCaseaCapPlanned       | Bed capacity for severe cases planned for the maximum alert phase             | 最終フェーズにおける重症者即応病床（計画）数   |
| severeCasesUTE              | Current hospital (bed) utilization rate for severe cases                      | 確保病床数に対する重症者使用率                 |
| atHotelCases                | Number of current cases staying at hotels (or other accommodation facilities) | 宿泊療養者数                                   |
| atHotelCasesPhase           | Current alert phase level for cases staying at hotels                         | 宿泊療養現フェーズ                             |
| atHotelCasesMaxPhase        | Maximum alert phase level for cases staying at hotels                         | 宿泊療養最終フェーズ                           |
| atHotelCasesCap             | Current room capacity for cases staying at hotels                             | 宿泊療養確保居室数                             |
| atHotelCasesCapPlanned      | Room capacity for cases staying at hotels planned for the maximum alert phase | 最終フェーズにおける宿泊療養施設居室（計画）数 |
| atHotelCasesUTE             | Current hotel (room) utilization rate for cases staying at hotels             | 確保居室数に対する宿泊療養者使用率             |
| atHomeCases                 | Number of current cases staying at home                                       | 自宅療養者数                                   |
| atWelfareFacilityCases      | Number of current cases staying at welfare facilities                         | 社会福祉施設等療養者数                         |
| unconfirmedCases            | Number of current unconfirmed cases                                           | 確認中の人数                                   |

#### Data Source

- Japanese MHLW website: https://www.mhlw.go.jp/stf/seisakunitsuite/newpage_00023.html

### `pref`

#### Columns

| name       | description                              | description in Japanese |
| :--------- | :--------------------------------------- | :---------------------- |
| prefCode   | Prefecture code                          | 都道府県番号            |
| prefJP     | Prefecture name in Japanese              | 都道府県名(日本語)      |
| prefEN     | Prefecture name in English               | 都道府県名(英語)        |
| population | Population estimate in thousands in 2018 | 2018 年推計人口(千人)   |

#### Data Source

- Statistics Bureau of Japan (xlsx file): https://www.stat.go.jp/data/nihon/zuhyou/n200200200.xlsx

## Reference

The function `update_data` is heavily referred to [coronavirus](https://github.com/RamiKrispin/coronavirus) package. Thanks!
