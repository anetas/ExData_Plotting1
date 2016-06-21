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

##Set the date format
power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")

##Read in a subset of data for Feb 01 and Feb 02 2007 only for data analysis
my_power_data <- power_data[(power_data$Date=="2007-02-01") | (power_data$Date=="2007-02-02"),]

##Set Global_active_power variable to a numberic value
my_power_data$Global_active_power <- as.numeric(as.character(my_power_data$Global_active_power))

##create a histogram for the subset of data
hist(my_power_data$Global_active_power, main = "Global Active Power", ylab = "Frequency", xlab = "Global Active Power (kilowatts)", col = "red")

##Save histogram to png file
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()

    

