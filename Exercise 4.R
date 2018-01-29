#Exercise 4
install.packages("dplyr")
library(dplyr)
library(tidyverse)
#Set working directory to the r-data-frames-sdduffield folder on Github
shrub_exper <- read.csv("./data/shrub-volume-experiments-table.csv")
shrub_dims <- read.csv("./data/shrub-volume-experiment.csv")
shrub_manip <- inner_join(shrub_dims, shrub_exper, by = "experiment")
print(shrub_manip)
