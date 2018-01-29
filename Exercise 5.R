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
