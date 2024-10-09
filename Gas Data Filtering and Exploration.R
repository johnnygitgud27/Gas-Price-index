## Start of 626 Time Series Project: Natural Gas Price Index and it's adjacent effects on markets

## Library and dataset
setwd("C:/Users/johnl/Desktop/STAT 626 Summer 2023/Project Data and Links")
library(astsa)

gas_data2 = read.csv("Henry_Hub_Natural_Gas_Spot_Price.csv")
gas_data2$Price = gas_data2$Henry.Hub.Natural.Gas.Spot.Price.Dollars.per.Million.Btu
gas_data2$Price = as.numeric(gas_data2$Price)
# transpose of dataframe
trans_gas2 <- t(gas_data2)
# converting the result to dataframe
trans_gas2 <- as.data.frame(trans_gas2)
# calculating reverse of dataframe
rev_gasframe <- rev(trans_gas2)
# transpose of reverse dataframe
rev_gasframe <- t(rev_gasframe)
# converting the result to dataframe
new_gas <- as.data.frame(rev_gasframe)
View(new_gas) ## Ideally Ordered in normal Ascending timeline
plot(new_gas$Price,col="blue", type = "l", ylab = "Dollars per Million BTU",
       xlab = "Months since Jan 1997", main = "Natural Gas Price Index by EIA")

## Found on Stack Overflow, Best one so far
gas<-ts(new_gas$Price,start = c(1997,1),freq=12)
plot(gas, type="l", lwd=2, col="blue" ,main = "Natural Gas Price Index by EIA",
     ylab= "Dollars per Million BTU",xlab = "Year",
     xlim=c(1997,2023)) ## can also do plot.ts()

## decomposing the gas data didn't work as it doesn't show any seasonality or trends.
## Using SMA function helped smooth out the function
## install.packages("TTR")
library(TTR)
gas_seriesSMA2 = SMA(gas,n=5)
plot.ts(gas_seriesSMA2)

library(astsa)
## Needs more looking into documentation
gas_series = ts(new_gas,start = c(1997,1),freq=12) ## Must have the whole object and not the column. But why does the error happen
gascomponents = decompose(gas_series) ## has a non-numeric argument to binary operator error
plot(gascomponents)

gas_series2 = as.ts(as.vector(new_gas[,3]), start = c(1997,1), freq=12)

##new_gas[,3]

gascomponents2 = decompose(gas_series2)