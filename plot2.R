library(dplyr)
library(lubridate)
setwd("/Users/mziskind/ExploratoryDataAnalysis")
file <- tbl_df(read.table("household_power_consumption.txt", 
                          header=TRUE, sep= ";", nrows = 1000000, na.strings = c("?","") ) )
file$DateTime <- paste(file$Date, file$Time)
file$DateTime <- dmy_hms(file$DateTime)
file$DateTime <- with_tz(file$DateTime, tzone = "EST")
df <- filter(file, DateTime >= "2007-02-01 00:00:00", DateTime < "2007-02-03 00:00:00")

plot(df$DateTime, df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (Kilowatts)")
dev.copy(png, file="plot2.png")
dev.off()