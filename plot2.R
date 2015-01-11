# load dataset
hpc <- data.frame(read.table("household_power_consumption.txt", header = T, sep = ";", na.strings= c("?","")))

# The data hpc has many many dates, we only want Feb 1 and 2 from 2007
# The variable data has dd/mm/yyyy

hpc2 <- hpc[hpc$Date == "1/2/2007" | hpc$Date == "2/2/2007",]

# Per day there are 1440 datapoints. With hh:mm:ss
# Make a new variable to get both date and time
Sys.setlocale("LC_TIME", "English")
hpc2$DateTime <- strptime(paste(hpc2$Date,hpc2$Time, sep=" "), format = "%d/%m/%Y %H:%M:%S")


# plot 2 is a line plot of all the values of Global Active Power per timeslot.

# making the plot in png
png("plot2.png", width = 480, height = 480)

plot(hpc2$DateTime,hpc2$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)" )

# close so that it will be saved
dev.off()

