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
