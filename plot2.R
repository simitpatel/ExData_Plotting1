#install packages/libraries
library(dplyr)
library(lubridate)

#read data
powerdata <- read.csv("./R/project4/power1/household_power_consumption.txt", sep=";")

#subset by year

powerdata <- subset(powerdata, Date=="1/2/2007" | Date=="2/2/2007")

#plot first graph

powerdata$Global_active_power <- as.numeric(powerdata$Global_active_power)
png(filename="plot2.png",
        width=480,
    height=480)
plot(powerdata$Global_active_power, type="line")
     title(main = "Global Active Power", xlab="Global Active Power(kilowatts)", las=2,col="black")
axis(1, at=c(2,4,6))
dev.off()