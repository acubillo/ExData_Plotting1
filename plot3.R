#  plot3.R
#
#  Created by Adalberto Cubillo on 7/17/19.
#  Copyright © 2019 Adalberto Cubillo. All rights reserved.

# Read the household power consumption data. 
data_header <- read.table(file = "./household_power_consumption.txt", 
                          header = FALSE, sep = ";", nrows = 1, stringsAsFactors = FALSE)
data <- read.table(file = "./household_power_consumption.txt", 
                   header = FALSE, sep = ";", skip = 66637, nrows = 2881)
colnames(data) <- as.vector(data_header[1,])

# Convert Date and Time variables into R date and time types.
# data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- format(strptime(data$Time, format = "%H:%M:%S"), "%H:%M:%S")
data$Date_Time <- strptime(paste(as.character(data$Date), as.character(data$Time)), 
                           format = "%d/%m/%Y %H:%M:%S")

# Set the plot device to PNG and the size to 480x480px.
png(filename = "./plot3.png", width = 480, height = 480, units = "px")

# Create the plot3.
with(data, plot(Date_Time, Sub_metering_1, type = "n", xlab = "",
                ylab = "Energy sub metering"))
with(data, points(Date_Time, Sub_metering_1, type = "l", col = "black"))
with(data, points(Date_Time, Sub_metering_2, type = "l", col = "red"))
with(data, points(Date_Time, Sub_metering_3, type = "l", col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Close the device and save the plot in the PNG image. 
dev.off()