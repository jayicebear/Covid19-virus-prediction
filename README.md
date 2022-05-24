# Covid19-virus-prediction

Introduction and background

Through the MCMC algorithm, I proceeded to find the probability of whether the number of new corona virus cases in South Korea the next day will 
increase or decrease compared to today. 
If you look at the news, the number of confirmed cases decreases every day, but there are days when the number of confirmed cases suddenly rises 
higher than yesterday. So, with the data from the previous days, I calculated the probability that the number of confirmed cases will increase tomorrow. 
The MCMC algorithm can predict future probabilities based on past probability data. For this reason, I thought the MCMC algorithm was a good fit for my 
project.

Model description

I build a function shows how much the number of Covid19 virus confirmed cases has increased or decreased compared to the previous day. 
And I made the result into a new column. Also, I made a function that assigns 1 if the number of confirmed cases today is higher than yesterday, 
and 0 when it decreases. I made another function to find the probability that the result is 1, that is, the probability that there are more confirmed cases 
today than yesterday. As a result, the probability that South Korea will have more confirmed cases tomorrow was calculated as 64.6%. I created another 
MCMC function. The MCMC algorithm was used to find the change in the probability that varies from day to day. Also, I ran the MCMC function 100 times, 
1000 times, and 10000 times using these functions. When the function is run 100 times, the probability converges to 0.6, but there is a lot of variation. 
When it is rotated 1000 times, the fluctuation range is reduced, and when it is rotated 10000 times, it converges to close to 0.646. The acceptance rate 
was very high at 0.99 percent. By removing the burn-in values, we were able to obtain a normal probability graph. I also used autocorrelation to reduce 
autocorrelation. We could see the autocorrelation function working properly with the graph converging to the true value.

Real data description

My data was found on our world in data site. I extracted only data from south korea and subset from the data from 2020-03-01 to 2022-04-01. 
Missing values were removed using the complete_cases function.
Results and discussions
The result is that the more times the MCMC simulation is run, the more accurate the values are reached. 
There is a difference in the convergence value between 100 rotations and 10000 rotations. Also, through burn-in, autocorrelation, 
and running mean plot, we were able to remove interference and determine the suitability of the function.
