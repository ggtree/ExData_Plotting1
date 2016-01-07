## plot the first figure of Project 1

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

# plot the figure
png("plot1.png")
hist(Query[, 3], col = "red", breaks = 20, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()