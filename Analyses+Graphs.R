library(foreign)
library(ggplot2)
library(tidyverse)
library(ggthemes)
library(scales)

steelprod <- read.csv("~/R materials/AmericaJapanPostWW2Trade/Data/JapanSteelProduction(1950-1960).csv")
steelprod

steelprod %>% ggplot(aes(x = Year, y = Steel.production)) + geom_line(size = 3) +
  theme_economist() +
  theme(axis.text = element_text(size = 10), axis.title = element_text(size = 15)) +
  scale_x_continuous(breaks = pretty_breaks(n = 10)) +
  scale_y_continuous(breaks = pretty_breaks(n = 10)) +
  labs(x = "Year", y = "Steel Production", title = "Japan Steel Production (1950-1960)") 





JapanCamera <- read.csv("~/R materials/AmericaJapanPostWW2Trade/Data/JapanCamera&USAImportCamera(1945-1960).csv")
JapanCamera

JapanCamera %>% ggplot(aes(x = Year, y = value, group = variable)) + geom_line()

JapanCamera %>% ggplot(aes(x = Year, y = Japanese.Camera.Production)) + geom_line() +
  geom_line(aes(y = USA.Import.of.Japanese.Cameras))


JapanCotton <- read.csv("~/R materials/AmericaJapanPostWW2Trade/Data/JapanCottonTextileExports(1946-1960).csv")
JapanCotton