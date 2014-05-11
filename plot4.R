# Course Project 1 
# PLOT 4
# -----------------------


# Read data from file .txt (in the same dir as the .R file)
# ---------------------------------------------------------
# Read only the lines from 66638 to 69517, which correspond to 01-02 February 2007
dat <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
            col.names = c("Date", "Time", "Global_active_power", 
                                    "Global_reactive_power", "Voltage", 
                                    "Global_intensity", "Sub_metering_1", 
                                    "Sub_metering_2", "Sub_metering_3"),
            colClasses = c(rep("character",2),rep("numeric",7)),
            skip = 66636, nrows = 2880, dec = ".")


# Verify that data is in the specified period
head(dat); tail(dat)
# Concatenate Date/Time and convert them to their classes
aux <- paste(dat[,1], dat[,2])
aux <- strptime(aux, format="%d/%m/%Y %H:%M:%S")
# Create the column Date/Time
dat[ ,1] <- as.data.frame(aux)
# Delete unused column Time
dat <- dat[, -2]


# Plot 4 -  plotting multiple figures in "matrix" format 
#           and saving in .png format
# ---------------------------------------------------------
png("plot4.png", width = 480, height = 480)

# creates the "matrix" for the four plots
par(mfcol = c(2,2))

# plot top-left
plot(dat$Date, dat$Global_active_power, type = "l", xlab = NA,
        ylab="Global Active Power (kilowatts)")

# plot bottom-left
plot(dat$Date, dat$Sub_metering_1, type = "l", xlab = NA, col = "black",
        ylab="Energy sub metering") 
lines(dat$Date, dat$Sub_metering_2, col = "red")
lines(dat$Date, dat$Sub_metering_3, col = "blue") 
legend("topright", col = c("black", "red", "blue"), lty = c(1, 1, 1),
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# plot top-right
plot(dat$Date, dat$Voltage, type = "l", xlab = "datetime", ylab="Voltage")

# plot bottom-right
plot(dat$Date, dat$Global_reactive_power, type = "l", xlab = "datetime", 
    ylab="Global_reactive_power")

dev.off()