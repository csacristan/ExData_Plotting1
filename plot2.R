# used to filter the data
library(sqldf)

# load the data from file (working directory) filtering the data
filter.data <- read.csv.sql(sep = ";", file = "household_power_consumption.txt", "select * from file where Date in ('1/2/2007','2/2/2007')")
closeAllConnections()

# add a new column with the correct datetime format
filter.data$DateTime <- as.POSIXct(paste(filter.data$Date, filter.data$Time), format="%d/%m/%Y %H:%M:%S")

# set the output device
png("plot2.png", width = 480, height = 480)

# build the plot
plot(filter.data$DateTime, filter.data$Global_active_power,  type = "l", xlab = "", ylab  = "Global Active Power (kilowatts)")

# closing the device
dev.off()