#Exercise 7.1
#Set working directory to the r-data-frames-sdduffield data folder on Github

install.packages("dplyr")
install.packages("dbplyr")
install.packages("RSQLite")
install.packages("tidyverse")
library(dplyr)
library(dbplyr)
library(RSQLite)
library(tidyverse)


portaldb <- src_sqlite("portal_mammals.sqlite")
surveys <- tbl(portaldb, "surveys")

#Exercise 7.1
query <- "SELECT DISTINCT species_id FROM surveys WHERE weight IS NOT NULL"
distinct_species <- tbl(portaldb, sql(query))
nrow(collect(distinct_species))


#Exercise 7.2 
#I included two methods very close the correct answer but I could not find anything about how to control the number of digits displayed in a tibble.
#1 displays the correctly rounded value and 2 displays a tibble with the correct value and an incorrect number of digits.
query <- "SELECT AVG(weight/1000.0) AS avg_weight FROM surveys WHERE species_id IS 'NL' AND weight IS NOT NULL"
avg_weight <- collect(tbl(portaldb, sql(query))) 
#1
print.data.frame(avg_weight, digits = 7)
#2
avg_weight

#Exercise 7.3
query <- "SELECT year, COUNT(*) AS no_individuals FROM surveys GROUP BY year"
year_count <- tbl(portaldb, sql(query))
collect(year_count)
