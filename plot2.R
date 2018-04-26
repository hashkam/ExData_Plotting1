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

##Load data
data <- loaddata()

##Set PNG Device
png("plot2.png", width=480, height=480)

##Set layout
par(mfrow = c(1,1))

##Make second plot
plot2(data)

## Close PNG Device
dev.off()