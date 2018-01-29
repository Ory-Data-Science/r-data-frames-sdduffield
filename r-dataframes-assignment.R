#Exercise 1
install.packages("dplyr")
library(dplyr)
help(package = dplyr)

#Exercise 2
#Set working directory to data folder in the r-data-frames-sdduffield folder on Github
install.packages("dplyr")
library(dplyr)
library(tidyverse)
shrub_dims <- read.csv("./data/shrub-volume-experiment.csv")

#2.1
names(shrub_dims)

#2.2
str(shrub_dims)

#2.3
head(shrub_dims)

#2.4
select(shrub_dims, length)

#2.5
select(shrub_dims, site, experiment)

#2.6
filter(shrub_dims, height > 5)

#2.7
shrub_data_w_vols <- mutate(shrub_dims, volume = length * width * height)
print(shrub_data_w_vols)


#Exercise 3
install.packages("dplyr")
library(dplyr)
library(tidyverse)
#Set working directory to the r-data-frames-sdduffield folder on Github
shrub_dims <- read.csv("./data/shrub-volume-experiment.csv")

by_site <- group_by(shrub_dims, site)
avg_height <- summarize(by_site, avg_height = mean(height))


#3.1
by_site <- group_by(shrub_dims, experiment)
avg_height <- summarize(by_site, avg_height = mean(height))
print(avg_height)

#3.2
by_site <- group_by(shrub_dims, site)
max_height <- summarize(by_site, max_height = max(height))
print.data.frame(max_height, digits = 2)


#Exercise 4
install.packages("dplyr")
library(dplyr)
library(tidyverse)
#Set working directory to the r-data-frames-sdduffield folder on Github
shrub_exper <- read.csv("./data/shrub-volume-experiments-table.csv")
shrub_dims <- read.csv("./data/shrub-volume-experiment.csv")
shrub_manip <- inner_join(shrub_dims, shrub_exper, by = "experiment")
print(shrub_manip)


#Excercise 5
install.packages("dplyr")
library(dplyr)
library(tidyverse)
#Set working directory to the r-data-frames-sdduffield folder on Github

#5.1 5.2
#import shrub dimension data as a csv file from data folder in working directory
shrub_data <- read.csv("./data/shrub-volume-experiment.csv")
#select shrub dimension data as dataframe
shrub_data %>%
  #add a column for volume calculated using the recorded length, width, and height for each plant
  mutate(volume = length * width * height) %>%
  #group the mutated data frame by site in preparation for summary by average volume
  group_by(site) %>%
  #calculate the mean volume for plants found at each site and display in a new column labelled mean_volume
  summarize(mean_volume = mean(volume, na.rm = TRUE))%>%
  print.data.frame(digits = 7)


#select shrub dimension data as data frame
shrub_data %>%
  #add a column for volume calculated using the recorded length, width, and height for each plant
  mutate(volume = length * width * height) %>%
  #group the mutated dataframe by site in preparation for summary by average volume
  group_by(experiment) %>%
  #calculate the mean volume for plants found at each site and display in a new column labelled mean_volume
  summarize(mean_volume = mean(volume, na.rm = TRUE))%>%
  print.data.frame(digits = 7)



#Exercise 6
#Set working directory to the r-data-frames-sdduffield folder on Github
install.packages("dplyr")
install.packages("RSQLite")
library(dplyr)
library(RSQLite)
library(tidyverse)
portaldb <- src_sqlite("portal_mammals.sqlite")
surveys <- tbl(portaldb, "surveys")
surveys

#Exercise 6.1
query <- "SELECT year, month, day, species_id FROM surveys"
tbl(portaldb, sql(query))

#Exercise 6.2 - unfinished
query <- "SELECT year, species_id, ROUND(weight,0) AS weight_kg FROM surveys WHERE weight IS NOT NULL"
tbl(portaldb, sql(query))

#Exercise 6.3
query <- "SELECT DISTINCT species_id FROM surveys WHERE weight IS NOT NULL"
tbl(portaldb, sql(query))

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

#Challenge with R
install.packages(dplyr)
install.packages("RSQLite")
library(RSQLite)
library(dplyr)

portaldb <- src_sqlite("portal_mammals.sqlite")
surveys <- tbl(portaldb, "surveys")
surveys <- collect(surveys)
plots <-  tbl(portaldb, "plots")
plots <- collect(plots)
species <- tbl(portaldb, "species")
species <- collect(species)


surveys_plots <- inner_join(surveys, plots, by = "plot_id")
combined <- inner_join(surveys_plots, species, by = "species_id")
combined

combined_group <- combined %>%
  filter(plot_type == "Control") %>%
  filter(!is.na(weight)) %>%
  mutate(weight_kg = weight/1000.0) %>%
  group_by(species_id)

avg_weight <- summarize(combined_group, 
                        avg_weight = mean(weight_kg, na.rm = TRUE))
print(avg_weight)

#Challenge with SQL

install.packages("dplyr")
install.packages("dbplyr")
install.packages("RSQLite")
library(dplyr)
library(dbplyr)
library(RSQLite)
portaldb <- src_sqlite("portal_mammals.sqlite")
plots <- tbl(portaldb, "plots")
species <- tbl(portaldb, "species")
surveys <- tbl(portaldb, "surveys")

query <- "SELECT surveys.species_id, ROUND(AVG(surveys.weight)/1000.0, 4) AS avg_weight
          FROM surveys JOIN species
          ON surveys.species_id = species.species_id
          JOIN plots ON surveys.plot_id = plots.plot_id
          WHERE (surveys.weight IS NOT NULL) AND (plots.plot_type == 'Control')
          GROUP BY species.species_id"
avg_weight_control <- tbl(portaldb, sql(query))
control_avg_size_spec <- collect(avg_weight_control)
control_avg_size_spec


