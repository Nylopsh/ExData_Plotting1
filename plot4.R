# load dataset
hpc <- data.frame(read.table("household_power_consumption.txt", header = T, sep = ";", na.strings= c("?","")))

# The data hpc has many many dates, we only want Feb 1 and 2 from 2007
# The variable data has dd/mm/yyyy

hpc2 <- hpc[hpc$Date == "1/2/2007" | hpc$Date == "2/2/2007",]

# Per day there are 1440 datapoints. With hh:mm:ss
# Make a new variable to get both date and time
Sys.setlocale("LC_TIME", "English")
hpc2$DateTime <- strptime(paste(hpc2$Date,hpc2$Time, sep=" "), format = "%d/%m/%Y %H:%M:%S")


# plot 4 is 4 plots in one. 
# the upper left plot is plot 2
# the lower left plot is plot 3
# the upper right plot is a line of voltage per timeslot
# the lower right plot is a line of global reactive power per timeslot.


# making the plot in png
png("plot4.png", width = 480, height = 480)

# making a frame for four plots
par(mfcol = c(2,2))
with(hpc2, {
  #upper left
  plot(hpc2$DateTime,hpc2$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)" )
  
  #lower left
  plot(hpc2$DateTime,hpc2$Sub_metering_1, type = "l", col = "black", xlab = " ", ylab = "Energy sub metering")
  lines(hpc2$DateTime,hpc2$Sub_metering_2, col = "red")
  lines(hpc2$DateTime,hpc2$Sub_metering_3, col = "blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black", "red", "blue"))
  
  #upper right
  plot(hpc2$DateTime,hpc2$Voltage, type="l", xlab = "datetime", ylab = "Voltage" )
  
  #lower right
  plot(hpc2$DateTime,hpc2$Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reative power" )
})

# close so that it will be saved
dev.off()
