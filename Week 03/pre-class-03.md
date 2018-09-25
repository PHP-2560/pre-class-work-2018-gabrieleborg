pre-class03
================
Gabriele Borg
September24, 2018

# pre-class

Make sure you commit this often with meaningfull messages.

### Getting Started

We will work with the dataset called
[gapminder](https://github.com/jennybc/gapminder), this is a cleaned up
version from [Gapminder Data](http://www.gapminder.org/data/). Gapminder
contains a lot of great data on all of the nations of the world. We
first need to install the gapminder package in R.

    install.packages("gapminder")

``` r
library(dplyr)
```

    ## Warning: package 'dplyr' was built under R version 3.5.1

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(gapminder)
```

    ## Warning: package 'gapminder' was built under R version 3.5.1

``` r
gapminder
```

    ## # A tibble: 1,704 x 6
    ##    country     continent  year lifeExp      pop gdpPercap
    ##    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
    ##  1 Afghanistan Asia       1952    28.8  8425333      779.
    ##  2 Afghanistan Asia       1957    30.3  9240934      821.
    ##  3 Afghanistan Asia       1962    32.0 10267083      853.
    ##  4 Afghanistan Asia       1967    34.0 11537966      836.
    ##  5 Afghanistan Asia       1972    36.1 13079460      740.
    ##  6 Afghanistan Asia       1977    38.4 14880372      786.
    ##  7 Afghanistan Asia       1982    39.9 12881816      978.
    ##  8 Afghanistan Asia       1987    40.8 13867957      852.
    ##  9 Afghanistan Asia       1992    41.7 16317921      649.
    ## 10 Afghanistan Asia       1997    41.8 22227415      635.
    ## # ... with 1,694 more rows

### Pre-Class Problems

Use **dplyr** functions to address the following questions:

1.  How many unique countries are represented per continent?

<!-- end list -->

``` r
gapminder %>%
  group_by(continent) %>%
  distinct(country) %>%
  count()
```

    ## # A tibble: 5 x 2
    ## # Groups:   continent [5]
    ##   continent     n
    ##   <fct>     <int>
    ## 1 Africa       52
    ## 2 Americas     25
    ## 3 Asia         33
    ## 4 Europe       30
    ## 5 Oceania       2

2.  Which European nation had the lowest GDP per capita in 1997?

<!-- end list -->

``` r
gapminder %>%
  filter(continent == "Europe", year == 1997) %>%
  filter(gdpPercap == min(gdpPercap))
```

    ## # A tibble: 1 x 6
    ##   country continent  year lifeExp     pop gdpPercap
    ##   <fct>   <fct>     <int>   <dbl>   <int>     <dbl>
    ## 1 Albania Europe     1997    73.0 3428038     3193.

3.  According to the data available, what was the average life
    expectancy across each continent in the 1980s?

<!-- end list -->

``` r
gapminder %>%
  filter(year>=1980 & year<1990) %>%
  group_by(continent) %>%
  summarise(avg_life_exp = mean(lifeExp))
```

    ## # A tibble: 5 x 2
    ##   continent avg_life_exp
    ##   <fct>            <dbl>
    ## 1 Africa            52.5
    ## 2 Americas          67.2
    ## 3 Asia              63.7
    ## 4 Europe            73.2
    ## 5 Oceania           74.8

4.  What 5 countries have the highest total GDP over all years combined?

<!-- end list -->

``` r
gapminder %>%
  group_by(country) %>%
  summarise(tot_GDP = sum(gdpPercap*pop)) %>%
  arrange(desc(tot_GDP)) %>%
  top_n(n = 5)
```

    ## Selecting by tot_GDP

    ## # A tibble: 5 x 2
    ##   country        tot_GDP
    ##   <fct>            <dbl>
    ## 1 United States  7.68e13
    ## 2 Japan          2.54e13
    ## 3 China          2.04e13
    ## 4 Germany        1.95e13
    ## 5 United Kingdom 1.33e13

5.  What countries and years had life expectancies of *at least* 80
    years? *N.b. only output the columns of interest: country, life
    expectancy and year (in that order).*

<!-- end list -->

``` r
gapminder %>%
  filter(lifeExp>80) %>%
  select(country, lifeExp, year)
```

    ## # A tibble: 21 x 3
    ##    country          lifeExp  year
    ##    <fct>              <dbl> <int>
    ##  1 Australia           80.4  2002
    ##  2 Australia           81.2  2007
    ##  3 Canada              80.7  2007
    ##  4 France              80.7  2007
    ##  5 Hong Kong, China    81.5  2002
    ##  6 Hong Kong, China    82.2  2007
    ##  7 Iceland             80.5  2002
    ##  8 Iceland             81.8  2007
    ##  9 Israel              80.7  2007
    ## 10 Italy               80.2  2002
    ## # ... with 11 more rows

6.  What 10 countries have the strongest correlation (in either
    direction) between life expectancy and per capita GDP?

<!-- end list -->

``` r
gapminder %>%
  group_by(country) %>%
  summarise(cor = cor(lifeExp,gdpPercap)) %>%
  mutate(abs_cor = abs(cor)) %>%
  arrange(desc(abs_cor)) %>%
  top_n(n = 10)
```

    ## Selecting by abs_cor

    ## # A tibble: 10 x 3
    ##    country          cor abs_cor
    ##    <fct>          <dbl>   <dbl>
    ##  1 France         0.996   0.996
    ##  2 Austria        0.993   0.993
    ##  3 Belgium        0.993   0.993
    ##  4 Norway         0.992   0.992
    ##  5 Oman           0.991   0.991
    ##  6 United Kingdom 0.990   0.990
    ##  7 Italy          0.990   0.990
    ##  8 Israel         0.988   0.988
    ##  9 Denmark        0.987   0.987
    ## 10 Australia      0.986   0.986

7.  Which combinations of continent (besides Asia) and year have the
    highest average population across all countries? *N.b. your output
    should include all results sorted by highest average population*.
    With what you already know, this one may stump you. See [this
    Q\&A](http://stackoverflow.com/q/27207963/654296) for how to
    `ungroup` before `arrange`ing. This also [behaves differently in
    more recent versions of
    dplyr](https://github.com/hadley/dplyr/releases/tag/v0.5.0).

<!-- end list -->

``` r
gapminder %>%
  filter(continent!="Asia") %>%
  group_by(continent, year) %>%
  summarise(avg_pop = mean(pop)) %>%
  arrange(desc(avg_pop))
```

    ## # A tibble: 48 x 3
    ## # Groups:   continent [4]
    ##    continent  year   avg_pop
    ##    <fct>     <int>     <dbl>
    ##  1 Americas   2007 35954847.
    ##  2 Americas   2002 33990910.
    ##  3 Americas   1997 31876016.
    ##  4 Americas   1992 29570964.
    ##  5 Americas   1987 27310159.
    ##  6 Americas   1982 25211637.
    ##  7 Americas   1977 23122708.
    ##  8 Americas   1972 21175368.
    ##  9 Europe     2007 19536618.
    ## 10 Europe     2002 19274129.
    ## # ... with 38 more rows

8.  Which three countries have had the most consistent population
    estimates (i.e. lowest standard deviation) across the years of
    available data?

<!-- end list -->

``` r
gapminder %>%
  group_by(country) %>%
  summarise(sd = sd(pop)) %>%
  arrange(sd) %>%
  top_n(n = -3)
```

    ## Selecting by sd

    ## # A tibble: 3 x 2
    ##   country                   sd
    ##   <fct>                  <dbl>
    ## 1 Sao Tome and Principe 45906.
    ## 2 Iceland               48542.
    ## 3 Montenegro            99738.

9.  Subset **gm** to only include observations from 1992 and store the
    results as **gm1992**. What kind of object is this?

<!-- end list -->

``` r
gm1992 <- 
  gapminder %>%
  filter(year==1992)
  
class(gm1992)
```

    ## [1] "tbl_df"     "tbl"        "data.frame"

10. Which observations indicate that the population of a country has
    *decreased* from the previous year **and** the life expectancy has
    *increased* from the previous year? See [the vignette on window
    functions](https://cran.r-project.org/web/packages/dplyr/vignettes/window-functions.html).

<!-- end list -->

``` r
gapminder %>%
  filter(pop<lag(pop) & lifeExp > lag(lifeExp))
```

    ## # A tibble: 53 x 6
    ##    country                continent  year lifeExp      pop gdpPercap
    ##    <fct>                  <fct>     <int>   <dbl>    <int>     <dbl>
    ##  1 Afghanistan            Asia       1982    39.9 12881816      978.
    ##  2 Albania                Europe     1952    55.2  1282697     1601.
    ##  3 Belgium                Europe     1952    68    8730405     8343.
    ##  4 Bosnia and Herzegovina Europe     1992    72.2  4256013     2547.
    ##  5 Bosnia and Herzegovina Europe     1997    73.2  3607000     4766.
    ##  6 Bulgaria               Europe     2002    72.1  7661799     7697.
    ##  7 Bulgaria               Europe     2007    73.0  7322858    10681.
    ##  8 Canada                 Americas   1952    68.8 14785584    11367.
    ##  9 Chile                  Americas   1952    54.7  6377619     3940.
    ## 10 Costa Rica             Americas   1952    57.2   926317     2627.
    ## # ... with 43 more rows
