# covid19jp

## R package for Japanese covid-19 Datasets

This is R package provides ready to use Japanese covid-19 datasets.

- `japan_daily`: Daily naition-level data for Japanese covid-19 situation.
- `pref_daily`: Daily prefecture-level data for Japanese covid-19 situation.
- `pref_weekly`: Weekly prefecture-level data for Japanese covid-19 situation (contains some additional data like hospital capacity not appear in `pref_daily`).
- `pref`: Helper master data for Japanese prefectures.

These datasets originally from Japanese MHLW website. MHLW releases their covid-19 data in poor format which requires a lot of data cleaning before analyzing it. So I made this.

For `japan_daily` and `pref_daily`, Huge thanks to Kazuki OGIWARA's [repo](https://github.com/kaz-ogiwara/covid19). They did most of the data cleaning!

### For people not using R

CSV/JSON format files are also available under `data-raw/dist`. see also `Dataset detail` below.

### Note

- This repo is still under frequent development. data interfaces can be changed.
- This repo updates datasets daily, but your installed R package will not. please re-install this package (probably I'll add some R functions to update dataset without re-installation)
- Due to change of data source format, updating datasets may be delayed.
- I'm happy to see your feedback! Please create issues for that.

## Installation

Currently, this package is not on CRAN. Please install from this github repo.

```r
# Install the development version from GitHub
devtools::install_github("kj-9/covid19jp", ref = "master")
```

## Dataset detail

### `japan_daily`

csv: `data-raw/dist/jp_daily.csv`
json: `data-raw/dist/jp_daily.json`

#### Columns

| name        | description                    | description in Japanese        |
| :---------- | :----------------------------- | :----------------------------- |
| date        | Date in JST                    | 日本時間での日付               |
| tests       | Number of tests                | PCR 検査実施人数               |
| newCases    | Number of new cases            | 陽性者数                       |
| activeCases | Number of current active cases | 入院治療等を要する者の数       |
| severeCases | Number of current severe cases | 重症者数                       |
| recovered   | Number of recovered cases      | 退院又は療養解除となった者の数 |
| deaths      | Number of tests                | 死亡者数                       |
| rt          | Effective reproduction number  | 実効再生産数                   |

#### Data Source

- [prefectures.csv](https://github.com/kaz-ogiwara/covid19/blob/master/data/prefectures.csv) from [Toyo Keizai Online "Coronavirus Disease (COVID-19) Situation Report in Japan" by Kazuki OGIWARA](https://github.com/kaz-ogiwara/covid19)
- Originaly from Japanese MHLW website. See above link to github repo.

### `pref_daily`

csv: `data-raw/dist/jp_daily.csv`
json: `data-raw/dist/jp_daily.json`

#### Columns

| name        | description                    | description in Japanese        |
| :---------- | :----------------------------- | :----------------------------- |
| prefJP      | A prefecture name in Japanese  | 都道府県名(日本語)             |
| prefEN      | A prefecture name in English   | 都道府県名(英語)               |
| date        | Date in JST                    | 日本時間での日付               |
| tests       | Number of tests                | PCR 検査実施人数               |
| newCases    | Number of new cases            | 陽性者数                       |
| activeCases | Number of current active cases | 入院治療等を要する者の数       |
| severeCases | Number of current severe cases | 重症者数                       |
| recovered   | Number of recovered cases      | 退院又は療養解除となった者の数 |
| deaths      | Number of tests                | 死亡者数                       |
| rt          | Effective reproduction number  | 実効再生産数                   |

#### Data Source

- [Toyo Keizai Online "Coronavirus Disease (COVID-19) Situation Report in Japan" by Kazuki OGIWARA](https://github.com/kaz-ogiwara/covid19)
- Originaly from Japanese MHLW website. See above link to github repo.

### `pref_weekly`

Currently, only dataset after 2020-09-02 is available.

csv: `data-raw/dist/pref_daily.csv`
json: `data-raw/dist/pref_daily.json`

#### Columns

| name                        | description                                                                   | description in Japanese                        |
| :-------------------------- | :---------------------------------------------------------------------------- | :--------------------------------------------- |
| prefJP                      | Name of the prefecture in Japanese                                            | 都道府県名(日本語)                             |
| prefEN                      | Name of the prefecture in English                                             | 都道府県名(英語)                               |
| date                        | Date in JST                                                                   | 日本時間での日付                               |
| activeCases                 | Number of current active cases                                                | 入院治療等を要する者の数                       |
| hospitalizedCases           | Number of current hospitalized cases                                          | 入院者数（入院確定者数を含む）                 |
| hospitalizedCasesPhase      | Current altert phase level for hospitalized cases                             | 入院者現フェーズ                               |
| hospitalizedCasesMaxPhase   | Maximum alert phase level for hospitalized cases                              | 入院者最終フェーズ                             |
| hospitalizedCasesCap        | Current bed capacity for hospitalized cases                                   | 入院者確保病床数                               |
| hospitalizedCasesCapPlanned | Bed capacity for hospitalized cases planned for the maximum alert phase       | 最終フェーズにおける入院者即応病床（計画）数   |
| hospitalizedCasesUTE        | Current hospital (bed) utilization rate for hospitalized cases                | 確保病床数に対する入院者使用率                 |
| severeCases                 | Number of current severe cases                                                | 重症者数                                       |
| severeCasesPhase            | Current altert phase level for severe cases                                   | 重症者現フェーズ                               |
| severeCasesMaxPhase         | Maximum alert phase level for severe cases                                    | 重症者最終フェーズ                             |
| severeCasesCap              | Current bed capacity for severe cases                                         | 重症者確保病床数                               |
| severeCaseaCapPlanned       | Bed capacity for severe cases planned for the maximum alert phase             | 最終フェーズにおける重症者即応病床（計画）数   |
| severeCasesUTE              | Current hospital (bed) utilization rate for severe cases                      | 確保病床数に対する重症者使用率                 |
| atHotelCases                | Number of current cases staying at hotels (or other accommodation facilities) | 宿泊療養者数                                   |
| atHotelCasesPhase           | Current altert phase level for cases staying at hotels                        | 宿泊療養現フェーズ                             |
| atHotelCasesMaxPhase        | Maximum alert phase level for cases staying at hotels                         | 宿泊療養最終フェーズ                           |
| atHotelCasesCap             | Current room capacity for cases staying at hotels                             | 宿泊療養確保居室数                             |
| atHotelCasesCapPlanned      | Room capacity for cases staying at hotels planned for the maximum alert phase | 最終フェーズにおける宿泊療養施設居室（計画）数 |
| atHotelCasesUTE             | Current hotel (room) utilization rate for cases staying at hotels             | 確保居室数に対する宿泊療養者使用率             |
| atHomeCases                 | Number of current cases staying at home                                       | 自宅療養者数                                   |
| atWelfareFacilityCases      | Number of current cases staying at welfare facilities                         | 社会福祉施設等療養者数                         |
| unconfirmedCases            | Number of current unconfirmed cases                                           | 確認中の人数                                   |

#### Data Source

- Japanese MHLW website: https://www.mhlw.go.jp/stf/seisakunitsuite/newpage_00023.html
