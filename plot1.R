

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

# plot 1
png("plot1.png", width=480, height=480, units="px")
hist(cdf2$Global_active_power, col="red",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     main = "Global Active Power")
dev.off()