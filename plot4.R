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


##plot4
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
with(subset, {
        #plot4.1
        plot(Time, Global_active_power, type = "n", 
             ylab = "Global Active Power (kilowatts)", xlab = "")
        lines(Time, Global_active_power)
        #plot4.2
        plot(Time, Voltage, type = "n",
             ylab = "Voltage", xlab = "datetime")
        lines (Time, Voltage)
        
        #plot4.3
        plot(Time, Sub_metering_1, type = "n", 
             ylab = "Energy sub metering", xlab = "")
        lines(Time, Sub_metering_1, col = "black")
        lines(Time, Sub_metering_2, col = "red")
        lines(Time, Sub_metering_3, col = "blue")
        legend("topright", lty = 1, col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
        
        #plot4.4
        plot(Time, Global_reactive_power, type = "n", 
             ylab = "Global_reactive_power", xlab = "datetime")
        lines(Time, Global_reactive_power)
        
})
dev.off()