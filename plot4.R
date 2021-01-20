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
# subset the two specific days
dat <- data
dat <- dat%>%
  filter(Date == "2007-2-1" | Date == "2007-2-2")


## plot 4

png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 
dt <- with(dat, ymd(Date) + hms(Time))

#1

plot(dt, dat$Global_active_power, type="l",
     xlab="", 
     ylab="Global Active Power")

#2

plot(dt, dat$Voltage, type="l", xlab="datetime", ylab="Voltage")


#3

plot(dt, dat$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(dt, dat$Sub_metering_2, type="l", col="red")
lines(dt, dat$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n" ,  lwd = 0.5, col=c("black", "red", "blue"))

#4

plot(dt, dat$Global_reactive_power, type="l", 
     xlab="datetime", 
     ylab="Global_reactive_power")

dev.off()



