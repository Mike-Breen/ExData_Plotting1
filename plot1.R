plot1 <- function(){
  
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
  
  ## Plot the histogram
  hist(plot_data_feb$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
  
  ##  Open and copy the plot to the .png file
  dev.copy(png,file = "plot1.png")
  
  ## Close the .png file
  dev.off()
  
}