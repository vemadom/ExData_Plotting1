setwd("C:/Users/Ivan Vermado/Desktop/coursera")

file <- "Electric power consumption.zip"

## Downloading and unziping the dataset
if (!file.exists(file)){
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, file, mode = "wb")
}  
if (file.exists("Electric power consumption.zip")) { 
  unzip(file)
}

## Reading file
arq <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")

## Adjusting datetime and selecting subdataset
arq$Date <- as.Date(arq$Date, "%d/%m/%Y")
arq_ok <- subset(arq, Date >= "2007-02-01" & Date <= "2007-02-02")

## Freeing space
rm(arq)

## Adjusting variables
arq_ok$Time <- strptime(paste(arq_ok$Date,arq_ok$Time), "%Y-%m-%d %H:%M:%S")
arq_ok$Global_active_power <- as.numeric(as.character(arq_ok$Global_active_power))
arq_ok$Voltage <- as.numeric(as.character(arq_ok$Voltage))
arq_ok$Sub_metering_1 <- as.numeric(as.character(arq_ok$Sub_metering_1))
arq_ok$Sub_metering_2 <- as.numeric(as.character(arq_ok$Sub_metering_2))
arq_ok$Sub_metering_3 <- as.numeric(as.character(arq_ok$Sub_metering_3))
arq_ok$Global_reactive_power <- as.numeric(as.character(arq_ok$Global_reactive_power))


## Produce PNG
png("plot4.png", width=480, height=480)

par(mfrow = c(2,2))

plot(arq_ok$Time, arq_ok$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

plot(arq_ok$Time, arq_ok$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(arq_ok$Time, arq_ok$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(arq_ok$Time, arq_ok$Sub_metering_2, type = "l", col = "red")
lines(arq_ok$Time, arq_ok$Sub_metering_3, type = "l", col = "blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = 1, cex = 0.8, bty="n")

plot(arq_ok$Time, arq_ok$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
