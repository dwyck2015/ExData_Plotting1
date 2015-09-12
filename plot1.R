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

# plot 1
png(filename = "plot1.png", width = 480, height = 480)
with(dat, hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)") )
dev.off()
