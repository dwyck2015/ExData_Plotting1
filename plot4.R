setwd("C:\\Users\\user\\Exploratory")

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "exdata-data-household_power_consumption.zip", method = "internal")
dateDownloaded <- date()
unzip("exdata-data-household_power_consumption.zip")
files <- list.files(); files
header <- read.table(files[2], nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)
data <- read.table(files[2], sep=";", na.strings = "?", header=FALSE, skip=66637) #colClasses=c("Date","NULL",rep("numeric",7)), 
colnames(data) <- header
data$Date <- as.character(data$Date); data$Time <- as.character(data$Time)
data$datetime <- paste(data$Date, data$Time)
dat <- subset(data, data$Date == "1/2/2007" |  data$Date == "2/2/2007")
dat$datetime <- as.POSIXct(dat$datetime, format="%d/%m/%Y %H:%M:%S")

# plot 4
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
# 1
with(dat, plot(datetime, Global_active_power, type="l", ylab="Global Active Power", xlab="") )
# 2
with(dat, plot(datetime, Voltage, type="l"))
# 3
with(dat, plot(datetime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="") )
lines(dat$datetime, dat$Sub_metering_2, type="l", col="red")
lines(dat$datetime, dat$Sub_metering_3, type="l", col="blue")
legend("topright", legend=names(dat[7:9]), col=c("black","red","blue"), lty=1, bty="n")
# 4
with(dat, plot(datetime, Global_reactive_power, type="l" ))
dev.off()
