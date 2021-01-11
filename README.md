
<!-- README.md is generated from README.Rmd. Please edit that file -->

# covid19jp : R package for Japanese Covid-19 Datasets

<!-- badges: start -->

[![R build
status](https://github.com/kj-9/covid19jp/workflows/R-CMD-check/badge.svg)](https://github.com/kj-9/covid19jp/actions)

<!-- badges: end -->

This package provides ready to use Japanese covid-19 datasets.

  - `japan_daily`: Daily nation-level dataset of Japanese covid-19
    situation.
  - `pref_daily`: Daily prefecture-level dataset of Japanese covid-19
    situation.
  - `pref_weekly`: Weekly prefecture-level dataset of Japanese covid-19
    situation (which contains some additional columns like hospital
    capacity not appear in `pref_daily`).
  - `pref`: Master dataset for Japanese prefectures.

### Notes

  - CSV/JSON format files are also available
    [here](https://github.com/kj-9/covid19jp/tree/master/data-raw/dist).
    See also `Dataset detail` below.

  - Due to the data source format changes, updating datasets in
    development version might delay.

## Installation

``` r
# Currently, CRAN build is failing. Please install from github repo.
# Install the development version from GitHub
devtools::install_github("kj-9/covid19jp", ref = "master", upgrade = "never")
```

We update datasets in devolpment version daily. To get latest datasets,
run `update_date`.

``` r
# update your datasets
covid19jp::update_data()
```

## Dataset detail

### `japan_daily`

#### Columns

| name        | description                     | description in Japanese |
| :---------- | :------------------------------ | :---------------------- |
| date        | Date in JST                     | 日本時間での日付                |
| tests       | Number of tests                 | PCR 検査実施人数              |
| newCases    | Number of new cases             | 陽性者数                    |
| activeCases | Number of current active cases  | 入院治療等を要する者の数            |
| severeCases | Number of current severe cases  | 重症者数                    |
| recovered   | Total number of recovered cases | 退院又は療養解除となった者の数（累積）     |
| deaths      | Total number of deaths          | 死亡者数（累積）                |
| rt          | Effective reproduction number   | 実効再生産数                  |

#### Data Source

  - [Toyo Keizai Online “Coronavirus Disease (COVID-19) Situation Report
    in Japan” by Kazuki OGIWARA](https://github.com/kaz-ogiwara/covid19)
    (Originally from Japanese MHLW website. See above link to github
    repo.)

### `pref_daily`

#### Columns

| name        | description                     | description in Japanese |
| :---------- | :------------------------------ | :---------------------- |
| prefCode    | Prefecture code                 | 都道府県番号                  |
| prefJP      | Prefecture name in Japanese     | 都道府県名(日本語)              |
| prefEN      | Prefecture name in English      | 都道府県名(英語)               |
| date        | Date in JST                     | 日本時間での日付                |
| tests       | Total number of tests           | PCR 検査実施人数 （累積）         |
| newCases    | Total number of new cases       | 陽性者数（累積）                |
| activeCases | Number of current active cases  | 入院治療等を要する者の数            |
| severeCases | Number of current severe cases  | 重症者数                    |
| recovered   | Total number of recovered cases | 退院又は療養解除となった者の数（累積）     |
| deaths      | Total number of deaths          | 死亡者数（累積）                |
| rt          | Effective reproduction number   | 実効再生産数                  |

#### Data Source

  - [Toyo Keizai Online “Coronavirus Disease (COVID-19) Situation Report
    in Japan” by Kazuki OGIWARA](https://github.com/kaz-ogiwara/covid19)
    (Originally from Japanese MHLW website. See above link to github
    repo.)

### `pref_weekly`

Currently, only dataset after 2020-09-02 is available.

#### Columns

| name                        | description                                                                   | description in Japanese |
| :-------------------------- | :---------------------------------------------------------------------------- | :---------------------- |
| prefCode                    | prefecture code                                                               | 都道府県番号                  |
| prefJP                      | Name of the prefecture in Japanese                                            | 都道府県名(日本語)              |
| prefEN                      | Name of the prefecture in English                                             | 都道府県名(英語)               |
| date                        | Date in JST                                                                   | 日本時間での日付                |
| activeCases                 | Number of current active cases                                                | 入院治療等を要する者の数            |
| hospitalizedCases           | Number of current hospitalized cases                                          | 入院者数（入院確定者数を含む）         |
| hospitalizedCasesPhase      | Current alert phase level for hospitalized cases                              | 入院者現フェーズ                |
| hospitalizedCasesMaxPhase   | Maximum alert phase level for hospitalized cases                              | 入院者最終フェーズ               |
| hospitalizedCasesCap        | Current bed capacity for hospitalized cases                                   | 入院者確保病床数                |
| hospitalizedCasesCapPlanned | Bed capacity for hospitalized cases planned for the maximum alert phase       | 最終フェーズにおける入院者即応病床（計画）数  |
| hospitalizedCasesUTE        | Current hospital (bed) utilization rate for hospitalized cases                | 確保病床数に対する入院者使用率         |
| severeCases                 | Number of current severe cases                                                | 重症者数                    |
| severeCasesPhase            | Current alert phase level for severe cases                                    | 重症者現フェーズ                |
| severeCasesMaxPhase         | Maximum alert phase level for severe cases                                    | 重症者最終フェーズ               |
| severeCasesCap              | Current bed capacity for severe cases                                         | 重症者確保病床数                |
| severeCaseaCapPlanned       | Bed capacity for severe cases planned for the maximum alert phase             | 最終フェーズにおける重症者即応病床（計画）数  |
| severeCasesUTE              | Current hospital (bed) utilization rate for severe cases                      | 確保病床数に対する重症者使用率         |
| atHotelCases                | Number of current cases staying at hotels (or other accommodation facilities) | 宿泊療養者数                  |
| atHotelCasesPhase           | Current alert phase level for cases staying at hotels                         | 宿泊療養現フェーズ               |
| atHotelCasesMaxPhase        | Maximum alert phase level for cases staying at hotels                         | 宿泊療養最終フェーズ              |
| atHotelCasesCap             | Current room capacity for cases staying at hotels                             | 宿泊療養確保居室数               |
| atHotelCasesCapPlanned      | Room capacity for cases staying at hotels planned for the maximum alert phase | 最終フェーズにおける宿泊療養施設居室（計画）数 |
| atHotelCasesUTE             | Current hotel (room) utilization rate for cases staying at hotels             | 確保居室数に対する宿泊療養者使用率       |
| atHomeCases                 | Number of current cases staying at home                                       | 自宅療養者数                  |
| atWelfareFacilityCases      | Number of current cases staying at welfare facilities                         | 社会福祉施設等療養者数             |
| unconfirmedCases            | Number of current unconfirmed cases                                           | 確認中の人数                  |

#### Data Source

  - Japanese MHLW website:
    <https://www.mhlw.go.jp/stf/seisakunitsuite/newpage_00023.html>

### `pref`

<!--html_preserve-->

<style>@import url("https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap");
html {
  font-family: 'IBM Plex Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#pb_information .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 130%;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#pb_information .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#pb_information .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#pb_information .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#pb_information .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pb_information .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#pb_information .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#pb_information .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#pb_information .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#pb_information .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#pb_information .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#pb_information .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#pb_information .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#pb_information .gt_from_md > :first-child {
  margin-top: 0;
}

#pb_information .gt_from_md > :last-child {
  margin-bottom: 0;
}

#pb_information .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#pb_information .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#pb_information .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pb_information .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#pb_information .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pb_information .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#pb_information .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#pb_information .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pb_information .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#pb_information .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#pb_information .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#pb_information .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#pb_information .gt_left {
  text-align: left;
}

#pb_information .gt_center {
  text-align: center;
}

#pb_information .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#pb_information .gt_font_normal {
  font-weight: normal;
}

#pb_information .gt_font_bold {
  font-weight: bold;
}

#pb_information .gt_font_italic {
  font-style: italic;
}

#pb_information .gt_super {
  font-size: 65%;
}

#pb_information .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}

#pb_information {
  -webkit-font-smoothing: antialiased;
  letter-spacing: .15px;
}

#pb_information a {
  color: #375F84;
  text-decoration: none;
}

#pb_information a:hover {
  color: #375F84;
  text-decoration: underline;
}

#pb_information p {
  overflow: visible;
  margin-top: 2px;
  margin-left: 0;
  margin-right: 0;
  margin-bottom: 5px;
}

#pb_information ul {
  list-style-type: square;
  padding-left: 25px;
  margin-top: -4px;
  margin-bottom: 6px;
}

#pb_information li {
  text-indent: -1px;
}

#pb_information h4 {
  font-weight: 500;
  color: #444444;
}

#pb_information code {
  font-family: 'IBM Plex Mono', monospace, courier;
  font-size: 90%;
  font-weight: 500;
  color: #666666;
  background-color: transparent;
  padding: 0;
}

#pb_information .pb_date {
  text-decoration-style: solid;
  text-decoration-color: #9933CC;
  text-decoration-line: underline;
  text-underline-position: under;
  font-variant-numeric: tabular-nums;
  margin-right: 4px;
}

#pb_information .pb_label {
  border: solid 1px;
  border-color: inherit;
  padding: 0px 3px 0px 3px;
}

#pb_information .pb_label_rounded {
  border: solid 1px;
  border-color: inherit;
  border-radius: 8px;
  padding: 0px 8px 0px 8px;
}

#pb_information .pb_sub_label {
  font-size: smaller;
  color: #777777;
}

#pb_information .pb_col_type {
  font-size: 75%;
}

#pb_information .gt_sourcenote {
  height: 35px;
  font-size: 60%;
  padding: 0;
}

#pb_information .gt_group_heading {
  text-ident: -3px;
}
</style>

<div id="pb_information" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">

<table class="gt_table" style="table-layout: fixed;; width: 0px">

<colgroup>

<col style="width:875px;"/>

</colgroup>

<thead class="gt_header">

<tr>

<th colspan="1" class="gt_heading gt_title gt_font_normal" style="color: #444444; font-size: 28px; text-align: left; font-weight: 500;">

Pointblank Information

</th>

</tr>

<tr>

<th colspan="1" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style="font-size: 12px; text-align: left;">

<span style="text-decoration-style:solid;text-decoration-color:#ADD8E6;text-decoration-line:underline;text-underline-position:under;color:#333333;font-variant-numeric:tabular-nums;padding-left:4px;margin-right:5px;padding-right:2px;">\[2021-01-11|13:00:09\]</span>

</p>

<div style="height:25px;margin-top:10px;">

<span style="background-color:#F1D35A;color:#222222;padding:0.5em 0.5em;position:inherit;text-transform:uppercase;margin:5px 0px 5px 5px;font-weight:bold;border:solid 1px #F1D35A;padding:2px 15px 2px 15px;font-size:smaller;">tibble</span>
<span style="background-color:none;color:#222222;padding:0.5em 0.5em;position:inherit;margin:5px 10px 5px -4px;font-weight:bold;border:solid 1px #F1D35A;padding:2px 15px 2px 15px;font-size:smaller;">covid19jp::pref</span><span style="background-color:#eecbff;color:#333333;padding:0.5em 0.5em;position:inherit;text-transform:uppercase;margin:5px 0px 5px 5px;font-weight:bold;border:solid 1px #eecbff;padding:2px 15px 2px 15px;font-size:smaller;">Rows</span>
<span style="background-color:none;color:#333333;padding:0.5em 0.5em;position:inherit;margin:5px 0px 5px -4px;font-weight:bold;border:solid 1px #eecbff;padding:2px 15px 2px 15px;font-size:smaller;">47</span>
<span style="background-color:#BDE7B4;color:#333333;padding:0.5em 0.5em;position:inherit;text-transform:uppercase;margin:5px 0px 5px 1px;font-weight:bold;border:solid 1px #BDE7B4;padding:2px 15px 2px 15px;font-size:smaller;">Columns</span>
<span style="background-color:none;color:#333333;padding:0.5em 0.5em;position:inherit;margin:5px 0px 5px -4px;font-weight:bold;border:solid 1px #BDE7B4;padding:2px 15px 2px 15px;font-size:smaller;">4</span>

</div>

</th>

</tr>

</thead>

<tbody class="gt_table_body">

<tr class="gt_group_heading_row">

<td colspan="1" class="gt_group_heading" style="color: #444444; font-weight: 500; text-transform: uppercase; background-color: #FCFCFC; border-bottom-width: 1; border-bottom-style: solid; border-bottom-color: #EFEFEF;">

Table

</td>

</tr>

<tr>

<td class="gt_row gt_left" style="color: #666666; font-size: smaller; border-top-width: 1; border-top-style: solid; border-top-color: #EFEFEF;">

<div class="gt_from_md">

<h4 style="margin-bottom:5px;">

</h4>

<p>

Master dataset for Japanese prefectures.

</p>

</div>

</td>

</tr>

<tr>

<td class="gt_row gt_left" style="color: #666666; font-size: smaller; border-top-width: 1; border-top-style: solid; border-top-color: #EFEFEF;">

<div class="gt_from_md">

<h4 style="margin-bottom:5px;">

SOURCE

</h4>

<p>

Statistics Bureau of Japan
(<a href="https://www.stat.go.jp/data/nihon/zuhyou/n200200200.xlsx">xlsx
file</a>).

</p>

</div>

</td>

</tr>

<tr class="gt_group_heading_row">

<td colspan="1" class="gt_group_heading" style="color: #444444; font-weight: 500; text-transform: uppercase; background-color: #FCFCFC; border-bottom-width: 1; border-bottom-style: solid; border-bottom-color: #EFEFEF;">

Columns

</td>

</tr>

<tr>

<td class="gt_row gt_left" style="color: #666666; font-size: smaller; border-top-width: 1; border-top-style: solid; border-top-color: #EFEFEF;">

<div class="gt_from_md">

<p>

<code style="margin-bottom:5px;color:#555555;font-weight:500;line-height:2em;border:solid 1px #499FFE;padding:2px 8px 3px 8px;background-color:#FAFAFA;">prefCode</code>  <code class="pb_col_type">character</code>

</p>

<p>

<strong class="pb_sub_label"><span class="pb_label">EN</span></strong>
Prefecture code

</p>

<p>

<strong class="pb_sub_label"><span class="pb_label">JP</span></strong>
都道府県番号

</p>

</div>

</td>

</tr>

<tr>

<td class="gt_row gt_left" style="color: #666666; font-size: smaller; border-top-width: 1; border-top-style: solid; border-top-color: #EFEFEF;">

<div class="gt_from_md">

<p>

<code style="margin-bottom:5px;color:#555555;font-weight:500;line-height:2em;border:solid 1px #499FFE;padding:2px 8px 3px 8px;background-color:#FAFAFA;">prefJP</code>  <code class="pb_col_type">character</code>

</p>

<p>

<strong class="pb_sub_label"><span class="pb_label">EN</span></strong>
Prefecture name in Japanese

</p>

<p>

<strong class="pb_sub_label"><span class="pb_label">JP</span></strong>
都道府県名(日本語)

</p>

</div>

</td>

</tr>

<tr>

<td class="gt_row gt_left" style="color: #666666; font-size: smaller; border-top-width: 1; border-top-style: solid; border-top-color: #EFEFEF;">

<div class="gt_from_md">

<p>

<code style="margin-bottom:5px;color:#555555;font-weight:500;line-height:2em;border:solid 1px #499FFE;padding:2px 8px 3px 8px;background-color:#FAFAFA;">prefEN</code>  <code class="pb_col_type">character</code>

</p>

<p>

<strong class="pb_sub_label"><span class="pb_label">EN</span></strong>
Prefecture name in English

</p>

<p>

<strong class="pb_sub_label"><span class="pb_label">JP</span></strong>
都道府県名(英語)

</p>

</div>

</td>

</tr>

<tr>

<td class="gt_row gt_left" style="color: #666666; font-size: smaller; border-top-width: 1; border-top-style: solid; border-top-color: #EFEFEF;">

<div class="gt_from_md">

<p>

<code style="margin-bottom:5px;color:#555555;font-weight:500;line-height:2em;border:solid 1px #499FFE;padding:2px 8px 3px 8px;background-color:#FAFAFA;">population</code>  <code class="pb_col_type">numeric</code>

</p>

<p>

<strong class="pb_sub_label"><span class="pb_label">EN</span></strong>
Population estimate in thousands in 2018

</p>

<p>

<strong class="pb_sub_label"><span class="pb_label">JP</span></strong>
2018 年推計人口(千人)

</p>

</div>

</td>

</tr>

</tbody>

<tfoot class="gt_sourcenotes">

<tr>

<td class="gt_sourcenote" colspan="1">

<span style="background-color: #FFF;color: #444;padding: 0.5em 0.5em;position: inherit;text-transform: uppercase;margin-left: 10px;border: solid 1px #999999;font-variant-numeric: tabular-nums;border-radius: 0;padding: 2px 10px 2px 10px;font-size: smaller;">2021-01-11
13:00:09
UTC</span><span style="background-color: #FFF;color: #444;padding: 0.5em 0.5em;position: inherit;margin: 5px 1px 5px 0;border: solid 1px #999999;border-left: none;font-variant-numeric: tabular-nums;border-radius: 0;padding: 2px 10px 2px 10px;font-size: smaller;">\<
1
s</span><span style="background-color: #FFF;color: #444;padding: 0.5em 0.5em;position: inherit;text-transform: uppercase;margin: 5px 1px 5px -1px;border: solid 1px #999999;border-left: none;border-radius: 0;padding: 2px 10px 2px 10px;font-size: smaller;">2021-01-11
13:00:09 UTC</span>

</td>

</tr>

</tfoot>

</table>

</div>

<!--/html_preserve-->

## Reference

The function `update_data` is heavily referred to
[coronavirus](https://github.com/RamiKrispin/coronavirus) package.
Thanks\!
