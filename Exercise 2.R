#Exercise 2
#Set working directory to the r-data-frames-sdduffield folder on Github
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

