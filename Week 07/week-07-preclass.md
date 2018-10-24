Simulations Pre-Class Project
================
Due March 13, 2017 at 5:00pm

<style type="text/css">
.table {

    width: 80%;
    margin-left:10%; 
    margin-right:10%;
}
</style>

\#Project Goals:

With this project we will simulate a famoues probability problem. This
will not require knowledge of probability or statistics but only the
logic to follow the steps in order to simulate this problem. This is one
way to solve problems by using the computer.

1.  **Gambler’s Ruin**: Suppose you have a bankroll of $1000 and make
    bets of $100 on a fair game. By simulating the outcome directly for
    at most 5000 iterations of the game (or hands), estimate: hundredth
    bet.

<!-- end list -->

``` r
bankroll<-1000
bet<-100
iterations<-5000


# hands <- rbinom(n = iter, size = 1, prob = 0.5)
game <- function(balance, b, iter){
  h<-vector(mode = "numeric", length = iter)
  for (t in 1:iter){
    tempbal<- balance
    i = 0
    while (tempbal>0 & i<=5000) {
      coin.tosses<-rbinom(n = 1, size = 1, prob = 0.5) #set tail equal to 0 and head equal to 1.
      if(coin.tosses==0) {
        tempbal<- tempbal - b
      } else {
        tempbal<-tempbal + b
      }
      i = i + 1
    }
    h[t]<-i
  }
  return(h)
}
```

    a. the probability that you have "busted" (lost all your money) by the time you have placed your one 

``` r
# hands<-replicate(iter, game(bankroll,bet))
simul<-game(bankroll,bet,iterations)
bust.100<-length(simul[simul<=100])/iterations
bust.100
```

    ## [1] 0.322

2.  the probability that you have busted by the time you have placed
    your five hundredth bet by simulating the outcome directly.

<!-- end list -->

``` r
bust.500<-length(simul[simul<=500])/iterations
bust.500
```

    ## [1] 0.658

3.  the mean time you go bust, given that you go bust within the first
    5000 hands.

<!-- end list -->

``` r
mean.bust<-mean(simul[simul<=5000])
mean.bust
```

    ## [1] 536

4.  the mean and variance of your bankroll after 100 hands (including
    busts).

5.  the mean and variance of your bankroll after 500 hands (including
    busts).

Note: you *must* stop playing if your player has gone bust. How will you
handle this in the `for` loop?

2.  **Markov Chains**. Suppose you have a game where the probability of
    winning on your first hand is 48%; each time you win, that
    probability goes up by one percentage point for the next game (to a
    maximum of 100%, where it must stay), and each time you lose, it
    goes back down to 48%. Assume you cannot go bust and that the size
    of your wager is a constant $100.
    1.  Is this a fair game? Simulate one hundred thousand sequential
        hands to determine the size of your return. Then repeat this
        simulation 99 more times to get a range of values to calculate
        the expectation.
    2.  Repeat this process but change the starting probability to a new
        value within 2% either way. Get the expected return after 100
        repetitions. Keep exploring until you have a return value that
        is as fair as you can make it. Can you do this automatically?
    3.  Repeat again, keeping the initial probability at 48%, but this
        time change the probability increment to a value different from
        1%. Get the expected return after 100 repetitions. Keep changing
        this value until you have a return value that is as fair as you
        can make it.
