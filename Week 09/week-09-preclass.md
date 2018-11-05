Basic Webscraping
================

<style type="text/css">
.table {

    width: 80%;
    margin-left:10%; 
    margin-right:10%;
}
</style>

## Exercises

1.  Read the HTML content of the following URL with a variable called
    webpage: <https://money.cnn.com/data/us_markets/> At this point, it
    will also be useful to open this web page in your browser.

<!-- end list -->

``` r
library(httr)
library(rvest)
```

    ## Loading required package: xml2

``` r
url<- "https://money.cnn.com/data/us_markets/"
webpage_data <- GET(url)
webpage<- content(webpage_data)
```

2.  Get the session details (status, type, size) of the above mentioned
    URL.

<!-- end list -->

``` r
webpage_data
```

    ## Response [https://money.cnn.com/data/us_markets/]
    ##   Date: 2018-11-05 15:29
    ##   Status: 200
    ##   Content-Type: text/html; charset=utf-8
    ##   Size: 95.5 kB
    ## <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
    ## <html>
    ## <head>
    ##  <meta http-equiv="x-ua-compatible" content="IE=Edge"/>
    ##  <title>U.S. Stock Market Data - Dow Jones, Nasdaq, S&amp;P500 - CNNMone...
    ##  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    ##  <META Name = "Description" CONTENT = "Complete financial stock market c...
    ##  <META Name = "keywords" CONTENT = "business news,financial news,stocks,...
    ##  <link rel="canonical" href="https://money.cnn.com/data/us_markets/">
    ##  <link rel="stylesheet" href="https://i.cdn.turner.com/money/.e/ssi/css/...
    ## ...

3.  Extract all of the sector names from the “Stock Sectors” table
    (bottom left of the web page.)

<!-- end list -->

``` r
library(XML)
```

    ## Warning: package 'XML' was built under R version 3.5.1

    ## 
    ## Attaching package: 'XML'

    ## The following object is masked from 'package:rvest':
    ## 
    ##     xml

``` r
library(RCurl)
```

    ## Warning: package 'RCurl' was built under R version 3.5.1

    ## Loading required package: bitops

``` r
webpage<- getURL(url)
sector_names <-readHTMLTable(webpage, which = 2, stringsAsFactors = FALSE )[,1]
sector_names
```

    ##  [1] "Communications"        "Consumer Durables"    
    ##  [3] "Consumer Non-Durables" "Commercial Services"  
    ##  [5] "Electronic Technology" "Energy Minerals"      
    ##  [7] "Finance"               "Health Services"      
    ##  [9] "Retail Trade"          "Technology Services"  
    ## [11] "Transportation"        "Utilities"

4.  Extract all of the “3 Month % Change” values from the “Stock
    Sectors”
table.

<!-- end list -->

``` r
three.months.ch<-readHTMLTable(webpage, which = 2, stringsAsFactors = FALSE )[,2]
three.months.ch
```

    ##  [1] "+3.85%" "-7.45%" "+0.28%" "-2.30%" "-3.76%" "-8.14%" "-6.07%"
    ##  [8] "+3.10%" "-2.89%" "-5.35%" "-4.72%" "-0.29%"

5.  Extract the table “What’s Moving” (top middle of the web page) into
    a data-frame.

<!-- end list -->

``` r
whatsmoving<-readHTMLTable(webpage, which = 1, stringsAsFactors = FALSE)
whatsmoving
```

    ##         Gainers & Losers\n\t\t Price\n\t\t Change\n\t\t % Change\n\t
    ## 1                EQTEQT Corp     34.20      +1.57      +4.81%
    ## 2   COGCabot Oil & Gas Co...     25.66      +1.11      +4.52%
    ## 3  BRKBBerkshire Hathaway...    215.58      +9.01      +4.36%
    ## 4             APAApache Corp     37.28      +1.34      +3.73%
    ## 5                LLoews Corp     47.92      +1.63      +3.52%
    ## 6              SYYSysco Corp     63.92      -7.37     -10.34%
    ## 7              QRVOQorvo Inc     67.65      -6.35      -8.58%
    ## 8   AMDAdvanced Micro Dev...     19.07      -1.16      -5.73%
    ## 9  ATVIActivision Blizzar...     65.40      -3.59      -5.20%
    ## 10 AKAMAkamai Technologie...     68.32      -3.44      -4.79%

6.  Re-construct all of the links from the first column of the “What’s
    Moving” table. Hint: the base URL is “<https://money.cnn.com>”

<!-- end list -->

``` r
webxml<-read_html(url)
linkurl<-"https://money.cnn.com"
links<-html_nodes(webxml, css = ".wsod_dataTableBig") %>%
  html_nodes(css = ".wsod_symbol") %>%
  html_attr("href") 

links<-paste0(linkurl,links)
links
```

    ##  [1] "https://money.cnn.com/quote/quote.html?symb=EQT" 
    ##  [2] "https://money.cnn.com/quote/quote.html?symb=COG" 
    ##  [3] "https://money.cnn.com/quote/quote.html?symb=BRKB"
    ##  [4] "https://money.cnn.com/quote/quote.html?symb=APA" 
    ##  [5] "https://money.cnn.com/quote/quote.html?symb=L"   
    ##  [6] "https://money.cnn.com/quote/quote.html?symb=SYY" 
    ##  [7] "https://money.cnn.com/quote/quote.html?symb=QRVO"
    ##  [8] "https://money.cnn.com/quote/quote.html?symb=AMD" 
    ##  [9] "https://money.cnn.com/quote/quote.html?symb=ATVI"
    ## [10] "https://money.cnn.com/quote/quote.html?symb=AKAM"

7.  Extract the titles under the “Latest News” section (bottom middle of
    the web page.)

<!-- end list -->

``` r
latestnews<-html_nodes(webxml, css = ".clearfix") %>%
  html_nodes(css = ".wsod_fRight") %>%
  html_nodes(css = "#section_latestnews") %>%
  html_nodes("li") %>%
  html_text()

latestnews
```

    ##  [1] "Lowe's is closing 51 stores in the US and Canada"                                       
    ##  [2] "FedEx is hiking rates again"                                                            
    ##  [3] "Iran is still exporting oil as sanctions deadline passes"                               
    ##  [4] "Amazon offers free shipping on all orders for the holidays"                             
    ##  [5] "'SNL' skewers Fox News' coverage of the migrant march"                                  
    ##  [6] "Applebee's is betting on stress eaters, and it's paying off"                            
    ##  [7] "GM is getting into the e-bike business"                                                 
    ##  [8] "Elon Musk says he would no longer accept Saudi investment"                              
    ##  [9] "Jet is going where Walmart can't"                                                       
    ## [10] "Starbucks wants to open 2,100 new stores next year"                                     
    ## [11] "Feds charge ex-Goldman bankers with crimes related to Malaysian investment fund scandal"
    ## [12] "Hanes slashes its outlook because of Sears' bankruptcy"

8.  To understand the structure of the data in a web page, it is often
    useful to know what the underlying attributes are of the text you
    see. Extract the attributes (and their values) of the HTML element
    that holds the timestamp underneath the “What’s Moving” table.

<!-- end list -->

``` r
timestamp<- html_nodes(webxml, css = ".clearfix") %>%
  html_nodes(css = ".wsod_fRight") %>%
  html_nodes(css = ".wsod_disclaimer")

timestamp_attr<- html_attrs(timestamp)
timestamp_value<- html_text(timestamp)
timestamp_attr
```

    ## [[1]]
    ##                         class 
    ## "wsod_fRight wsod_disclaimer"

``` r
timestamp_value
```

    ## [1] "Data as of 10:11am ET"

9.  Extract the values of the blue percentage-bars from the “Trending
    Tickers” table (bottom right of the web
page.)

<!-- end list -->

``` r
#tickerstable<-readHTMLTable(webpage, which = 3, stringsAsFactors= FALSE) %>%
 tickerstable<- html_nodes(webxml, css = ".cnnBody_Right") %>%
  html_nodes(css = ".mod-mostpop") %>%
  html_nodes("tr") %>%
  html_nodes(css = ".scale") %>%
  html_nodes(css = ".bars") %>%
  html_attrs() %>%
  unlist()

tickerstable<-as.numeric(gsub("bars pct", "", tickerstable))
  

tickerstable
```

    ##  [1] 100  60  60  60  50  50  50  40  40  40

Hint: in this case, the values are stored under the “class” attribute.
10. Get the links of all of the “svg” images on the web page.
