

library(dplyr)
library(readr)
library(lubridate)

## Data: download, unzip
dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists("consumption.zip")){
    download.file(dataURL, destfile="consumption.zip", method="curl")    
} else {
    print("file exists")
}

if (!file.exists("household_power_consumption.txt")){
    unzip("consumption.zip")
} else {
    print("file has already been unzipped")
}


cspn_df <-  tbl_df(read.delim("household_power_consumption.txt",
                              sep=";",
                              header = TRUE,
                              stringsAsFactors = FALSE,
                              na.strings="?"))

cdf2 <- cspn_df %>%
    mutate(DateTime = as.POSIXct(paste(cspn_df$Date, cspn_df$Time),
                                 format="%d/%m/%Y %H:%M:%S")) %>%
    filter(DateTime >= as.Date("2007-02-01 00:00:00"),
           DateTime < as.Date("2007-02-03 00:00:00"))


## Plots

# plot 4
png("plot4.png", width=480, height=480, units="px")
# 1,1
par(mfrow=c(2,2))
plot(cdf2$DateTime, cdf2$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
# 1,2
plot(cdf2$DateTime, cdf2$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")
# 2, 1 
plot(cdf2$DateTime, cdf2$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy sub metering")
lines(cdf2$DateTime, cdf2$Sub_metering_2, col="red")
lines(cdf2$DateTime, cdf2$Sub_metering_3, col="blue")
legend("topright",
       legend=c("Sub_metering_1", "Sub_metering_2",
                "Sub_metering_3"),
       lty=c(1,1,1), 
       col=c("black", "red","blue"))
# 2,2
plot(cdf2$DateTime, cdf2$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")
dev.off()