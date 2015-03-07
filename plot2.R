#read data
powerdata <- read.csv("./R/project4/power1/household_power_consumption.txt", sep=";")

#subset by year

powerdata <- subset(powerdata, Date=="1/2/2007" | Date=="2/2/2007")
marks1 <- seq(from = 0, to = 6, by = 2)
xax <- as.POSIXct(paste(powerdata$Date, powerdata$Time, sep= " "), format = "%d/%m/%Y %H:%M:%S")
#plot graph

powerdata$Global_active_power <- as.numeric(powerdata$Global_active_power)
png(filename="plot2.png",
        width=480,
    height=480)

plot(xax, powerdata$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
axis(2,at=marks1)


dev.off()