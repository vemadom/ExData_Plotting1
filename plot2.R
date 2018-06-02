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

## Adjusting variables Time and Global_active_power
arq_ok$Time <- strptime(paste(arq_ok$Date,arq_ok$Time), "%Y-%m-%d %H:%M:%S")
arq_ok$Global_active_power <- as.numeric(as.character(arq_ok$Global_active_power))

## Produce PNG
png("plot2.png", width=480, height=480)
plot(arq_ok$Time, arq_ok$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
