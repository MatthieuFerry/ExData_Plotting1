## Creation of graphic 1

#The (very) roughtly estimated size of the dataframe is 2075259*9*8/1024/1024 approx 150 MB

# Loading the data from the CSV file using read.csv2 to handle ';' separator, assuming the file is 1 directory above the repo directory
 # Use quote="" to boost loading of the huge file
 # As mentionned na string are coded with "?"
 # Prevents rows of unequal length to stop the process with fill=TRUE
 # manually defines the column classes to boost loading
colclasses <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
all_hpc<-read.csv2("../household_power_consumption.txt", na.strings = "?", colClasses=colclasses, dec = ".", fill=TRUE, quote="")

# Have a look to the data
#head(all_hpc,20)
#str(all_hpc)

# Extracts the subset between the dates "2007-02-01" and "2007-02-02" and stores it in a new dataframe
# Be careful the date in the file are coded day/month/year but without leading "0" for the first 9 days/months
hpc <- subset(all_hpc, Date=="1/2/2007" | Date=="2/2/2007")

# Have a look to the data
#head(hpc,20)
#str(hpc)
#summary(hpc)

# Removes the big dataframe from memory to save space
rm(all_hpc)

# This should be loaded by default but we need to be sure
library(datasets)
library(graphics)
library(grDevices)

# Parameters for the PNG file
plot_width  <- 480
plot_height <- 480
png_name <- "plot1.png"
img_directory <- "figure"
file_name <- paste(img_directory,png_name,sep="/")

# Create the figure directory if not existing
if (!file.exists(img_directory)) {
        dir.create(img_directory)
}

# Sets the screen to have only 1 graph
par(mfrow=c(1,1))

# Plots histogram on the screen first
hist(hpc$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")


# Copy the screen device to the PNG
dev.copy(png, file = file_name, width = plot_width, height = plot_height)
# Don't forget to close the file device
dev.off()