#  plot2.R
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
png(filename = "./plot2.png", width = 480, height = 480, units = "px")

# Create the plot2.
with(data, plot(Date_Time, Global_active_power, type = "l", xlab = "",
                ylab = "Global Active Power (kilowatts)"))


# Close the device and save the plot in the PNG image. 
dev.off()