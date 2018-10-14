#exercises from pre-class 06 readings

# define the rescale function
rescale01 <- function(x) {
  rng <- range(x, na.rm = FALSE, finite = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}

# run with infinite value 
x <- c(1:10, Inf)

rescale01(x)

# what if na.rm set to FALSE and x contains missing value?
#set na.rm to FALSE
x <- c(1:10, NA)

rescale01(x) # it seems it doesn't change nothing....

# 2.map infinite and -inf to 1 and 0
rescale01b <- function(x) {
  x[x==-Inf] <- 0
  x[x==Inf] <- 1
  rng <- range(x, na.rm = TRUE, finite = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}

x<-c(1:10, -Inf, Inf)

rescale01b(x) 

# 3.turn snippets into functions
mean(is.na(x))

x<- c(1:10, NA)

share_missing<- function(x) {
  is_missing <- is.na(x)
  share_mis<-mean(is_missing)
  return(paste0("The vector contains ", share_mis, " percentage of missing values"))
}

share_missing(x)

x / sum(x, na.rm = TRUE)

x<-c(1:10)

element_share <- function(x) {
  aggregate_value <- sum(x, na.rm = TRUE)
  elm_share<- x/aggregate_value
  return(elm_share)
}

element_share(x)

sd(x, na.rm = TRUE) / mean(x, na.rm = TRUE)

variation_coeff<- function(x) {
  vec_mean<-mean(x, na.rm = TRUE)
  vec_sd <- sd(x, na.rm = TRUE)
  var_coeff<- vec_sd/vec_mean
  return(var_coeff)
}

variation_coeff(x)

# 4. function for variance and skew of numeric vector
fun_variance<- function(x) {
  n <- length(x)
  n<- n-1
  vec_mean<- mean(x, na.rm = TRUE)
  mean_deviation <- x - vec_mean
  mean_deviation2<-(mean_deviation)^2
  var_numerator<- sum(mean_deviation2)
  computed_variance<- var_numerator/n
  return(computed_variance)
}

fun_variance(x)

x<-c(1,5,6,100)

fun_skew<- function(x) {
  n <- length(x)
  v<- var(x)
  m<- mean(x)
  third.moment<- (1/(n-2))*sum((x -m)^3)
  third.moment/(var(x)^(3/2))
}

fun_skew(x)

# 5.write both_na function
x<-c(1:3, NA, 5:9, NA)
y<-c(1:3, NA, 5:9, NA)

both_na <- function(x,y) {
  if (length(x)!=length(y)) {
    stop("vectors have different length")
  }
  na_x<-which(is.na(x))
  na_y<-which(is.na(y))
  shared_positions<-intersect(na_x, na_y)
  no_na<- length(shared_positions)
  return(no_na)
}

both_na(x,y)

# Fizzbuzz function 
fizzbuzz <- function(x) {
  if(x%%5==0 & x%%3==0) {
    return("fizzbuzz")
  } else if (x%%5==0) {
    return("buzz")
  } else if (x%%3==0) {
    return("fizz")
  } else {
    return(x)
  }
}

fizzbuzz(60)
