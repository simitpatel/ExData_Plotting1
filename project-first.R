#install packages/libraries
library(dplyr)
library(lubridate)

#read data
powerdata <- read.csv("./R/project4/power1/household_power_consumption.txt", sep=";")

#subset by year

powerdata <- subset(powerdata, Date=="1/2/2007" | Date=="2/2/2007")

#plot first graph

powerdata$Global_active_power <- as.numeric(powerdata$Global_active_power)
png(filename="plot1.png",
        width=480,
    height=480,
    pointsize=12,
    res=72)
my_sc_plot(data)
dev.off()