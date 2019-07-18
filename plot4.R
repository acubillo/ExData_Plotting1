#  plot4.R
#
#  Created by Adalberto Cubillo on 7/17/19.
#  Copyright © 2019 Adalberto Cubillo. All rights reserved.

# Download the household power consumption data zipped (the file is huge to store in github!).
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
downloaded_file <- unz(temp, "household_power_consumption.txt")

# Read the household power consumption data. 
data_header <- read.table(file = downloaded_file, 
                          header = FALSE, sep = ";", nrows = 1, stringsAsFactors = FALSE)

# I need to load it again after the first read.
downloaded_file <- unz(temp, "household_power_consumption.txt") 
hpc_data <- read.table(file = downloaded_file,
                       header = FALSE, sep = ";", skip = 66637, nrows = 2880)
colnames(hpc_data) <- as.vector(data_header[1,])

# Delete temp file.
unlink(temp)

# Convert Date and Time variables into R date and time types.
hpc_data$Time <- format(strptime(hpc_data$Time, format = "%H:%M:%S"), "%H:%M:%S")
hpc_data$Date_Time <- strptime(paste(as.character(hpc_data$Date), as.character(hpc_data$Time)), 
                               format = "%d/%m/%Y %H:%M:%S")

# Set the plot device to PNG and the size to 480x480px.
png(filename = "./plot4.png", width = 480, height = 480, units = "px")

# Set par mfrow to display 4 different rows.
par(mfrow = c(2, 2), mar = c(5, 4, 1, 3), cex = 0.6)

# Create the first plot.
with(hpc_data, plot(Date_Time, Global_active_power, type = "l", xlab = "",
                    ylab = "Global Active Power"))

# Create the second plot.
with(hpc_data, plot(Date_Time, Voltage, type = "l", xlab = "datetime",
                    ylab = "Voltage"))

# Create the third plot.
with(hpc_data, plot(Date_Time, Sub_metering_1, type = "n", xlab = "",
                    ylab = "Energy sub metering"))
with(hpc_data, points(Date_Time, Sub_metering_1, type = "l", col = "black"))
with(hpc_data, points(Date_Time, Sub_metering_2, type = "l", col = "red"))
with(hpc_data, points(Date_Time, Sub_metering_3, type = "l", col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Create the fourth plot.
with(hpc_data, plot(Date_Time, Global_reactive_power, type = "l", xlab = "datetime",
                    ylab = "Global_reactive_power"))

# Close the device and save the plot in the PNG image. 
dev.off()