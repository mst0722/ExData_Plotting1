## Read in the file
library(ggplot2)
library(dplyr)

hp <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings="?")
## check if variables are assigned correctly
sapply(hp, class)

## convert Date variables from factor class to date class
a <- as.Date(strptime(hp$Date, '%d/%m/%Y'))
hp$Date <- a

## confirm date class
class(hp$Date)

## Subset data to only include dates between 02/01/2007 and 02/02/2007
hpsubset <- subset(hp, hp$Date >= "2007-02-01" & hp$Date <= "2007-02-02")

## Create a histogram of Global Active Power
hist(hpsubset$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

## Create PNG file
dev.copy(png, file = "plot1.png", height=480, width=480)
dev.off()

