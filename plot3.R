## Creation of graphic 3

# Loading the data from the CSV file using read.csv2 to handle ';' separator, assuming the file is 1 directory above the repo directory
# Use quote="" to boost loading of the huge file
# As mentionned na string are coded with "?"
# Prevents rows of unequal length to stop the process with fill=TRUE
# manually defines the column classes to boost loading
colclasses <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
all_hpc<-read.csv2("../household_power_consumption.txt", na.strings = "?", colClasses=colclasses, dec = ".", fill=TRUE, quote="")

# Extracts the subset between the dates "2007-02-01" and "2007-02-02" and stores it in a new dataframe
# Be careful the date in the file are coded day/month/year but without leading "0" for the first 9 days/months
hpc <- subset(all_hpc, Date=="1/2/2007" | Date=="2/2/2007")

# Removes the big dataframe from memory to save space
rm(all_hpc)

# Transforms Date field to a POSIXlt class contaning both the Date and Time
# As I am in France, I have Sys.getlocale(category = "LC_TIME") equals to "fr_FR.UTF-8",
# so to have the same name of day as instructed, I need to set my locale to en_US
Sys.setlocale("LC_TIME", "en_US.UTF-8")

# Used paste to concatenate the Date and Time character beforing doing the conversion
hpc <- transform(hpc, Date = strptime(paste(Date,Time, sep = " "), format = "%d/%m/%Y %H:%M:%S"))

# This should be loaded by default but we need to be sure
library(datasets)
library(graphics)
library(grDevices)

# Parameters for the PNG file
plot_width  <- 480
plot_height <- 480
png_name <- "plot3.png"
img_directory <- "figure"
file_name <- paste(img_directory,png_name,sep="/")

# Create the figure directory if not existing
if (!file.exists(img_directory)) {
        dir.create(img_directory)
}

# For some unknown reason to me, if I create the plot on the screen first and then copy to png file, the legend is truncated in width...
# So I directly open the PNG device
png(filename = file_name, width = plot_width, height = plot_height)

# Sets the device to have only 1 graph
par(mfrow=c(1,1))

plot(hpc$Date, hpc$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", col="black")
lines(hpc$Date, hpc$Sub_metering_2, col="red")
lines(hpc$Date, hpc$Sub_metering_3, col="blue")
legend("topright", lwd = 1, col = c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Don't forget to close the file device
dev.off()