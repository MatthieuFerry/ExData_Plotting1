## Creation of graphic 1
# Loading the data from the CSV file using read.csv2 to handle ';' separator, assuming the file is 2 directories above the repo directory
hpc<-read.csv2("../../household_power_consumption.txt",na.strings = "?",stringsAsFactors=F,dec = ".")
#Extracts the subset between the dates "2007-02-01" and "2007-02-02"
j<-1
date1<-as.Date("2007-02-01","%Y-%m-%d")
date2<-as.Date("2007-02-02","%Y-%m-%d")
for (i in 1:nrow(hpc)) {
        hpc$Date[i]<-as.Date(hpc$Date[i],"%d/%m/%Y")
        if (hpc$Date[i]>=date1 && hpc$Date[i]<=date2) {
                hpc_subset[j]<-hpc[i]
                hpc_subset$Time[j]<-strptime(hpc_subset$Time[j],"%H:%M:%S")
                j<-j+1
        }
}
library(datasets)
hist(hpc_subset$Global_active_power,main = "Global Active Power",xlab = "Global Active Power (kilowatts)",col="red")