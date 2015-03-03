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

#create vectors for axes and legend

x <- c(0,10,20,30)
y <- c(0:10000)
submeters <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
legcol <- c("black","red","blue")


png(filename="plot3.png",
        width=480,
    height=480)
plot(powerdata$Sub_metering_1, main="", xlab="", ylab="",type="line",axes=FALSE)
lines(powerdata$Sub_metering_2,col="red")
lines(powerdata$Sub_metering_3,col="blue")
axis(2,at=x)
axis(1,at=y)
     title(ylab="Energy sub metering", las=2,col="black")
legend("topright", 
       submeters, horiz=FALSE, lty=1, col=legcol)

dev.off()