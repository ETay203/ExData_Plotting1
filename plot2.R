
##download the power consumption data to a folder called "data"in your working directory
if(!file.exists("data")){
        dir.create("data")
}
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./data/household_power_consumption.zip")
list.files("./data")

## unzip the files
setwd("data")
unzip("household_power_consumption.zip")

##read the data
power.data<-read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                       na.strings = "?", stringsAsFactors = FALSE )

##convert the Date and Time variables to Date/Time classes 
##strptime() and as.Date() functions.
power.data$Date<-as.Date(power.data$Date, "%d/%m/%Y" )
power.data$Time<-strptime(paste(power.data$Date, power.data$Time), format = "%d/%m/%Y %H:%M:%S")

##subset data to the dates 2007-02-01 and 2007-02-02
subset<-power.data[(power.data$Date =="2007-02-01" | power.data$Date =="2007-02-02"),]


##plot2
png(filename = "plot2.png", width = 480, height = 480)
with(subset, {
        plot(Time, Global_active_power, type = "n", 
             ylab = "Global Active Power (kilowatts)", xlab = "")
        lines(Time, Global_active_power)
})
dev.off()
