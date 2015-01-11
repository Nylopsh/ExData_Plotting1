# load dataset
hpc <- data.frame(read.table("household_power_consumption.txt", header = T, sep = ";", na.strings= c("?","")))

# The data hpc has many many dates, we only want Feb 1 and 2 from 2007
# The variable data has dd/mm/yyyy

hpc2 <- hpc[hpc$Date == "1/2/2007" | hpc$Date == "2/2/2007",]

# plot 1 is just a histogram with the frequency of Global Active Power in kilowatts.

# Get the variable Global_active_power to a new variable
# R doesn't see the variable as numeric..
gap <- hpc2$Global_active_power
g <- table(cut(gap, br = .25* (0:24)))

# making the plot in png
png("plot1.png", width = 480, height = 480)

# Making the histogram,
hist(gap, freq=T, col="red", border="black", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

# close so that it will be saved
dev.off()
