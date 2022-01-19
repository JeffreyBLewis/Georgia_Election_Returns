get_current_version <- function(eid) {
  sprintf("https://results.enr.clarityelections.com/GA/%i/current_ver.txt", 
          as.integer(eid)) %>%
    scan()
}


  