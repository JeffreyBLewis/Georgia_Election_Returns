library(targets)
library(purrr)
library(tidyverse)
library(httr)

walk(list.files(path="R", pattern="*R$", full.names=TRUE), source)
tar_option_set(packages = c("tidyverse", "purrr", "rvest", "jsonlite",
                            "httr", "lubridate", "xml2"))

list(
  tar_target(
    elections,
    fromJSON("https://results.enr.clarityelections.com/GA/elections.json") %>%
      mutate(current_version = map(EID, get_current_version))
  ),
  tar_target(
    participating_counties,
    map2_df(elections$EID, elections$current_version, get_participating_counties)
  ),
  tar_target(
    ballots_cast_by_county,
    map2_df(elections$EID, elections$current_version, get_ballots_cast_by_county)
  ),
  tar_target(
    download_xml,
    get_precinct_xml(participating_counties)
  ),
  tar_target(
    precinct_level_data,
    list.files("precinct_xml", pattern="*zip$", full.name=TRUE) %>%
      map_df(parse_xml)
  ),
  tar_target(
    precinct_data_csv,
    { 
      csv_fn <- "csv/GA_precinct_level_election_returns.csv.gz"
      write_csv(precinct_level_data, csv_fn)
      csv_fn 
    },
    format = "file"
  )
)
