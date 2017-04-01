## Read in the file
library(ggplot2)
library(dplyr)

hp <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings="?")
## check if variables are assigned correctly
sapply(hp, class)

## convert Date variables from factor class to date class
a <- as.Date(strptime(hp$Date, '%d/%m/%Y'))
hp$Date <- a
  
## Subset data to only include dates between 02/01/2007 and 02/02/2007
hpsubset <- subset(hp, hp$Date >= "2007-02-01" & hp$Date <= "2007-02-02")

## create a date_time variable
hpTime <- paste(hpsubset$Date, hpsubset$Time)
hpsubset$DateTime <- as.POSIXct(hpTime)

## Create 3 line plots for sub_metering 1, 2 & 3 
with(hpsubset, {
  plot(Sub_metering_1~DateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="", cex=0.8)
  lines(Sub_metering_2~DateTime, col='Red')
  lines(Sub_metering_3~DateTime, col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.8)


## Create PNG file
dev.copy(png, file = "plot3.png", height=480, width=480)

dev.off()

