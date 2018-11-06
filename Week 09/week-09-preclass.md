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
library(xml2)
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
    ##   Date: 2018-11-06 14:39
    ##   Status: 200
    ##   Content-Type: text/html; charset=utf-8
    ##   Size: 95.7 kB
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

    ##  [1] "+2.98%" "-7.78%" "+1.51%" "-2.66%" "-4.98%" "-7.11%" "-5.16%"
    ##  [8] "+3.71%" "-3.44%" "-6.34%" "-5.13%" "+0.83%"

5.  Extract the table “What’s Moving” (top middle of the web page) into
    a data-frame.

<!-- end list -->

``` r
whatsmoving<-readHTMLTable(webpage, which = 1, stringsAsFactors = FALSE)
whatsmoving
```

    ##         Gainers & Losers\n\t\t Price\n\t\t Change\n\t\t % Change\n\t
    ## 1   BHFBrighthouse Financ...     42.61      +1.69      +4.13%
    ## 2          KHCKraft Heinz Co     52.39      +1.66      +3.27%
    ## 3           FTNTFortinet Inc     74.87      +2.31      +3.18%
    ## 4             PEPPepsiCo Inc    114.39      +3.22      +2.90%
    ## 5         DISCADiscovery Inc     33.20      +0.89      +2.75%
    ## 6  ATVIActivision Blizzar...     64.34      -4.65      -6.74%
    ## 7  AKAMAkamai Technologie...     68.95      -2.81      -3.92%
    ## 8              AAPLApple Inc    201.59      -5.89      -2.84%
    ## 9  AMATApplied Materials ...     34.32      -0.95      -2.69%
    ## 10 SWKSSkyworks Solutions...     83.00      -2.27      -2.66%

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

    ##  [1] "https://money.cnn.com/quote/quote.html?symb=BHF"  
    ##  [2] "https://money.cnn.com/quote/quote.html?symb=KHC"  
    ##  [3] "https://money.cnn.com/quote/quote.html?symb=FTNT" 
    ##  [4] "https://money.cnn.com/quote/quote.html?symb=PEP"  
    ##  [5] "https://money.cnn.com/quote/quote.html?symb=DISCA"
    ##  [6] "https://money.cnn.com/quote/quote.html?symb=ATVI" 
    ##  [7] "https://money.cnn.com/quote/quote.html?symb=AKAM" 
    ##  [8] "https://money.cnn.com/quote/quote.html?symb=AAPL" 
    ##  [9] "https://money.cnn.com/quote/quote.html?symb=AMAT" 
    ## [10] "https://money.cnn.com/quote/quote.html?symb=SWKS"

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

    ##  [1] "Iran is still exporting oil as sanctions deadline passes"             
    ##  [2] "Under Armour: New report on the company's culture was 'tough to read'"
    ##  [3] "Will Colorado deal the shale oil boom a blow?"                        
    ##  [4] "Lowe's is closing 51 stores in the US and Canada"                     
    ##  [5] "Slurpee and go: 7-Eleven introduces mobile checkout"                  
    ##  [6] "FedEx is hiking rates again"                                          
    ##  [7] "Amazon offers free shipping on all orders for the holidays"           
    ##  [8] "'SNL' skewers Fox News' coverage of the migrant march"                
    ##  [9] "Applebee's is betting on stress eaters, and it's paying off"          
    ## [10] "GM is getting into the e-bike business"                               
    ## [11] "Elon Musk says he would no longer accept Saudi investment"            
    ## [12] "Jet is going where Walmart can't"

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

    ## [1] "Data as of Nov 5"

9.  Extract the values of the blue percentage-bars from the “Trending
    Tickers” table (bottom right of the web page.) Hint: in this case,
    the values are stored under the “class”
attribute.

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

10. Get the links of all of the “svg” images on the web page.

<!-- end list -->

``` r
imagelinks<-html_nodes(webxml, css = "#cnnBody") %>%
  xml_find_all("//svg") #can't find any svg images...

imagelinks
```

    ## {xml_nodeset (0)}
