library(plyr)
library(dplyr)
library(ggplot2)

raw <- readRDS("./R/project4/nei/summarySCC_PM25.rds")
scc <- readRDS("./R/project4/nei/Source_Classification_Code.rds")

yeartotals <- tapply(raw$Emissions,raw$year,sum)
yearframe <- as.data.frame(yeartotals)
yearframe <- mutate(yearframe, year = rownames(yearframe))
plot(yearframe$year,yearframe$yeartotals,type="line")

baltimore <- filter(raw,fips == "24510")
baltimore2 <- tapply(baltimore$Emissions,baltimore$year,sum)
baltimore2 <- as.data.frame(baltimore2)
baltimore2 <- mutate(baltimore2, year = rownames(baltimore))
plot(baltimore2$year,baltimore2$baltimore,type="line")


baltimore99 <- filter(baltimore,year==1999)
baltimore02 <- filter(baltimore,year==2002)
baltimore05 <- filter(baltimore,year==2005)
baltimore08 <- filter(baltimore,year==2008)

baltimore992 <- baltimore99 %>% group_by(type) %>% summarise(sum(Emissions))
baltimore992 <- mutate(baltimore992,year=1999)

baltimore022 <- baltimore02 %>% group_by(type) %>% summarise(sum(Emissions))
baltimore022 <- mutate(baltimore022,year=2002)

baltimore052 <- baltimore05 %>% group_by(type) %>% summarise(sum(Emissions))
baltimore052 <- mutate(baltimore052,year=2005)

baltimore082 <- baltimore08 %>% group_by(type) %>% summarise(sum(Emissions))
baltimore082 <- mutate(baltimore082,year=2008)

baltimorepoints <- rbind(baltimore992,baltimore022,baltimore052,baltimore082)
names(baltimorepoints) <- c("type", "emissions", "year")
qplot(year,emissions,data=baltimorepoints,color=type,geom="line")

coal <- filter(scc, grepl(" Coal",EI.Sector))
cc <- filter(coal, grepl("Combustion",SCC.Level.One))

coalemissions <- inner_join(raw,cc)

coalemissions99 <- filter(coalemissions,year==1999)
coalemissions02 <- filter(coalemissions,year==2002)
coalemissions05 <- filter(coalemissions,year==2005)
coalemissions08 <- filter(coalemissions,year==2008)

coalemissions992 <- coalemissions99 %>% group_by(year) %>% summarise(sum(Emissions))
coalemissions022 <- coalemissions02 %>% group_by(year) %>% summarise(sum(Emissions))
coalemissions052 <- coalemissions05 %>% group_by(year) %>% summarise(sum(Emissions))
coalemissions082 <- coalemissions08 %>% group_by(year) %>% summarise(sum(Emissions))

coalyear <- rbind(coalemissions992,coalemissions022,coalemissions052,coalemissions082)
names(coalyear) <- c("year","emissions")
qplot(year,emissions,data=coalyear,geom="line")

baltroads <- filter(baltimore,type == "ON-ROAD")
baltroademissions <- inner_join(baltroads,scc)

baltroademissions99 <- filter(baltroademissions,year==1999)
baltroademissions02 <- filter(baltroademissions,year==2002)
baltroademissions05 <- filter(baltroademissions,year==2005)
baltroademissions08 <- filter(baltroademissions,year==2008)

baltroademissions992 <- baltroademissions99 %>% group_by(year) %>% summarise(sum(Emissions))
baltroademissions022 <- baltroademissions02 %>% group_by(year) %>% summarise(sum(Emissions))
baltroademissions052 <- baltroademissions05 %>% group_by(year) %>% summarise(sum(Emissions))
baltroademissions082 <- baltroademissions08 %>% group_by(year) %>% summarise(sum(Emissions))

baltyear <- rbind(baltroademissions992,baltroademissions022,baltroademissions052,baltroademissions082)
names(baltyear) <- c("year","emissions")
qplot(year,emissions,data=baltyear,geom="line")

#baltimore and LA

la <-  filter(raw,fips == "06037")
baltla <- rbind(baltimore,la)
baltla$fips <- revalue(baltla$fips, c("06037"="LA"))
baltla$fips <- revalue(baltla$fips, c("24510"="Baltimore"))

baltlaroademissions <- inner_join(baltlaroads,scc)
baltlaroads <- filter(baltla,type == "ON-ROAD")

baltlaroademissions99 <- filter(baltlaroademissions,year==1999)
baltlaroademissions02 <- filter(baltlaroademissions,year==2002)
baltlaroademissions05 <- filter(baltlaroademissions,year==2005)
baltlaroademissions08 <- filter(baltlaroademissions,year==2008)

baltlaroademissions992 <- baltlaroademissions99 %>% group_by(year,fips) %>% summarise(sum(Emissions))
baltlaroademissions022 <- baltlaroademissions02 %>% group_by(year,fips) %>% summarise(sum(Emissions))
baltlaroademissions052 <- baltlaroademissions05 %>% group_by(year,fips) %>% summarise(sum(Emissions))
baltlaroademissions082 <- baltlaroademissions08 %>% group_by(year,fips) %>% summarise(sum(Emissions))

baltlayear <- rbind(baltlaroademissions992,baltlaroademissions022,baltlaroademissions052,baltlaroademissions082)
names(baltlayear) <- c("year","city","emissions")
qplot(year,emissions,data=baltlayear,geom="line",color=city)
