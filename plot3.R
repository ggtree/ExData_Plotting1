## plot the third figure of Project 1

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
png("plot3.png")
with(Query, plot(Query[, 10], Query[, 7], type = "l", xlab = "", 
                     ylab = "Energy sub metering", col = "black"))
with(subset(Query), points(Query[, 10], Query[, 8], type = "l", xlab = "", 
                     ylab = "", col = "red"))
with(subset(Query), points(Query[, 10], Query[, 9], type = "l", xlab = "", 
                               ylab = "", col = "blue"))
legend("topright", lwd = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()