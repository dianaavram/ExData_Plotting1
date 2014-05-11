
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


# Preparing the data for plotting, by creating a new data.frame
electric <- data.frame(date = dat$Date, gap = dat$Global_active_power)
#figure out the lowest and highest dates
daterange <- c(as.POSIXlt(min(electric$date)),as.POSIXlt(max(electric$date)))

# Plot 2 -  plotting "Global Active Power" by day 
#           and saving in .png format
# ---------------------------------------------------------
png("plot2.png", width = 480, height = 480)
plot(electric$date, electric$gap, type = "l", xlab = NA,
        ylab="Global Active Power (kilowatts)") 
axis.POSIXct(1, at=seq(daterange[1], daterange[2], by="day"), format="%a") #label the x axis by days
dev.off()