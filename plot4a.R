#install packages/libraries
library(dplyr)
library(lubridate)

#read data
powerdata <- read.csv("./R/project4/power1/household_power_consumption.txt", sep=";")

#subset by year

powerdata <- subset(powerdata, Date=="1/2/2007" | Date=="2/2/2007")

#make variables numeric

powerdata$Sub_metering_1 <- as.numeric(powerdata$Sub_metering_1)
powerdata$Sub_metering_2 <- as.numeric(powerdata$Sub_metering_2)
powerdata$Sub_metering_3 <- as.numeric(powerdata$Sub_metering_3)
powerdata$Global_active_power <- as.numeric(powerdata$Global_active_power)

#create vectors for axes and legend

x <- c(0,10,20,30)
submeters <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
legcol <- c("black","red","blue")

attach(powerdata)
par(mfrow=c(2,2))
hist(Global_active_power,col="red")
  title(main = "Global Active Power", xlab="Global Active Power(kilowatts)")

plot(Global_active_power, type="line")
  title(main = "Global Active Power", xlab="Global Active Power(kilowatts)", las=2,col="black")
  axis(1, at=c(2,4,6))

plot(Sub_metering_1, type="line")
axis(2,at=x)
lines(Sub_metering_2,col="red")
lines(Sub_metering_3,col="blue")
title(ylab="Energy sub metering", las=2,col="black")
legend("topright", 
       submeters, fill=legcol, horiz=FALSE, pch="-")

plot(Global_reactive_power, type="line")
  axis(2,at=x)
   title(ylab="Global_reactive_power", las=2,col="black")

png(filename="plot4a.png",
    width=480,
    height=480)

dev.off()