pre-class04
================
Gabriele Borg
October 3, 2018

# pre-class

Make sure you commit this often with meaningful messages.

1.  Read the source code for each of the following three functions,
    puzzle out what they do, and then brainstorm better names.

<!-- end list -->

``` r
check.prefix <- function(string, prefix) {
  substr(string, 1, nchar(prefix)) == prefix
} #This function check for the presence of a given prefix in string that probably are names. Renamed "check.prefix"

remove.last <- function(x) {
  if (length(x) <= 1) return(NULL)
  x[-length(x)]
} # This function removes the last element of a vector or the last row of a matrix. Renamed "remove.last"

match.len <- function(x, y) {
  rep(y, length.out = length(x))
} # This function matches the length of the second vector to that of the first. If the latter is longer, it trim the elements in excess, if it is shorter it duplicates the elements in sequential order. Renamed "match.len"   
```

2.  Compare and contrast rnorm() and MASS::mvrnorm(). How could you make
    them more
consistent?

<!-- end list -->

``` r
# the rnorm() function returns a inputted number of draws from a normal distribution. If not specified, the mean and the sd of the normal are set by default to 0 and 1 repsectively. 
# The MASS::mvnorm() function instead explicitly requires you to enter a value for the mean and one for the standard deviation. 
# To make the functions more consistent we can create a closure for the MASS::mvrnorm function where we specifcy by defaults the mean and the sd of the normal distribution. This creates an outer environment for the function that allows the user to then call it using the pre-specified parameters.  

mvrnorm_standard<- function(n,x=0,y=1) {
  MASS::mvrnorm(n,x,y)
}
```

3.  Use `lapply()` and an anonymous function to find the coefficient of
    variation (the standard deviation divided by the mean) for all
    columns in the mtcars dataset.

<!-- end list -->

``` r
lapply(mtcars, function(x) sd(x)/mean(x))
```

    ## $mpg
    ## [1] 0.2999881
    ## 
    ## $cyl
    ## [1] 0.2886338
    ## 
    ## $disp
    ## [1] 0.5371779
    ## 
    ## $hp
    ## [1] 0.4674077
    ## 
    ## $drat
    ## [1] 0.1486638
    ## 
    ## $wt
    ## [1] 0.3041285
    ## 
    ## $qsec
    ## [1] 0.1001159
    ## 
    ## $vs
    ## [1] 1.152037
    ## 
    ## $am
    ## [1] 1.228285
    ## 
    ## $gear
    ## [1] 0.2000825
    ## 
    ## $carb
    ## [1] 0.5742933

4.  Use vapply() to:
    1.  Compute the standard deviation of every column in a numeric data
        frame.

<!-- end list -->

``` r
# create a numeric dataframe
df<-data.frame(matrix(data = c(23,4,5,6,10,2,1,6,10), ncol = 3, nrow = 3))
names(df) <- c("var1", "var2", "var3")
df
```

    ##   var1 var2 var3
    ## 1   23    6    1
    ## 2    4   10    6
    ## 3    5    2   10

``` r
vapply(df, function(x) sd(x), numeric(1))
```

    ##     var1     var2     var3 
    ## 10.69268  4.00000  4.50925

2.  Compute the standard deviation of every numeric column in a mixed
    data frame. (Hint: youâll need to use vapply()
twice.)

<!-- end list -->

``` r
df2<-cbind(df[1:2], newvar = c("a", "b", "c"), df[3]) # create a new dataframe with a non-numeric column
df2
```

    ##   var1 var2 newvar var3
    ## 1   23    6      a    1
    ## 2    4   10      b    6
    ## 3    5    2      c   10

``` r
vapply(df2[vapply(df2, function(x) is.numeric(x), numeric(1))==1], function(x) sd(x), numeric(1))
```

    ##     var1     var2     var3 
    ## 10.69268  4.00000  4.50925

``` r
# first I select only numerical columns by using vapply and the function is.numeric(). Given the result, I then use another vapply to compute the sd of the previously selected colunms.
```
