loaddata <- function() {
  file <- "household_power_consumption.txt"
  data <- read.table(file,header=TRUE,sep=";",na.strings = "?", stringsAsFactors = FALSE)
  data$DateTime <- as.POSIXlt(paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S")
  data <- data[c(10,3:ncol(data)-1)]
  start_date <- as.Date("2007-02-01",format="%Y-%m-%d")
  end_date <- as.Date("2007-02-02",format="%Y-%m-%d")
  data <- data[as.Date(data$DateTime) >= start_date & as.Date(data$DateTime) <= end_date, ]
}

plot2 <- function(data) {
  plot(data$DateTime,data$Global_active_power, xlab="", ylab = "Global Active Power (kilowatts)",type="l")
}

plot3 <- function(data) {
  ymax <- max(c(max(data$Sub_metering_1),max(data$Sub_metering_2),max(data$Sub_metering_3)))
  plot(data$DateTime,data$Sub_metering_1, xlab="", ylab = "Energy sub metering",type="l",ylim=range(c(0,ymax)))
  lines(data$DateTime,data$Sub_metering_2,type="l",col="red")
  lines(data$DateTime,data$Sub_metering_3,type="l",col="blue")
  legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"),bty="n")
}

plot4 <- function(data) {
  plot2(data)
  plot(data$DateTime,data$Voltage,type="l",ylab="Voltage",xlab="")
  plot3(data)
  plot(data$DateTime,data$Global_reactive_power,type="l",ylab="Global Reactive Power",xlab="")
}

##Load data
data <- loaddata()

##Set PNG Device
png("plot4.png", width=480, height=480)

##Set layout
par(mfrow = c(2,2))

##Make second plot
plot4(data)

## Close PNG Device
dev.off()