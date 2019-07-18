#  plot1.R
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
hpc_data$Date <- as.Date(hpc_data$Date, format = "%d/%m/%Y")
hpc_data$Time <- format(strptime(hpc_data$Time, format = "%H:%M:%S"), "%H:%M:%S")

# Set the plot device to PNG and the size to 480x480px.
png(filename = "./plot1.png", width = 480, height = 480, units = "px")

# Create the plot1.
with(hpc_data, hist(Global_active_power, 
                    col = "red", 
                    xlab = "Global Active Power (kilowatts)", 
                    main = "Global Active Power", cex.axis = 0.7))


# Close the device and save the plot in the PNG image. 
dev.off()