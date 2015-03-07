#read data
powerdata <- read.csv("./R/project4/power1/household_power_consumption.txt", sep=";")

#subset by year

powerdata <- subset(powerdata, Date=="1/2/2007" | Date=="2/2/2007")

#make variables numeric

powerdata$Sub_metering_1 <- as.numeric(powerdata$Sub_metering_1)
powerdata$Sub_metering_2 <- as.numeric(powerdata$Sub_metering_2)
powerdata$Sub_metering_3 <- as.numeric(powerdata$Sub_metering_3)

#create vectors for axes and legend

xax <- as.POSIXct(paste(powerdata$Date, powerdata$Time, sep= " "), format = "%d/%m/%Y %H:%M:%S")
submeters <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
legcol <- c("black","red","blue")


png(filename="plot3.png",
        width=480,
    height=480)
plot(xax,powerdata$Sub_metering_1,type="l",col="black",ylab="",xlab="")
lines(xax,powerdata$Sub_metering_2,type="l",col="red")
lines(xax,powerdata$Sub_metering_3,type="l",col="blue")
     title(ylab="Energy sub metering", las=2,col="black")
legend("topright", 
       submeters, horiz=FALSE, lty=1, col=legcol)

dev.off()

