library(tidyverse)
library(dplyr)
library(readr)
library(lubridate)


# load whole dataset
data <- read_delim("household_power_consumption.txt" , delim = ";" ,  col_names = TRUE , 
                   na = c("?" , "NA"), locale = locale(decimal_mark = "."),
                   col_types = cols(Date = col_date(format = "%d/%m/%Y"),
                                    Time  = col_time(format  = "%H:%M:%z"),
                                    Global_active_power = col_number() ,
                                    Global_reactive_power = col_number() ,
                                    Voltage= col_number(),
                                    Global_intensity = col_number(),
                                    Sub_metering_1 =  col_number(), 
                                    Sub_metering_2 = col_number(),
                                    Sub_metering_3 =  col_number())  )

#subset dataset for only the two selected days
dat <- data
dat <- dat%>%
  filter(Date == "2007-2-1" | Date == "2007-2-2")


## plot 2
dt <- with(dat, ymd(Date) + hms(Time))
png("plot2.png", width=480, height=480)
plot(dt, dat$Global_active_power, type="l",
     xlab="", 
     ylab="Global Active Power (kilowatts)")
dev.off()

