library(foreign)
library(ggplot2)
library(tidyverse)
library(ggthemes)
library(scales)

Japan_Steel <- read_csv("Data/JapanSteelProduction(1950-1960).csv",
                      col_names = c("Year", "Steel_Production"),
                      skip = 1)


glimpse(Japan_Steel)

Japan_Steel %>% 
  ggplot(aes(x = Year, y = Steel_Production)) + 
  geom_line(size = 2.5, color = "#474747") +
  scale_x_continuous(breaks = pretty_breaks(n = 10)) +
  scale_y_continuous(breaks = pretty_breaks(n = 10), label = comma) +
  theme_economist_white() +
  theme(axis.text = element_text(size = 10, color = "#474747"), 
        axis.title = element_text(size = 15, color = "#474747"),
        plot.title = element_text(hjust = 0.5, color = "#474747")) +
  labs(x = "Year", y = "Steel Production (Units)", 
       title = "Japan Steel Production\n(1950-1960)") 


library(gganimate)

steel_animate <- steelprod %>% 
  ggplot(aes(x = Year, y = Steel.production, frame = Year, cumulative = TRUE)) + 
  geom_line(size = 2.5) +
  theme_economist_white() +
  theme(axis.text = element_text(size = 10), axis.title = element_text(size = 15),
        plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = pretty_breaks(n = 10)) +
  scale_y_continuous(breaks = pretty_breaks(n = 10), label = comma) +
  labs(x = "Year", y = "Steel Production (Units)", 
       title = "Japan Steel Production\n(1950-1960)") 

gganimate(steel_animate)

?scales::trans_new



# Camera 


JapanCamera <- read.csv("Data/JapanCamera&USAImportCamera(1945-1960).csv")

Japan_Camera <- read_csv("Data/JapanCamera&USAImportCamera(1945-1960).csv",
                         col_names = c("Year", "Camera_Production", "USA_Imports"),
                         skip = 1)

glimpse(Japan_Camera)

glimpse(JapanCamera)

Japan_Camera %>% 
  ggplot(aes(x = Year, y = Camera_Production)) + 
  geom_line()

JapanCamera %>% ggplot(aes(x = Year, y = Japanese.Camera.Production)) + 
  geom_line(size = 2) + 
  geom_point(aes(y = Japanese.Camera.Production), color = "red") +
  geom_line(aes(y = USA.Import.of.Japanese.Cameras), color = "red", size = 2) +
  geom_point(aes(y = USA.Import.of.Japanese.Cameras)) +
  scale_x_continuous(breaks = pretty_breaks(n = 20)) + 
  scale_y_continuous(breaks = pretty_breaks(n = 6), labels = comma) +
  theme_wsj() +
  theme(axis.title = element_text(size = 10),
        axis.text = element_text(size = 7), 
        title = element_text(size = 7.5),
        plot.title = element_text(hjust = 0.5)) +
  labs(x = "Year", y = "Camera Production (Units)", 
       title = "Japan Camera Production and USA Imports of Japan Cameras\n (1945-1960)")


# animate:

camera_animate <- JapanCamera %>% 
  ggplot(aes(x = Year, y = Japanese.Camera.Production, frame = Year, cumulative = TRUE)) + 
  geom_line(size = 2) + 
  geom_point(aes(y = Japanese.Camera.Production), color = "red") +
  geom_line(aes(y = USA.Import.of.Japanese.Cameras), color = "red", size = 2) +
  geom_point(aes(y = USA.Import.of.Japanese.Cameras)) +
  scale_x_continuous(breaks = pretty_breaks(n = 20)) + 
  scale_y_continuous(breaks = pretty_breaks(n = 6), labels = comma) +
  theme_wsj() +
  theme(axis.title = element_text(size = 10),
        axis.text = element_text(size = 7), 
        title = element_text(size = 7.5),
        plot.title = element_text(hjust = 0.5)) +
  labs(x = "Year", y = "Camera Production (Units)", 
       title = "Japan Camera Production and USA Imports of Japan Cameras\n (1945-1960)")


gganimate(camera_animate)


#



JapanCotton <- read.csv("Data/JapanCottonTextileExports(1946-1960).csv")

JapanCotton

JapanCotton %>% 
  ggplot(aes(Year, y = Japan.Cotton.Textile.Exports.to.USA..million.square.yards.), color = I("blue")) +
  geom_line(size = 2) + 
  geom_line(aes(y = Cotton.Textile.Exports.to.USA..million.square.yards.), size = 2)

JapanCotton %>% 
  rename(Cotton.From.Japan.Exports = Japan.Cotton.Textile.Exports.to.USA..million.square.yards.,
         All.USA.Exports = Cotton.Textile.Exports.to.USA..million.square.yards.) %>% 
  ggplot(aes(Year, y = Cotton.From.Japan.Exports)) + 
  geom_line(size = 1.5) +
  geom_line(aes(y = All.USA.Exports)) +
  scale_x_continuous(breaks = pretty_breaks(n = 20)) + 
  scale_y_continuous(breaks = pretty_breaks(n = 6), labels = comma) +
  theme_wsj() +
  theme(axis.title = element_text(size = 10),
        axis.text = element_text(size = 7), 
        title = element_text(size = 7.5),
        plot.title = element_text(hjust = 0.5)) +
  labs(x = "Year", y = "Cotton Production (Million Yards)", 
       title = "USA Total Cotton Exports and Cotton Exports from Japan \n (1945-1960)")



JapanCotton %>%
  rename(Cotton.From.Japan.Exports = Japan.Cotton.Textile.Exports.to.USA..million.square.yards.,
         All.USA.Exports = Cotton.Textile.Exports.to.USA..million.square.yards.) %>% 
  ggplot(aes(Year, y = All.USA.Exports)) + 
  geom_line(size = 1.5) + 
  geom_point(color = I("red"), size = 3) +
  scale_x_continuous(breaks = pretty_breaks(n = 20)) + 
  scale_y_continuous(breaks = pretty_breaks(n = 6), labels = comma) +
  theme_wsj() +
  theme(axis.title = element_text(size = 10),
        axis.text = element_text(size = 7), 
        title = element_text(size = 7.5),
        plot.title = element_text(hjust = 0.5)) +
  labs(x = "Year", y = "Cotton Production (Million Yards)", 
       title = "USA Total Cotton Imports \n (1945-1960)")






