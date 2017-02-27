plot3 <- function(){
  
  power_data_raw <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
  print("Data read complete")
  
  power_data_raw$Date <- as.Date(power_data_raw$Date,"%d/%m/%Y")
  print("Date conversion complete")
  
  power_data_raw$Time <- strptime(paste(power_data_raw$Date,power_data_raw$Time),"%Y-%m-%d %H:%M:%S")
  print("Time conversion complete")
  
  plot_data_feb <- subset(power_data_raw, Date >= "2007-02-01")
  plot_data_feb <- subset(plot_data_feb, Date <= "2007-02-02")
  print("Data subsetting complete")
  
  ## Change the Global_active_power column from factors to numeric
  plot_data_feb$Global_active_power <- as.numeric(paste(plot_data_feb$Global_active_power))
  
  ## Change the Sub_metering columns from factors to numeric
  plot_data_feb$Sub_metering_1 <- as.numeric(paste(plot_data_feb$Sub_metering_1))
  plot_data_feb$Sub_metering_2 <- as.numeric(paste(plot_data_feb$Sub_metering_2))
  plot_data_feb$Sub_metering_3 <- as.numeric(paste(plot_data_feb$Sub_metering_3))
  
  ## Plot the scatterplot
  with(plot_data_feb,plot(Time,Sub_metering_1, 
                          ylab = "Energy sub metering", type = "l"))
  with(plot_data_feb,lines(Time,Sub_metering_2, col = "red"))
  with(plot_data_feb,lines(Time,Sub_metering_3, col = "blue"))
  
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = names(plot_data_feb)[7:9]
                          , cex = 0.5, merge = TRUE)
  
  ## Open and copy the plot to the .png file
  dev.copy(png,file = "plot3.png")
  
  ## Close the .png file
  dev.off()
  
}