library(foreign)
library(ggplot2)
library(tidyverse)

steelprod <- read.csv("~/R materials/AmericaJapanPostWW2Trade/Data/JapanSteelProduction(1950-1960).csv")
steelprod

steelprod %>% ggplot(aes(x = Year, y = Steel.production)) + geom_point()




