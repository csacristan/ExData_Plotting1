# used to filter the data
library(sqldf)

# load the data from file (working directory) filtering the data
filter.data <- read.csv.sql(sep = ";", file = "household_power_consumption.txt", "select * from file where Date in ('1/2/2007','2/2/2007')")
closeAllConnections()

# add a new column with the correct datetime format
filter.data$DateTime <- as.POSIXct(paste(filter.data$Date, filter.data$Time), format="%d/%m/%Y %H:%M:%S")

# output 2x2
par(mfrow = c(2,2))
 

with(filter.data,
    {
        #plot #1
        plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
        # plot #2
        plot(DateTime, Voltage,  type = "l", xlab = "datetime", ylab  = "Voltage")
        # plot #3
        plot(DateTime, Sub_metering_1,  type = "n", xlab = "", ylab  = "Energy sub metering")
        lines(DateTime, Sub_metering_1, col="black")
        lines(DateTime, Sub_metering_2, col="red")
        lines(DateTime, Sub_metering_3, col="blue")
        legend(x="topright",  bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty = 1)
        # plot #4
        plot(DateTime, Global_reactive_power, type = "l", xlab="datetime", ylab = "Global_reactive_power")
    }
)

# copy the image to a png file 
dev.copy(png, file="plot4.png")


# closing the device
dev.off()