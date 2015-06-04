# used to filter the data
library(sqldf)

# load the data from file (working directory) filtering the data
filter.data <- read.csv.sql(sep = ";", file = "household_power_consumption.txt", "select * from file where Date in ('1/2/2007','2/2/2007')")
closeAllConnections()

# add a new column with the correct datetime format
filter.data$DateTime <- as.POSIXct(paste(filter.data$Date, filter.data$Time), format="%d/%m/%Y %H:%M:%S")

# set the output device
png("plot3.png", width = 480, height = 480)

# build the plot
with(filter.data, plot(DateTime, filter.data$Sub_metering_1,  type = "n", xlab = "", ylab  = "Energy sub metering"))
with(filter.data, lines(DateTime, Sub_metering_1, col="black"))
with(filter.data, lines(DateTime, Sub_metering_2, col="red"))
with(filter.data, lines(DateTime, Sub_metering_3, col="blue"))
legend(x="topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty = 1)

# closing the device
dev.off()