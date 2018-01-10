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

camera_animate <- Japan_Camera %>% 
  ggplot(aes(x = Year, y = Camera_Production, frame = Year, cumulative = TRUE)) + 
  geom_path(aes(y = Camera_Production), color = "#474747", size = 1.5) +
  geom_path(aes(y = USA_Imports), color = "black", size = 1.5) +
  scale_x_continuous(breaks = pretty_breaks(n = 20)) + 
  scale_y_continuous(labels = c("0", "500,000", "1 Million", "1.5 Million", "2 Million")) +
  theme_bw() +
  theme(axis.title = element_text(size = 10),
        axis.text = element_text(size = 8), 
        title = element_text(size = 9.5),
        plot.title = element_text(hjust = 0.5)) +
  labs(x = "Year", y = "Japanese Cameras (Units)", 
       title = "Japanese Camera Production and USA Imports of Japanese Cameras\n (1945-1960)")

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











# tweenR ------------------------------------------------------------------
library(dplyr) # pipes
library(readr)    # reading in .csv files

library(ggplot2)  # plotting
library(ggthemes) # ggplot2 themes
library(scales)


Japan_Camera <- read_csv("Data/JapanCamera&USAImportCamera(1945-1960).csv",
                         col_names = c("Year", "Camera_Production", "USA_Imports"),
                         skip = 1)

library(tweenr)

glimpse(Japan_Camera)

Japan_Camera_tween <- Japan_Camera %>% 
  rename(y = Camera_Production, time = Year) %>% 
  mutate(id = time, 
         x = time,
         ease = "linear") %>% 
  select(x, y, time, id, ease)

glimpse(Japan_Camera_tween)

Japan_Camera_tween <- Japan_Camera_tween %>% 
  mutate(id = as.factor(id))

Japan_cam_tween <- tween_elements(Japan_Camera_tween, "time", "id", "ease", nframes = 1000)

glimpse(Japan_cam_tween)


camera_animate <- Japan_Camera %>% 
  ggplot(aes(x = Year, y = Camera_Production, frame = Year, cumulative = TRUE)) + 
  geom_path(aes(y = Camera_Production), color = "#474747", size = 1.5) +
  geom_path(aes(y = USA_Imports), color = "black", size = 1.5) +
  scale_x_continuous(breaks = pretty_breaks(n = 20)) + 
  scale_y_continuous(labels = c("0", "500,000", "1 Million", "1.5 Million", "2 Million")) +
  theme_bw() +
  theme(axis.title = element_text(size = 10),
        axis.text = element_text(size = 8), 
        title = element_text(size = 9.5),
        plot.title = element_text(hjust = 0.5)) +
  labs(x = "Year", y = "Japanese Cameras (Units)", 
       title = "Japanese Camera Production and USA Imports of Japanese Cameras\n (1945-1960)")

gganimate(camera_animate)




# plotly ------------------------------------------------------------------

library(plotly)

glimpse(Japan_Camera)

J_Cam <- Japan_Camera %>% 
  ggplot(aes(x = Year)) + 
  geom_line(aes(y = Camera_Production, color = "Camera Production", frame = Year), size = 1.5) +
  geom_line(aes(y = USA_Imports, color = "USA Imports", frame = Year), size = 1.5) +
  scale_x_continuous(breaks = pretty_breaks(n = 20)) + 
  scale_y_continuous(labels = c("0", "500,000", "1 Million", "1.5 Million", "2 Million")) +
  scale_color_manual(values = c("Camera Production" = "#474747", 
                                "USA Imports" = "black")) +
  geom_vline(xintercept = 1950) +
  geom_vline(xintercept = 1953) +
  annotate(geom = "text", 
           label = "Korean\nWar", size = 5, color = "#474747",
           x = 1951.5, y = 1000000) +
  theme_bw() +
  theme(axis.title = element_text(size = 10),
        axis.text = element_text(size = 8), 
        title = element_text(size = 9.5),
        plot.title = element_text(hjust = 0.5),
        legend.position = c(0.15, 0.9),
        legend.title = element_blank()) +
  labs(x = "Year", y = "Japanese Cameras (Units)", 
       title = "Japanese Camera Production and USA Imports of Japanese Cameras\n (1945-1960)")


J_Cam <- Japan_Camera %>% 
  ggplot(aes(x = Year, y = Camera_Production)) + 
  geom_path(aes(frame = Year)) +
  geom_point(aes(frame = Year))


Cam_Plotly <- ggplotly(J_Cam)

Cam_Plotly

Sys.setenv("plotly_username" = "RN1892")
Sys.setenv("plotly_api_key" = "M5PHBeFifVcHtfjfrFRv")

chart_link <- api_create(Cam_Plotly, filename = "camera-plot")

chart_link


df <- data.frame(
  x = c(1,2,3,4), 
  y = c(1,2,3,4), 
  f = c(1,2,3,4)
)

p <- ggplot(df, aes(x, y)) +
  geom_point(aes(frame = f))

ggplotly(p)

J_Cam





# time series tweenr  -----------------------------------------------------

library(tweenr)
library(tidyverse)

data <- tribble(
  ~year, ~num,
  1950, 56,
  1951, 59,
  1952, 64,
  1953, 67,
  1954, 69,
  1955, 74,
  1956, 78,
  1957, 83
)

dat_ani <- map(seq(nrow(data)), ~data[c(seq(.x), rep(.x, nrow(data) - .x)), ]) %>% 
  tweenr::tween_states(5, 2, 'cubic-in-out', 100) %>% 
  ggplot(aes(year, num, frame = .frame)) + 
  geom_path() + 
  geom_point()

animation::ani.options(interval = 0.5)    # speed it up
gganimate::gganimate(dat_ani, title_frame = FALSE)

seq(nrow(data))

# 1,2,3,4,5,6,7,8
map(seq(nrow(data)), ~data[c(seq(.x), 
                             rep(.x, nrow(data) - .x) 
), 
]
)

dt <- map(seq(nrow(data)), ~data[c(seq(.x), rep(.x, nrow(data) - .x)), ])

str(dt, list.len = 2)

data[[1]]
data[[2]]
data[2, ]
data[1, ]
data[1, 2]

rep(1, nrow(data) - 1)

rep(1, nrow(data) - 6)

rep(3, nrow(data) - 3)

rep(2, nrow(data) - 3)

seq(data)
str(data)


















