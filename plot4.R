#install packages/libraries
library(dplyr)
library(lubridate)
library(Hmisc)

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

xax <- as.POSIXct(paste(powerdata$Date, powerdata$Time, sep= " "), format = "%d/%m/%Y %H:%M:%S")
submeters <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
legcol <- c("black","red","blue")
marks1 <- seq(from = 0, to = 6, by = 2)
marks4 <- seq(from = 0.0, to = 0.5, by = 0.1)


png(filename="plot4.png",
        width=480,
    height=480)
par(mfrow=c(2,2))
plot(xax,powerdata$Global_active_power,main="",xlab="",type="l",ylab="")
  title(ylab="Global Active Power")
  axis(2,at=marks1)

plot(xax,powerdata$Voltage,ylab="",xlab="", type="l")
  title(main = "", ylab="Voltage",xlab="datetime",las=2,col="black")
  axis(1, at=c(2,4,6))

plot(xax,powerdata$Sub_metering_1,type="l",col="black",ylab="",xlab="")
lines(xax,powerdata$Sub_metering_2,type="l",col="red")
lines(xax,powerdata$Sub_metering_3,type="l",col="blue")
title(ylab="Energy sub metering", las=2,col="black")
legend("topright", 
       submeters, horiz=FALSE, lty=1, col=legcol,bty="n")

plot(xax,powerdata$Global_reactive_power,ylab="",xlab="",type="l")
  axis(2,at=marks4)
   title(ylab="Global_reactive_power", xlab="datetime", las=2,col="black")

dev.off()