library(dplyr)
library(lubridate)
setwd("/Users/mziskind/Google Drive/ExploratoryDataAnalysis")
file <- tbl_df(read.table("household_power_consumption.txt", 
                          header=TRUE, sep= ";", nrows = 1000000, na.strings = c("?","") ) )
file$DateTime <- paste(file$Date, file$Time)
file$DateTime <- dmy_hms(file$DateTime)
file$DateTime <- with_tz(file$DateTime, tzone = "EST")
df <- filter(file, DateTime >= "2007-02-01 00:00:00", DateTime < "2007-02-03 00:00:00")

## Open Graphics device and set the layout of 2x2
png(filename="plot4.png")
par(mfrow=c(2,2))
## Build the first Plot
plot(df$DateTime, df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
## Build the 2nd Plot
plot(df$DateTime, df$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
## Build the 3rd Plot
plot(df$DateTime, df$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(df$DateTime, df$Sub_metering_2, col = "red")
lines(df$DateTime, df$Sub_metering_3, col = "blue")
leg.txt <- c(names(df)[7], names(df)[8], names(df)[9])
legend('topright', leg.txt, lty = 1, col = c("black", "red", "blue"), cex = .75)
## Build the 4th Plot
plot(df$DateTime, df$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()