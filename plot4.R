library(dplyr)
##This script creates a histogram forpower consumption during Feb 01 and 02 2007
##Create plot-data directory if one does not exist
if (!file.exists("plot-data")) {
  dir.create(("plot-data"))
}

##set working directory
setwd(".//plot-data")

##Download the data set and unzip it
my_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(my_url, destfile = ".\\household-power-consumption.zip")
power <- unzip(zipfile=".\\household-power-consumption.zip",exdir=".\\data-plot")

##Read in the data set
power_data <- read.table(".\\data-plot\\household_power_consumption.txt", header = TRUE, sep = ";")

##convert to a differnt date format
power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")

##Read in a subset of data for Feb 01 and Feb 02 2007 only for data analysis
my_power_data <- power_data[(power_data$Date=="2007-02-01") | (power_data$Date=="2007-02-02"),]

##Set variables to a numberic values
my_power_data$Global_active_power <- as.numeric(as.character(my_power_data$Global_active_power))
my_power_data$Global_reactive_power <- as.numeric(as.character(my_power_data$Global_reactive_power))
my_power_data$Sub_metering_1 <- as.numeric(as.character(my_power_data$Sub_metering_1))
my_power_data$Sub_metering_2 <- as.numeric(as.character(my_power_data$Sub_metering_2))
my_power_data$Sub_metering_3 <- as.numeric(as.character(dmy_power_data$Sub_metering_3))
my_power_data$Voltage <- as.numeric(as.character(my_power_data$Voltage))

##Add timestamp to the data set
my_power_data <- transform(my_power_data, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

##Set the graphics device to 4 Plots
par(mfrow=c(2,2))

##Plot #1
plot(my_power_data$timestamp, my_power_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

##Plot #2
plot(my_power_data$timestamp, my_power_data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

##Plot #3
plot(my_power_data$timestamp, my_power_data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(my_power_data$timestamp,my_power_data$Sub_metering_2,col="red")
lines(my_power_data$timestamp,my_power_data$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1 ","Sub_metering_2 ", "Sub_metering_3 "), lty=c(1,1), bty="n", cex=.5)

##Plot #4
plot(my_power_data$timestamp, my_power_data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()


