
#Exercise 6
#Set working directory to the r-data-frames-sdduffield data folder on Github

install.packages("dplyr")
install.packages("dbplyr")
install.packages("RSQLite")
library(dplyr)
library(dbplyr)
library(RSQLite)
portaldb <- src_sqlite("portal_mammals.sqlite")
surveys <- tbl(portaldb, "surveys")

#Exercise 6.1
query <- "SELECT year, month, day, species_id FROM surveys"
tbl(portaldb, sql(query))

#Exercise 6.2 - unfinished
query <- "SELECT year, species_id, weight/1000.0 AS weight_kg FROM surveys WHERE weight IS NOT NULL"
avg_weight <- tbl(portaldb, sql(query))
avg_weight


#Exercise 6.3
query <- "SELECT DISTINCT species_id FROM surveys WHERE weight IS NOT NULL"
tbl(portaldb, sql(query))

