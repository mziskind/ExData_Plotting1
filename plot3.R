library(dplyr)
library(lubridate)
setwd("/Users/mziskind/Google Drive/ExploratoryDataAnalysis")
file <- tbl_df(read.table("household_power_consumption.txt", 
                          header=TRUE, sep= ";", nrows = 1000000, na.strings = c("?","") ) )
file$DateTime <- paste(file$Date, file$Time)
file$DateTime <- dmy_hms(file$DateTime)
file$DateTime <- with_tz(file$DateTime, tzone = "EST")
df <- filter(file, DateTime >= "2007-02-01 00:00:00", DateTime < "2007-02-03 00:00:00")

## Build the Plot in R Studio
plot(df$DateTime, df$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(df$DateTime, df$Sub_metering_2, col = "red")
lines(df$DateTime, df$Sub_metering_3, col = "blue")
leg.txt <- c(names(df)[7], names(df)[8], names(df)[9])
legend('topright', leg.txt, lty = 1, col = c("black", "red", "blue"), cex = .75)

## Copy the Plot out to a PNG file
png(filename="plot3.png")
plot(df$DateTime, df$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(df$DateTime, df$Sub_metering_2, col = "red")
lines(df$DateTime, df$Sub_metering_3, col = "blue")
leg.txt <- c(names(df)[7], names(df)[8], names(df)[9])
legend('topright', leg.txt, lty = 1, col = c("black", "red", "blue"), cex = .75)
dev.off()