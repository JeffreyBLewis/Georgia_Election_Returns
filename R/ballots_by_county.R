get_ballots_cast_by_county <- function(eid, vid) {
  fromJSON(sprintf("https://results.enr.clarityelections.com//GA/%i/%i/json/ALL.json",
                   as.integer(eid),
                   as.integer(vid))) %>%
    .$Contests %>%
    separate(V, sep=",", into=c("election_day", "early", "absentee")) %>%
    rename("county"="A", "contest"="C") %>%
    mutate(across(election_day:absentee, ~ as.numeric(str_replace_all(.x, "\\D", ""))),
           eid = eid,
           vid = vid) %>%
    select(eid, vid, everything())
}


