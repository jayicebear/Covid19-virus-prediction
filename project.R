rm(list=ls())
covid <- read.csv('/Users/jaylee/Desktop/Stat 440/project/owid-covid-data.csv')
covid$dates <- as.Date(covid$date)
cv <- subset(covid, dates>='2020-03-01'& dates<='2022-04-01')
cv2 <- cv[,c(3,5,6,11,68)]
cv3 <-  cv2[complete.cases(cv2),]

a <- subset(cv3, location == c('South Korea'))

# This function shows how much the number of coronavirus confirmed
# cases has increased or decreased compared to the previous day.

start=0
len = 1
lambda.vec = rep(NA, nrow(a))
for (i in a[,'new_cases']){
  lambda.vec[1] = 0
  new = i - start
  lambda.vec[len] <- new
  start <- new
  len <- len + 1
}
# i made the column named 'inc_or_dec' to the original data
a[,'inc_or_dec']  <- lambda.vec

# i made a function which predicts whether the confirmed cases would increase or decrease 
# compared to yesterday

incdec <- function(n){
  r <- a[,'inc_or_dec']
  
  result <- 0
  for (i in 1:n){
    if (r[i] <= 0)
      result[i] <- 0 # smaller confirmed cases compared to yesterday 
    else 
      result[i] <- 1 # larger confirmed cases compared to yesterday  
  }
  return(result)
}

# monte carlo simulations 

monteCarlo <- function(n){
  cnt <- 0
  for(i in 1:n){
    cnt <- cnt + sample(incdec(nrow(a)),1) # it calls the incdec function 
  }
  result2 <- cnt / n
  return(result2)
}
#the result of the 0.646 which means it is 64.6% to have 
#larger confirmed cases compared to yesterday
monteCarlo(1000)


monteCarlo2 <- function(n){
  cnt <- 0
  vec2 <- 0
  for(i in 1:n){
    cnt <- cnt + sample(incdec(nrow(a)),1) # it calls the incdec function 
    if(vec2[i]>cnt){
      vec2[i] = vec2[i-1]
    }else{
      vec2[i+1] <-(cnt/i)
    }
  }
  return(vec2)}

monteCarlo2(1000)

library(coda)
# i simulated 100 times using monte carlo function
out = monteCarlo2(100) 
plot(out, type = "l")
abline(h = 0.646, col = "red")

# i simulated 1000 times using monte carlo function
out = monteCarlo2(1000) 
plot(out, type = "l")
abline(h = 0.646, col = "red")

# i simulated 10000 times using monte carlo function
out = monteCarlo2(10000) 
plot(out, type = "l")
abline(h = 0.646, col = "red")

#acceptance rate
lambda.mcmc = as.mcmc(out)
1 - rejectionRate(lambda.mcmc)

# burn-in
par(mfrow = c(1,2))
hist(out, main = "No burn-in values removed")
hist(out[-c(1:1000)], main = "With burn-in values removed")

# autocorraltion
par(mfrow = c(1,1))
plot(out[-c(1:1000)], type = "l")

# Running mean plot
library(mcmcplots)
set.seed(440)

rmeanplot(out[-c(1:1000)])



