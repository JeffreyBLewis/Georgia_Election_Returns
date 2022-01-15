get_participating_counties <- function(sw_eid, sw_vid) {
  url <- sprintf("https://results.enr.clarityelections.com//GA/%i/%i/json/en/electionsettings.json",
                 as.integer(sw_eid), as.integer(sw_vid))
  fromJSON(url)$settings$electiondetails$participatingcounties %>%
    as.data.frame() %>%
    rename("x" = ".") %>%
    separate(x, sep="\\|", 
             into=c("county", "eid", "vid", "timestamp", "z")) %>%
    mutate(sw_eid = sw_eid,
           sw_vid = sw_vid) %>%
    select(starts_with("sw"), everything())
}
#get_participating_counties(107231, 273078)