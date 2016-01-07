## plot the fourth figure of Project 1

# Read data
HPC <-read.table("household_power_consumption.txt", header = TRUE,
                 sep = ";", na.strings = "?", nrows = 2075259)

# Format date
# Note: The format of date and time is: m/d/yyyy hh:mm:ss 
# e.g., 23/12/2006 23:59:00 / 4/6/2007 09:01:00
HPC[, 1] <- as.Date(HPC[, 1], "%e/%m/%Y")

# Subset data
Query <- HPC[which(HPC[, 1] >= as.Date("2007-02-01") & 
                     HPC[, 1] <= as.Date("2007-02-02")), ]

# Merge date and time
Query$datetime <- with(Query, as.POSIXct(paste(Date, Time), 
                                         format="%Y-%m-%d %H:%M:%S"))

# Plot the figure
png("plot4.png")

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(1, 1, 0, 0))
with(Query, {
        plot(Query[, 3] ~ Query[, 10], type = "l", xlab = "", 
             ylab = "Global Active Power")

        plot(Query[, 5] ~ Query[, 10], type = "l", xlab = "datetime", 
             ylab = "Voltage")
        
        plot(Query[, 10], Query[, 7], type = "l", xlab = "", 
                             ylab = "Energy sub metering", col = "black")
        with(subset(Query), points(Query[, 10], Query[, 8], type = "l", xlab = "", 
                                       ylab = "", col = "red"))
        with(subset(Query), points(Query[, 10], Query[, 9], type = "l", xlab = "", 
                                       ylab = "", col = "blue"))
        legend("topright", bty = "n", lwd = 1, col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        plot(Query[, 4] ~ Query[, 10], type = "l", xlab = "datetime", 
             ylab = "Global_reactive_power")
})

dev.off()