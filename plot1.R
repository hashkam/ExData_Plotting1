loaddata <- function() {
  file <- "household_power_consumption.txt"
  data <- read.table(file,header=TRUE,sep=";",na.strings = "?", stringsAsFactors = FALSE)
  data$DateTime <- as.POSIXlt(paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S")
  data <- data[c(10,3:ncol(data)-1)]
  start_date <- as.Date("2007-02-01",format="%Y-%m-%d")
  end_date <- as.Date("2007-02-02",format="%Y-%m-%d")
  data <- data[as.Date(data$DateTime) >= start_date & as.Date(data$DateTime) <= end_date, ]
}

plot1 <- function(data) {
  hist(data$Global_active_power,main="Global Active Power", xlab="Global Active Power (kilowatts)",col="red")
}

##Load data
data <- loaddata()

##Set PNG Device
png("plot1.png", width=480, height=480)

##Set layout
par(mfrow = c(1,1))

##Make first plot
plot1(data)

## Close PNG Device
dev.off()