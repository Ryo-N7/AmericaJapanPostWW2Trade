Exploring Japan's Postwar Economic Miracle with ggplot2, gganimate, & highcharter!
==================================================================================

In this blog post I weave in a gganimate and tweenr tutorial while exploring the American policies that aided Japan's postwar economic miracle! Back in college, I wrote a paper on the this subject for my United States Economic History class. We were supposed to include a few tables and graphs each in our paper and, as this was before I learned about R in my Econometrics class a year later, everything was stored and created in Excel. More than a year ago I went back and recreated the graphs using ggplot2 for some easy practice and now I'm going another level higher by implementing `gganimate` and `tweenr` into my plots!

There won't be a lot of code as other posts as I didn't have to do much data munging for this mini-project. I tried to summarize/shorten the gist of my paper but even then, if you don't like history and just want to see how to do the animations, go ahead but you'll be missing a lot of the context! I've included references and also some further reading at the end as my original (undergraduate) paper is by no means a comprehensive survey of the economic and political upheaval in the postwar period (especially as my focus was on the American policies).

Postwar Japan and the Korean War
--------------------------------

Under American occupation, Japan was barely surviving on subsidies and US aid as the Supreme Commander of the Allied Powers (SCAP) restricted Japan's foreign trade and international transactions. The main goal, initially, was to cripple the Japanese economy (especially in terms of its heavy industries) so that it could never produce military goods again (Ohno, 2005). Some of the reforms initiated by SCAP include the breaking up of the **zaibatsu** (family-owned mega-conglomerates that had a large role in Japanese war industries), new labor laws, land reform, and the well-known political reforms (the renunciation of the Emperor as a God and Article 9 in the new constitution, which renounced war).

In 1948, President Truman asked Joseph Dodge for help in reconstructing Japan's economy due to his successes in rebuilding Germany midst the looming threat of Communism in Asia with Mao's forces inching closer to total victory over the Kuomintang (Nakamura & Odaka, 2003). Introducing austerity measures and setting a advantageous exchange rate for Japan among other policies which helped combat inflation, Dodge nevertheless caused severe adverse economic shocks and economic output tanked (Ohno, 2005). Fortunately, Japan's saving grace came with the start of the Korean War in 1950.

With high external demand leading to an export boom, Japan's recession ended quickly and the economy boomed as industrial output increased by more than 50% between 1950 and 1951, export values increased by 53%, and the total value of foreign trade increased by 84% (Dingman, 1993). This huge influx of dollars provided the investment needed for many different sectors of the Japanese economy to modernize their means of production (Dingman, 1993).

Shifts in American policy regarding the Japanese economy
--------------------------------------------------------

From around 1947 there was a profound shift away from the initial American policies aimed at limiting Japanese heavy industry. While diplomats such as William R. Castle emphasized the rhetoric that Japan can serve as a capitalist bulwark against Soviet expansion into Asia, American policy makers preoccupied with postwar economic issues saw Japanese economic recovery as a solution to domestic problems (Schonberger, 1982). Gradually, politicians such as George Kennan (Policy Planning Staff in the State Department) and William Draper (Army Undersecretary) moved to dilute the impact of SCAP policies such as the *zaibatsu* dissolution reform "FEC-230" (Schonberger, 1982). Their revision, modeled after the Marshall Plan, argued that a two year burst of aid appropriations would increase Japanese exports and thereby foreign exchange for imports of basic necessities and allow for the United States to stop sending aid by 1953 (Schonberger, 1982). SCAP and MacArthur refused to cooperate as they believed the *zaibatsu* were militarists and a fundamental change of the Japanese economic system was needed. However, in the summer of 1948, MacArthur acquiesced and the reform only broke up 19 of the 324 planned firms while banks were exempted altogether (Schonberger, 1982). Other factors tied into this such as the traditionally strong Japanese legal support for *zaibatsu* and the lobbying to Congress by American corporations with ties to these Japanese companies. As a result most *zaibatsu* were modified into *keiretsu* (bank-centered, industrial conglomerates) and American foreign grants/credits to Japan declined sharply by 1953 (Statistical Abstract of the United States 1954, pp. 902; Statistical Abstract of the United States 1960, pp. 906).

Steel industry
--------------

The steel and coal industry was one of the first industries targeted to revitalize the economy as both the Japanese government and SCAP recognized them as a valuable input for other industries (Elbaum, 2007; Fletcher, 2006). Coal was Japan's only domestically available resource and it was believed that increased coal output would lead to increased steel manufacturing, leading to increased allocation of steel for coal production, presenting a positive feedback loop for the economy. With the profits from the Korean War through US military procurement reinvested throughout the '50s, the steel industry contributed heavily to overall productivity gain and steel production rose up and above pre-war levels (Ohno, 2006).

Steel production plot
---------------------

(NOTE: I originally used data from Statistical Abstract of the United States (editions between 1950 and 1960), in process of writing this article I tried to find more data from before 1950 and came across the Historical Statistics of Japan (by the Japan Statistical Association) that has the crude steel production from 1948 to 2004. Although the Statistical Abstract data matched up well with the Japanese source I elected to recreate this graph from the Historical Statistics of Japan data instead.)

``` r
library(dplyr)    # pipes and dplyr verbs
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(readr)    # reading in .csv files

library(ggplot2)  # plotting
library(ggthemes) # ggplot2 themes
library(scales)   # ggplot2 scaling options
```

    ## 
    ## Attaching package: 'scales'

    ## The following object is masked from 'package:readr':
    ## 
    ##     col_factor

``` r
Japan_Steel <- readxl::read_xls("Data/iron_steel_production_1948-2004.xls",
                             skip = 7,
                             col_names = c("J_Year", "Year", "Pig_iron", 
                                           "Ferro-alloys", "Crude_steel",
                                           "Hot_steel_products", "Galvanized_sheets")) %>% 
  select(Year, Crude_steel) %>% 
  filter(Year <= 1960)

Japan_Steel %>% 
  ggplot(aes(x = Year, y = Crude_steel)) + 
  geom_line(size = 2.5, color = "#474747") +
  scale_x_continuous(breaks = pretty_breaks(n = 10)) +
  scale_y_continuous(breaks = pretty_breaks(), labels = comma, limits = c(0, 26000)) +
  geom_vline(xintercept = 1950) +
  geom_vline(xintercept = 1953) +
  annotate(geom = "text",
           label = "Korean\nWar", size = 5, color = "#474747",
           x = 1951.55, y = 17500) +
  theme_economist_white() +
  theme(axis.text = element_text(size = 10, color = "#474747"), 
        axis.title = element_text(size = 15, color = "#474747"),
        plot.title = element_text(hjust = 0.5, color = "#474747")) +
  labs(x = "Year", y = "Steel Production (Thousands of tons)", 
       title = "Japan Steel Production\n(1950-1960)",
       caption = "Source: Historical Statistics of Japan, 2012") 
```

![](japan_postwar_recovery_files/figure-markdown_github/packages%20steel%20static-1.png)

Introducing `gganimate`!
------------------------

The idea behind gganimate is simple, as the name implies the animation part of a plot becomes just another aesthetic within the `ggplot` concept. This package is dependent on [ImageMagick](https://www.imagemagick.org/script/download.php) and FFmpeg to save your plots as GIFs or videos so make sure you have those installed as well. Once all that's done, go into the `ggplot()` code you previously made and it's just as simple as adding in `frame = ____` (whatever the variable you want to create an individual frame out of). You can also include `cumulative = TRUE` if you want to keep previous frames of added data on the plot as you change to the next frames.

For other tutorials take a look at gganimate's [Github repo](https://github.com/dgrtwo/gganimate) for a short tutorial or take a look at Peter Aldhous' lecture notes on [Iteration & Animation (with ggplot2)](http://paldhous.github.io/ucb/2016/dataviz/week14.html).

If you're more of a video person or just want something to watch while grabbing some lunch here is David Robinson talking about gganimate at [Plotcon 2016](https://www.youtube.com/watch?v=9Y7Y1s4-VdA&t=1549s).

``` r
library(gganimate) # animations

Steel_Animate <- Japan_Steel %>% 
  ggplot(aes(x = Year, y = Crude_steel, frame = Year, cumulative = TRUE)) + 
  geom_line(size = 2.5, color = "#474747") +
  scale_x_continuous(breaks = pretty_breaks(n = 10)) +
  scale_y_continuous(breaks = pretty_breaks(), labels = comma, limits = c(0, 26000)) +
  geom_vline(xintercept = 1950) +
  geom_vline(xintercept = 1953) +
  annotate(geom = "text",
           label = "Korean\nWar", size = 5, color = "#474747",
           x = 1951.55, y = 17500) +
  theme_economist_white() +
  theme(axis.text = element_text(size = 10, color = "#474747"), 
        axis.title = element_text(size = 15, color = "#474747"),
        plot.title = element_text(hjust = 0.5, color = "#474747")) +
  labs(x = "Year", y = "Steel Production (Thousands of tons)", 
       title = "Japan Steel Production\n(1950-1960)",
       caption = "Source: Historical Statistics of Japan, 2012") 

gganimate(Steel_Animate)
```

    ## geom_path: Each group consists of only one observation. Do you need to
    ## adjust the group aesthetic?

![](japan_postwar_recovery_files/figure-markdown_github/steel%20animated-1.png)![](japan_postwar_recovery_files/figure-markdown_github/steel%20animated-2.png)![](japan_postwar_recovery_files/figure-markdown_github/steel%20animated-3.png)![](japan_postwar_recovery_files/figure-markdown_github/steel%20animated-4.png)![](japan_postwar_recovery_files/figure-markdown_github/steel%20animated-5.png)![](japan_postwar_recovery_files/figure-markdown_github/steel%20animated-6.png)![](japan_postwar_recovery_files/figure-markdown_github/steel%20animated-7.png)![](japan_postwar_recovery_files/figure-markdown_github/steel%20animated-8.png)![](japan_postwar_recovery_files/figure-markdown_github/steel%20animated-9.png)![](japan_postwar_recovery_files/figure-markdown_github/steel%20animated-10.png)![](japan_postwar_recovery_files/figure-markdown_github/steel%20animated-11.png)![](japan_postwar_recovery_files/figure-markdown_github/steel%20animated-12.png)![](japan_postwar_recovery_files/figure-markdown_github/steel%20animated-13.png)

Looks great! However, the animation looks a bit jagged, but we'll look at ways to fix that in the next section!

Camera industry
---------------

The camera industry had a quick recovery as the camera companies were one of the earliest to receive permits to resume production by SCAP in early 1946 and Japan already had all the raw materials needed for production (Nelson, 1998). The American military post exchanges (PX) throughout the Korean and Vietnam Wars allowed for large influx in dollars for Japan through camera and lens sales due to demand from American soldiers and also allowed Japanese camera products (most notably familiar companies such as Nikon and Canon) to enter the American market through its popularity among the returning American personnel (Nelson, 1998). By the 1970s, when American policies shifted regarding Japan's favorable exchange rate, it did not matter as Japan no longer needed to rely solely on the US market as it had in its postwar infancy (Nelson, 1998).

``` r
Japan_Camera <- read_csv("Data/JapanCamera&USAImportCamera(1945-1960).csv",
                         col_names = c("Year", "Camera_Production", "USA_Imports"),
                         skip = 1)
```

    ## Parsed with column specification:
    ## cols(
    ##   Year = col_integer(),
    ##   Camera_Production = col_integer(),
    ##   USA_Imports = col_integer()
    ## )

``` r
Japan_Camera %>% 
  ggplot(aes(x = Year, y = Camera_Production)) + 
  geom_path(aes(y = Camera_Production, color = "Camera Production"), size = 1.5) +
  geom_path(aes(y = USA_Imports, color = "USA Imports"), size = 1.5) +
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
       title = "Japanese Camera Production and USA Imports of Japanese Cameras\n (1945-1960)",
       caption = "Source: Nelson, P.A. (1998). Rivalry and cooperation: \nHow the Japanese photography industry went global, pp. 14, 74.")
```

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20static-1.png)

tweenR
------

To create smoother animations between data points we can use [tweenr](https://github.com/thomasp85/tweenr), a package created by Thomas Pedersen which allows you to interpolate your data between different states. Although like in this example, it is highly complementary with `gganimate`, it can be used in many other cases as well! To show you how this interpolation works, I manually created a small example. Let's say you have a data set like this:

``` r
tribble(
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
```

    ## # A tibble: 8 x 2
    ##    year   num
    ##   <dbl> <dbl>
    ## 1  1950  56.0
    ## 2  1951  59.0
    ## 3  1952  64.0
    ## 4  1953  67.0
    ## 5  1954  69.0
    ## 6  1955  74.0
    ## 7  1956  78.0
    ## 8  1957  83.0

So in a time series plot, as in the steel production plot, it will transition a bit awkwardly from point to point. This is where interpolation can help! By creating a lot of smaller data points in between the main data points you can create something like this:

``` r
tribble(
  ~year, ~num,
  1950.0, 56.0,
  1950.1, 56.3,
  1950.2, 56.6,
  1950.3, 56.9,
  1950.4, 57.2,
  1950.5, 57.5,
  1950.6, 57.8,
  1950.7, 58.1,
  1950.8, 58.4,
  1950.9, 58.7,
  1951.0, 59.0   # etc.
)
```

    ## # A tibble: 11 x 2
    ##     year   num
    ##    <dbl> <dbl>
    ##  1  1950  56.0
    ##  2  1950  56.3
    ##  3  1950  56.6
    ##  4  1950  56.9
    ##  5  1950  57.2
    ##  6  1950  57.5
    ##  7  1951  57.8
    ##  8  1951  58.1
    ##  9  1951  58.4
    ## 10  1951  58.7
    ## 11  1951  59.0

(only showing between 1950 and 1951 to save space...) Therefore, making the transitions in a time series animation appear "smoother"!

I was having a bit of trouble creating the list of data frames necessary to provide as the input for the `tween_states()` function. I asked for help on R Studio Community and user **alistaire** replied with a great answer [here](https://community.rstudio.com/t/tweenr-gganimate-with-line-plot/4027). Below, I'll go through what he did step-by-step.

First, we use `map()` to create a list of data frames containing the data for each row in `Japan_Camera` (16) with the same number of observations in `Japan_Camera`. However, the observations in each data frame (for the individual rows) that have not been displayed yet are replaced with the values for the previously displayed row.

As a result we have a list of 16 data frames (view shortened to the first 3 to save space). Look carefully at the slight changes in the `Camera_Production` column if you didn't understand the above explanation.

``` r
library(purrr) 
```

    ## 
    ## Attaching package: 'purrr'

    ## The following object is masked from 'package:scales':
    ## 
    ##     discard

``` r
Camera_List <- map(seq(nrow(Japan_Camera)), 
                   ~Japan_Camera[c(seq(.x), rep(.x, nrow(Japan_Camera) - .x)), ])

str(Camera_List, list.len = 4)
```

    ## List of 16
    ##  $ :Classes 'tbl_df', 'tbl' and 'data.frame':    16 obs. of  3 variables:
    ##   ..$ Year             : int [1:16] 1945 1945 1945 1945 1945 1945 1945 1945 1945 1945 ...
    ##   ..$ Camera_Production: int [1:16] 13082 13082 13082 13082 13082 13082 13082 13082 13082 13082 ...
    ##   ..$ USA_Imports      : int [1:16] NA NA NA NA NA NA NA NA NA NA ...
    ##  $ :Classes 'tbl_df', 'tbl' and 'data.frame':    16 obs. of  3 variables:
    ##   ..$ Year             : int [1:16] 1945 1946 1946 1946 1946 1946 1946 1946 1946 1946 ...
    ##   ..$ Camera_Production: int [1:16] 13082 24145 24145 24145 24145 24145 24145 24145 24145 24145 ...
    ##   ..$ USA_Imports      : int [1:16] NA NA NA NA NA NA NA NA NA NA ...
    ##  $ :Classes 'tbl_df', 'tbl' and 'data.frame':    16 obs. of  3 variables:
    ##   ..$ Year             : int [1:16] 1945 1946 1947 1947 1947 1947 1947 1947 1947 1947 ...
    ##   ..$ Camera_Production: int [1:16] 13082 24145 51772 51772 51772 51772 51772 51772 51772 51772 ...
    ##   ..$ USA_Imports      : int [1:16] NA NA NA NA NA NA NA NA NA NA ...
    ##  $ :Classes 'tbl_df', 'tbl' and 'data.frame':    16 obs. of  3 variables:
    ##   ..$ Year             : int [1:16] 1945 1946 1947 1948 1948 1948 1948 1948 1948 1948 ...
    ##   ..$ Camera_Production: int [1:16] 13082 24145 51772 53016 53016 53016 53016 53016 53016 53016 ...
    ##   ..$ USA_Imports      : int [1:16] NA NA NA NA NA NA NA NA NA NA ...
    ##   [list output truncated]

Now that we have the list of data frames ready we can use the `tween_states()` function to specify how the transitions between the "states" of our data are created. Each "state" will be the individual data frames that we just created! `tweenlength` is length of the transitions between state to state, `statelength` is the pause at each state, `ease` is the function used for the transitions, and `nframes` is the number of frames to generate for the animation.

``` r
library(tweenr)

Camera_Tween <- Camera_List %>% 
    tween_states(tweenlength = 3, statelength = 2, ease = 'linear', nframes = 200) 

glimpse(Camera_Tween)
```

    ## Observations: 3,456
    ## Variables: 4
    ## $ Year              <dbl> 1945, 1945, 1945, 1945, 1945, 1945, 1945, 19...
    ## $ Camera_Production <dbl> 13082, 13082, 13082, 13082, 13082, 13082, 13...
    ## $ USA_Imports       <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ...
    ## $ .frame            <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,...

Now from the original 16 rows/observations we now have 1712 rows due to creating the interpolating frames! The `tween_states()` function has added a `.frame` variable that corresponds with the expanded data set.

After saving everything as a ggplot object, we can use the `ani.options()` function to specify a variety of animation options, here we speed up the time interval between frames. Then, as before, we can gganimate and **Voila**!

``` r
Camera_Animate <- Camera_Tween %>% 
    ggplot(aes(x = Year, y = Camera_Production, frame = .frame)) + 
    geom_path(aes(y = Camera_Production, 
                  color = "Camera Production", frame = .frame), size = 1.5) +
    geom_path(aes(y = USA_Imports, 
                  color = "USA Imports", frame = .frame), size = 1.5) +
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
          legend.title = element_blank(),
          panel.grid.minor.y = element_blank()) +
    labs(x = "Year", y = "Japanese Cameras (Units)", 
         title = "Japanese Camera Production and USA Imports of Japanese Cameras\n (1945-1960)", 
         caption = "Source: Nelson, P.A. (1998). Rivalry and cooperation: \nHow the Japanese photography industry went global, pp. 14, 74.")
```

    ## Warning: Ignoring unknown aesthetics: frame

    ## Warning: Ignoring unknown aesthetics: frame

``` r
animation::ani.options(interval = 0.05)   

gganimate(Camera_Animate)
```

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-1.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-2.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-3.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-4.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-5.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-6.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-7.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-8.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-9.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-10.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-11.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-12.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-13.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-14.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-15.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-16.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-17.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-18.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-19.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-20.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-21.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-22.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-23.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-24.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-25.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-26.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-27.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-28.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-29.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-30.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-31.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-32.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-33.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-34.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-35.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-36.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-37.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-38.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-39.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-40.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-41.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-42.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-43.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-44.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-45.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-46.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-47.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-48.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-49.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-50.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-51.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-52.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-53.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-54.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-55.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-56.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-57.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-58.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-59.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-60.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-61.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-62.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-63.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-64.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-65.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-66.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-67.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-68.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-69.png)

    ## Warning: Removed 16 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-70.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-71.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-72.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-73.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-74.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-75.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-76.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-77.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-78.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-79.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-80.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-81.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-82.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-83.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-84.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-85.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-86.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-87.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-88.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-89.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-90.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-91.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-92.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-93.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-94.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-95.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-96.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-97.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-98.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-99.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-100.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-101.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-102.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-103.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-104.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-105.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-106.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-107.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-108.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-109.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-110.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-111.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-112.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-113.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-114.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-115.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-116.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-117.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-118.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-119.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-120.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-121.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-122.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-123.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-124.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-125.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-126.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-127.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-128.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-129.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-130.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-131.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-132.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-133.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-134.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-135.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-136.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-137.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-138.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-139.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-140.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-141.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-142.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-143.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-144.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-145.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-146.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-147.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-148.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-149.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-150.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-151.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-152.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-153.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-154.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-155.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-156.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-157.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-158.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-159.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-160.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-161.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-162.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-163.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-164.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-165.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-166.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-167.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-168.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-169.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-170.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-171.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-172.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-173.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-174.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-175.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-176.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-177.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-178.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-179.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-180.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-181.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-182.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-183.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-184.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-185.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-186.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-187.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-188.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-189.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-190.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-191.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-192.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-193.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-194.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-195.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-196.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-197.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-198.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-199.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-200.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-201.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-202.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-203.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-204.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-205.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-206.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-207.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-208.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-209.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-210.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-211.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-212.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-213.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-214.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-215.png)

    ## Warning: Removed 5 rows containing missing values (geom_path).

![](japan_postwar_recovery_files/figure-markdown_github/camera%20animate-216.png)

Cotton textiles industry
------------------------

As a result of the loss of its overseas territories, Japan lost 2.75 million cotton spindles from China and Manchuria with a further 210,000 in Korea (Fletcher, 2006). With the United States' help, however, the cotton textiles industry became the leading export industry from 1946-1960 (taking up around 59% of the dollar value of all Japanese exports) which allowed for raw material and food imports into devastated Japan (Fletcher, 2006; Sugihara, 1999).

The United States pursued this initiative due to the accumulation of raw cotton by the Commodity Credit Corporations from various *New Deal* policies dating back to the Great Depression; exporting this raw cotton to Japan would increase government revenue and raise cotton prices for the benefit of American producers (Fletcher, 2006; Abe, 2005).

The American government also believed that this course of action would help relieve American taxpayer the burden of paying aid/subsidies for Japanese imports of basic necessities by allowing Japan to sustain itself through its textile exports as well as reinvest the dollars earned into other recovering industries (Abe, 2005; Fletcher, 2006).

As a result, by 1951, Japan had become the largest exporter of cotton textiles in the world with a large percentage of the approximately 2.9 billion square yards produced each year (1955-1970) going to the United States (Abe, 2005). As the domestic American textile market applied pressure to install export quotas, the share of Japanese textile exports fell from 72% in 1957 to a mere 20% in 1960. However, the entry of other Asian countries into the American market made these quotas against Japanese exports meaningless and the Japanese economy began to focus on other industries from the 1960s onward, most famously, the automobile industry.

Highcharter
-----------

The `Highcharter` package by Joshua Kunst allows you to access the `Highcharts` JavaScript visualization library and can seamlessly fit into your workflow as it uses `%>%` to connect functions. For some examples check this [link](http://jkunst.com/highcharter/) out. To find out more about the myriad of options available to build your chart, check out the Highcharts API reference [here](https://api.highcharts.com/highcharts/). For the more advanced customizations you might need to know JS and/or HTML but Stack Overflow posts can help you out (tags: `highcharts` & `r-highcharter`)! Another great tutorial to learn `Highcharter` from is [here](http://paldhous.github.io/ucb/2016/dataviz/week13.html), another page out of Peter Aldhous' lecture notes!

What I did here was to show across 2 different y-axes, the total amount of Japanese textile exports and the percentage of those exports heading to the USA. Instead of having them on one graph, I moved the axes labels to opposite sides and had each time series split up the y-axis space between them using the `hc_yAxis_multiples()` function. To make things easier to understand, I had the tooltip show the data for both time series using `hc_tooltip()` and customizing the labels for each series inside the tooltip with the `tooltip =` argument inside `hc_add_series()` function.

``` r
Japan_Textiles <- read_csv("Data/JapanCottonTextileExports(1946-1960).csv",
                           col_names = c("Year", "total_exports", "exports_to_USA",
                                         "percentage_exports_USA"),
                           skip = 1)
```

    ## Parsed with column specification:
    ## cols(
    ##   Year = col_integer(),
    ##   total_exports = col_integer(),
    ##   exports_to_USA = col_integer(),
    ##   percentage_exports_USA = col_double()
    ## )

``` r
library(htmlwidgets)
library(highcharter)
```

    ## Highcharts (www.highcharts.com) is a Highsoft software product which is

    ## not free for commercial and Governmental use

``` r
colors <- RColorBrewer::brewer.pal(2, "Set1")
```

    ## Warning in RColorBrewer::brewer.pal(2, "Set1"): minimal value for n is 3, returning requested palette with 3 different levels

``` r
highchart() %>%
   hc_colors(colors) %>% 
   hc_yAxis_multiples(
     list(top = "0%", height = "30%", lineWidth = 3, opposite = TRUE, 
          title = list(text = "% of Total Exports")),
     list(top = "30%", height = "70%", 
          title = list(text = "Total Exports (Millions sq. yards)"))
   ) %>% 
   hc_xAxis(title = list(text = "Year"), 
            categories = Japan_Textiles$Year,
            tickInterval = 1) %>% 
   hc_add_series(name = "Total Exports", 
                 data = Japan_Textiles, hcaes(Year, total_exports), 
                 type = "spline", yAxis = 1,
                 tooltip = list(valueSuffix = " M.Sq.Yards")) %>% 
   hc_add_series(name = "Percentage (%) of Exports to USA", 
                 data = Japan_Textiles, hcaes(Year, percentage_exports_USA), 
                 type = "spline", yAxis = 0,
                 tooltip = list(valueSuffix = "%", valueDecimals = "1")) %>% 
   hc_tooltip(shared = TRUE,
              borderColor = "black",
              headerFormat = '<span style = "font-size: 14px"><b>{point.key}</b></span><br/>'
              ) %>% 
   hc_title(text = "Japan's Exports of Cotton Textiles (1946-1960)")
```

    ## PhantomJS not found. You can install it with webshot::install_phantomjs(). If it is installed, please make sure the phantomjs executable can be found via the PATH variable.

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-7beccee6fad965baced6">{"x":{"hc_opts":{"title":{"text":"Japan's Exports of Cotton Textiles (1946-1960)"},"yAxis":[{"top":"0%","height":"30%","lineWidth":3,"opposite":true,"title":{"text":"% of Total Exports"}},{"top":"30%","height":"70%","title":{"text":"Total Exports (Millions sq. yards)"}}],"credits":{"enabled":false},"exporting":{"enabled":false},"plotOptions":{"series":{"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"},"bubble":{"minSize":5,"maxSize":25}},"annotationsOptions":{"enabledButtons":false},"tooltip":{"delayForDisplay":10,"shared":true,"borderColor":"black","headerFormat":"<span style = \"font-size: 14px\"><b>{point.key}<\/b><\/span><br/>"},"colors":["#E41A1C","#377EB8","#4DAF4A"],"xAxis":{"title":{"text":"Year"},"categories":[1946,1948,1951,1954,1957,1960],"tickInterval":1},"series":[{"group":"group","data":[{"Year":1946,"total_exports":1,"exports_to_USA":null,"percentage_exports_USA":null,"x":1946,"y":1},{"Year":1948,"total_exports":408,"exports_to_USA":9,"percentage_exports_USA":2.205882353,"x":1948,"y":408},{"Year":1951,"total_exports":1092,"exports_to_USA":2,"percentage_exports_USA":0.183150183,"x":1951,"y":1092},{"Year":1954,"total_exports":1278,"exports_to_USA":49,"percentage_exports_USA":3.834115806,"x":1954,"y":1278},{"Year":1957,"total_exports":1468,"exports_to_USA":82,"percentage_exports_USA":5.585831063,"x":1957,"y":1468},{"Year":1960,"total_exports":1424,"exports_to_USA":87,"percentage_exports_USA":6.109550562,"x":1960,"y":1424}],"type":"spline","name":"Total Exports","yAxis":1,"tooltip":{"valueSuffix":" M.Sq.Yards"}},{"group":"group","data":[{"Year":1946,"total_exports":1,"exports_to_USA":null,"percentage_exports_USA":null,"x":1946,"y":null},{"Year":1948,"total_exports":408,"exports_to_USA":9,"percentage_exports_USA":2.205882353,"x":1948,"y":2.205882353},{"Year":1951,"total_exports":1092,"exports_to_USA":2,"percentage_exports_USA":0.183150183,"x":1951,"y":0.183150183},{"Year":1954,"total_exports":1278,"exports_to_USA":49,"percentage_exports_USA":3.834115806,"x":1954,"y":3.834115806},{"Year":1957,"total_exports":1468,"exports_to_USA":82,"percentage_exports_USA":5.585831063,"x":1957,"y":5.585831063},{"Year":1960,"total_exports":1424,"exports_to_USA":87,"percentage_exports_USA":6.109550562,"x":1960,"y":6.109550562}],"type":"spline","name":"Percentage (%) of Exports to USA","yAxis":0,"tooltip":{"valueSuffix":"%","valueDecimals":"1"}}]},"theme":{"chart":{"backgroundColor":"transparent"}},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","drillUpText":"Back to {series.name}","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"thousandsSep":" ","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
You can even export what you've made as a standalone web page using the `saveWidget()` function from the `htmlwidgets` package!

Conclusion
----------

Despite the devastation of the Allied bombing campaigns and the initial SCAP policies, the growing tensions of the Cold War and the postwar needs of America became the catalyst for a dramatic heel-turn in economic policy that laid the foundations for a miraculous Japanese recovery. By studying the causes and impacts of external/internal events and policies we can gain clues to tackle the future challenges in rebuilding economies in other war-devastated areas of the world.

Comparison with my original excel graphs
----------------------------------------

-   [Steel industry]()
-   [Camera industry]()
-   [Cotton textile industry]()

To finish off this blog post, just a few thoughts... Doing this mini-project, it was quite nice to go back through some old research and look for more/better data sources as the volume of data available is **always** growing, with older research being digitized daily. Back when I was first doing this research paper, even with PDF versions available, I would usually grab a few actual copies of The Statistical Abstract of the United States from the shelves and flip through them as it really gave me a sense of wonder and I kind of felt the "weight" of history through those hefty volumes which is something that can't really be "felt" from digital sources unfortunately.

References: \* Abe, T. (2005). The restructuring of cotton spinning companies in postwar Japan. (Discussion paper). Graduate School of Economics and Osaka School of International Public Policy.

-   Castle, A.L. (1990). William R. Castle and the postwar transformation of Japan, 1945-1955. The Wisconsin Magazine of History, 74, 125-137.

-   Dingman, R. (1993). The dagger and the gift: The impact of the Korean War on Japan. Journal of American-East Asian Relations, 2, 29-55.

-   Elbaum, B. (2007). How Godzilla ate Pittsburgh: The long rise of the Japanese iron and steel industry, 1900-1973. Social Science Japan Journal, 10, 243-264.

-   Fletcher, W.M. (2006). A miracle of sorts: The Japan Spinners Association and the recovery of the cotton textile industry, 1945-1952. UNC-Chapel Hill.

-   Kingston, J. (2010). Japan in transformation, 1945-2010. London: Routledge.

-   Miller, J.M. (2011). The struggle to rearm Japan: Negotiating the Cold War state in US-Japanese relations. Journal of Contemporary History, 46, 82-108.

-   Nakamura, T. & Odaka, K. (2003). The economic history of Japan: 1600-1900. (Vol. 3). (Noah S. Brannen, Trans.) Oxford University: Oxford University Press.

-   Nelson, P.A. (1998). Rivalry and cooperation: How the Japanese photography industry went global. (Unpublished doctoral dissertation). University of Warwick, UK.

-   Ohno, K. (2006). The economic development of Japan. Tokyo, Japan: GRIPS Development Forum

-   Schonberger, H. (1982). U.S. policy in post-war Japan: The retreat for liberalism. Science & Society, 46, 39-59.

-   Sugihara, K. (1999). International circumstances surrounding the postwar Japanese cotton textile industry. (Discussion paper). Graduate School of Economics and Osaka School of International Public Policy.

-   U.S. Census Bureau. (1955). Statistical Abstract of the United States: 1954. Washington, DC: U.S. Government Printing Office.

-   ... Statistical Abstract of the United States, 1955 to 1962 ...

Further Reading: * * * *
