plot4 <- function(){
  
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
  
  ## same for Voltage column
  plot_data_feb$Voltage <- as.numeric(paste(plot_data_feb$Voltage))
  
  ## same for Global_reactive_power column
  plot_data_feb$Global_reactive_power <- as.numeric(paste(plot_data_feb$Global_reactive_power))
  
  ## Set the multiple plot parameter
  par(mfrow = c(2,2))
  
  ## Plot the 1st scatterplot (top left)
  with(plot_data_feb,plot(Time,Global_active_power, 
                          ylab = "Global Active Power (kilowatts)", type = "l"))
  
  ## Plot the 2nd scatterplot (top right)
  with(plot_data_feb,plot(Time,Voltage, 
                          ylab = "Voltage", xlab = "datetime", type = "l"))
  
  ## Plot the 3rd scatterplot (bottom left)
  with(plot_data_feb,plot(Time,Sub_metering_1, 
                          ylab = "Energy sub metering", type = "l"))
  with(plot_data_feb,lines(Time,Sub_metering_2, col = "red"))
  with(plot_data_feb,lines(Time,Sub_metering_3, col = "blue"))
  
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = names(plot_data_feb)[7:9]
         , cex = 0.125, merge = TRUE)
  
  ## Plot the 4th scatterplot (bottom right)
  with(plot_data_feb,plot(Time,Global_reactive_power, 
                          ylab = "Global_reactive_power", xlab = "datetime", type = "l"))
  
  
  ## Open and copy the plot to the .png file
  dev.copy(png,file = "plot4.png")
  
  ## Close the .png file
  dev.off()
  
}