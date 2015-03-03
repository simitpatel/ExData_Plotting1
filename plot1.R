#install packages/libraries
library(dplyr)
library(lubridate)

#read data
powerdata <- read.csv("./R/project4/power1/household_power_consumption.txt", sep=";")

#subset by year

powerdata <- subset(powerdata, Date=="1/2/2007" | Date=="2/2/2007")

#create variables for axis values

x1 <- c(0:100)
y1 <- c(0,200,400,600,800,1000,1200)

#plot first graph

powerdata$Global_active_power <- as.numeric(powerdata$Global_active_power)
png(filename="plot1.png", width=480, height=480,pointsize=12,res=72)
hist(powerdata$Global_active_power,col="red", main="",xlab="",ylab="",axes=FALSE)
axis(1, c(0,2,4,6))
axis(2,at=y1)
title(main = "Global Active Power", xlab="Global Active Power(kilowatts)",ylab="Frequency")


dev.off()