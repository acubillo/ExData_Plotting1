#  plot1.R
#
#  Created by Adalberto Cubillo on 7/17/19.
#  Copyright © 2019 Adalberto Cubillo. All rights reserved.

# Read the household power consumption data. 
data_header <- read.table(file = "./household_power_consumption.txt", 
                   header = FALSE, sep = ";", nrows = 1, stringsAsFactors = FALSE)
data <- read.table(file = "./household_power_consumption.txt", 
                   header = FALSE, sep = ";", skip = 66637, nrows = 2880)
colnames(data) <- as.vector(data_header[1,])

# Convert Date and Time variables into R date and time types.
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- format(strptime(data$Time, format = "%H:%M:%S"), "%H:%M:%S")

# Set the plot device to PNG and the size to 480x480px.
png(filename = "./plot1.png", width = 480, height = 480, units = "px")

# Create the plot1.
with(data, hist(Global_active_power, 
                col = "red", 
                xlab = "Global Active Power (kilowatts)", 
                main = "Global Active Power", cex.axis = 0.7))


# Close the device and save the plot in the PNG image. 
dev.off()