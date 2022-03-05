Checking contest names across counties and contest_key values
================
Jeff Lewis
3/5/2022

## Overview

Check to see if contest names are unique within county. That is, if we
see the contest name “city council” it refers to only one specific
electoral contest within the county. Also, look to see if the
`contest_key` variable helps to disambiguate contests if the `contest`
field values are not indeed unique.

``` r
setwd("..")
tar_load(precinct_level_data)
```

``` r
contest_dat <- precinct_level_data %>%
  distinct(date, contest_key, county, contest, candidate)  %>%
  group_by(date, contest_key, county, contest) %>%
  summarize(cands = paste(candidate, collapse="|"),
            ncands = n(), 
            .groups="drop")  
```

Most contest names are associated with three of fewer candidates
suggesting that contest names identify unique contests within counties.

Here are the contests that have a large number of candidates:

``` r
contest_dat %>% 
  filter(ncands > 4) %>%
  group_by(date, contest) %>%
  summarize(ncands = max(ncands),
            counties = n()) %>%
  knitr::kable()
```

    ## `summarise()` has grouped output by 'date'. You can override using the `.groups` argument.

| date      | contest                                                                                           | ncands | counties |
|:----------|:--------------------------------------------------------------------------------------------------|-------:|---------:|
| 1/8/2019  | State Representative, District 5                                                                  |      6 |        2 |
| 11/2/2021 | Bloomingdale - City Council at Large                                                              |      8 |        1 |
| 11/2/2021 | State House Dist 165 - Special                                                                    |      5 |        1 |
| 11/2/2021 | Thunderbolt - Town Council At Large                                                               |      6 |        1 |
| 11/2/2021 | Tybee Island - City Council At Large                                                              |      6 |        1 |
| 11/3/2020 | Adairsville City Council Post 4 - Special                                                         |      6 |        1 |
| 11/3/2020 | Ashburn City Council                                                                              |      7 |        1 |
| 11/3/2020 | Camak City Council                                                                                |      5 |        1 |
| 11/3/2020 | County Commission District 2 (Term Expires 2022) - Special                                        |      5 |        1 |
| 11/3/2020 | Demorest City Council - Special                                                                   |      7 |        1 |
| 11/3/2020 | Doraville City Council District 1 - Special                                                       |      7 |        1 |
| 11/3/2020 | Lakeland City Council Post 1 - Special                                                            |      7 |        1 |
| 11/3/2020 | US Senate (Loeffler) - Special                                                                    |     20 |      156 |
| 11/3/2020 | US Senate (Loeffler) - Special Election                                                           |     20 |        2 |
| 11/3/2020 | US Senate (Loeffler) - Special/Senado de los EE.UU. (Loeffler) - Especial                         |     20 |        1 |
| 2/9/2021  | State House District 90 - Special                                                                 |      6 |        3 |
| 3/24/2020 | DEM - President of the United States                                                              |     12 |      159 |
| 3/24/2020 | Sheriff                                                                                           |      9 |        1 |
| 6/15/2021 | State House District 34                                                                           |      5 |        1 |
| 6/9/2020  | Augusta Commissioner Dist 1                                                                       |      5 |        1 |
| 6/9/2020  | Augusta Commissioner Dist 9                                                                       |      5 |        1 |
| 6/9/2020  | DEM - Co Commission Chair/Presidente de la Comisión del Condado                                   |      5 |        1 |
| 6/9/2020  | DEM - Co Commission Dist 3                                                                        |      5 |        1 |
| 6/9/2020  | DEM - Co Commission Dist 3/Comisionado del Condado para el Dist 3                                 |      5 |        1 |
| 6/9/2020  | DEM - Co Commission Dist 4                                                                        |      7 |        1 |
| 6/9/2020  | DEM - Co Commission Dist 5                                                                        |      5 |        1 |
| 6/9/2020  | DEM - President of the United States                                                              |     12 |      158 |
| 6/9/2020  | DEM - President of the United States/Presidentede los Estados Unidos                              |     12 |        1 |
| 6/9/2020  | DEM - Sheriff                                                                                     |      8 |        4 |
| 6/9/2020  | DEM - State House Dist 163                                                                        |      5 |        1 |
| 6/9/2020  | DEM - US House Dist 7                                                                             |      6 |        1 |
| 6/9/2020  | DEM - US House Dist 7/Distrito del Congreso 7                                                     |      6 |        1 |
| 6/9/2020  | DEM - US Senate                                                                                   |      7 |      158 |
| 6/9/2020  | DEM - US Senate/Senado de los EE.UU.                                                              |      7 |        1 |
| 6/9/2020  | Mayor                                                                                             |      5 |        1 |
| 6/9/2020  | Probate Judge                                                                                     |      5 |        1 |
| 6/9/2020  | REP - Chief Magistrate                                                                            |      5 |        1 |
| 6/9/2020  | REP - Clerk of Superior Court                                                                     |      5 |        1 |
| 6/9/2020  | REP - Co Commission Dist 4                                                                        |      5 |        1 |
| 6/9/2020  | REP - Sheriff                                                                                     |      5 |        4 |
| 6/9/2020  | REP - State House Dist 20                                                                         |      5 |        1 |
| 6/9/2020  | REP - State House Dist 9                                                                          |      6 |        3 |
| 6/9/2020  | REP - State Senate Dist 50                                                                        |      6 |        8 |
| 6/9/2020  | REP - US House Dist 14                                                                            |      9 |       12 |
| 6/9/2020  | REP - US House Dist 6                                                                             |      5 |        3 |
| 6/9/2020  | REP - US House Dist 7                                                                             |      7 |        1 |
| 6/9/2020  | REP - US House Dist 7/Distrito del Congreso 7                                                     |      7 |        1 |
| 6/9/2020  | REP - US House Dist 9                                                                             |      9 |       20 |
| 6/9/2020  | Sheriff (Special From March)                                                                      |      9 |        1 |
| 6/9/2020  | Special - State Senate Dist 4                                                                     |      5 |        5 |
| 6/9/2020  | Special - State Senate District 4                                                                 |      5 |        1 |
| 6/9/2020  | State Court Judge Post 6                                                                          |      6 |        1 |
| 6/9/2020  | Superior Court - Gwinnett - Schrader/Tribunal Superior del Circuito Judicial- Gwinnett - Schrader |      5 |        1 |
| 6/9/2020  | Superior Court - Stone Mountain - Seeliger                                                        |      5 |        1 |

Nothing here immediately jumps out as suggesting that multiple contests
in a county are have the same `contest` field value.

However, one thing to note is that same contest may have different names
*across* counties.

Further, there is only one case in which the same contest name is
associated with two `contest_key` values in the same county:

``` r
contest_dat%>%
  group_by(date, county, contest) %>%
  summarize(n = n(), .groups="drop") %>% 
  filter(n>1) %>%
  knitr::kable()
```

| date     | county  | contest           |   n |
|:---------|:--------|:------------------|----:|
| 6/9/2020 | Douglas | State Court Judge |   2 |

I expect this is an error. Here is that instance:

``` r
precinct_level_data %>%
  filter(date=="6/9/2020", county=="Douglas", contest=="State Court Judge") %>%
  count(contest, contest_key, candidate) %>%
  knitr::kable()
```

| contest           | contest_key | candidate            |   n |
|:------------------|:------------|:---------------------|----:|
| State Court Judge | 54          | Brian K. Fortner (I) | 100 |
| State Court Judge | 56          | Eddie Barker (I)     | 100 |

So, the `contest_key` isn’t helping to resolve contests beyond the
information available in the contest name.
