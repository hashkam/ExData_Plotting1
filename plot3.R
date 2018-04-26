loaddata <- function() {
  file <- "household_power_consumption.txt"
  data <- read.table(file,header=TRUE,sep=";",na.strings = "?", stringsAsFactors = FALSE)
  data$DateTime <- as.POSIXlt(paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S")
  data <- data[c(10,3:ncol(data)-1)]
  start_date <- as.Date("2007-02-01",format="%Y-%m-%d")
  end_date <- as.Date("2007-02-02",format="%Y-%m-%d")
  data <- data[as.Date(data$DateTime) >= start_date & as.Date(data$DateTime) <= end_date, ]
}

plot3 <- function(data) {
  ymax <- max(c(max(data$Sub_metering_1),max(data$Sub_metering_2),max(data$Sub_metering_3)))
  plot(data$DateTime,data$Sub_metering_1, xlab="", ylab = "Energy sub metering",type="l",ylim=range(c(0,ymax)))
  lines(data$DateTime,data$Sub_metering_2,type="l",col="red")
  lines(data$DateTime,data$Sub_metering_3,type="l",col="blue")
  legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"))
}

##Load data
data <- loaddata()

##Set PNG Device
png("plot3.png", width=480, height=480)

##Set layout
par(mfrow = c(1,1))

##Make second plot
plot3(data)

## Close PNG Device
dev.off()