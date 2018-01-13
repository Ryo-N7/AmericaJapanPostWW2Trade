Highcharter
-----------

[conclusion](#conclusion) The `Highcharter` package by Joshua Kunst allows you to access the `Highcharts` JavaScript visualization library and can seamlessly fit into your workflow as it uses `%>%` to connect functions. For some examples check this [link](http://jkunst.com/highcharter/) out. To find out more about the myriad of options available to build your chart, check out the Highcharts API reference [here](https://api.highcharts.com/highcharts/). For the more advanced customizations you might need to know JS and/or HTML but Stack Overflow posts can help you out (tags: `highcharts` & `r-highcharter`)! Another great tutorial to learn `Highcharter` from is [here](http://paldhous.github.io/ucb/2016/dataviz/week13.html), another page out of Peter Aldhous' lecture notes!

What I did here was to show across 2 different y-axes, the total amount of Japanese textile exports and the percentage of those exports heading to the USA. Instead of having them on one graph, I moved the axes labels to opposite sides and had each time series split up the y-axis space between them using the `hc_yAxis_multiples()` function. To make things easier to understand, I had the tooltip show the data for both time series using `hc_tooltip()` and customizing the labels for each series inside the tooltip with the `tooltip =` argument inside `hc_add_series()` function.

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
library(scales)  
```

    ## 
    ## Attaching package: 'scales'

    ## The following object is masked from 'package:readr':
    ## 
    ##     col_factor

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
textiles_chart <- highchart() %>%
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
   
saveWidget(textiles_chart, "textiles_chart.html", selfcontained = TRUE, background = "white")
```

You can even export what you've made as a standalone web page using the `saveWidget()` function from the `htmlwidgets` package!

Conclusion
----------

Despite the devastation of the Allied bombing campaigns and the initial SCAP policies, the growing tensions of the Cold War and the postwar needs of America became the catalyst for a dramatic heel-turn in economic policy that laid the foundations for a miraculous Japanese recovery. By studying the causes and impacts of external/internal events and policies we can gain clues to tackle the future challenges in rebuilding economies in other war-devastated areas of the world.


![](..\assets\2018-01-12-japan-postwar-economic-recovery_files\Steel_Animate.gif)

![](..\assets\2018-01-12-japan-postwar-economic-recovery_files\Camera_Animate.gif)
**Voil&#225;**

<iframe src="../assets/2018-01-12-japan-postwar-economic-recovery_files/textiles_chart.html" width="100%" height="500" frameborder="0" marginheight="0" marginwidth="0"></iframe>


