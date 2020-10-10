#load required libraries
library(data.table)
library(dplyr)

#load data
house.power.data <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", dec = ".")
house.power.data$Date <- as.Date(house.power.data$Date, format = "%d/%m/%Y") #convert to Date format
house.power.data <- house.power.data %>% mutate(across(starts_with(c("G","V","S")), as.numeric)) #covert [, 3:9] to numeric
setDT(house.power.data)
house.power.data.sub <- house.power.data[Date >= "2007-02-01" & Date <= "2007-02-02"] #subset required observations

Date.Time <- paste(house.power.data.sub$Date, house.power.data.sub$Time)
house.power.data.sub$Date_Time <- as.POSIXct(Date.Time)
house.power.data <- house.power.data.sub[, c(10, 3:9)]

#plot2
png(file="plot2.png", width = 480, height = 480)
plot(house.power.data$Global_active_power ~ house.power.data$Date_Time, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l")
dev.off()

