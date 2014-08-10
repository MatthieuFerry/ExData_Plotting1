## Creation of graphic 1
# Loading the data from the CSV file using read.csv2 to handle ';' separator, assuming the file is 2 directories above the repo directory
hpc<-read.csv2("../../household_power_consumption.txt",na.strings = "?",stringsAsFactors=F,dec = ".")
#Extracts the subset between the dates "2007-02-01" and "2007-02-02"
j<-1
date1<-as.Date("2007-02-01","%Y-%m-%d")
date2<-as.Date("2007-02-02","%Y-%m-%d")
nrows<-nrow(hpc)
hpc_subset<-matrix(nrows,9)
for (i in 1:nrows) {
        date<-as.Date(hpc$Date[i],"%d/%m/%Y")
        if (date>=date1 && date<=date2) {
                time<-strptime(hpc$Time[i],"%H:%M:%S")
                hpc_subset[j,]<-c(date,time,hpc[i,])
                j<-j+1
        }
}
library(datasets)
hist(hpc_subset$Global_active_power,main = "Global Active Power",xlab = "Global Active Power (kilowatts)",col="red")