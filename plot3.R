#read the data 
HPC <- read_delim("household_power_consumption.txt", 
                  ";", escape_double = FALSE, trim_ws = TRUE)
View(HPC)
#Concatenate the date and time, and convert the Date and Time variables to Date/Time classes
Date_Time <- strptime(paste(HPC$Date, HPC$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
HPC <- cbind(Date_Time, HPC)
View(HPC)
#make the subset data that has the date "1/2/2007" or Date=="2/2/2007"
sub_data<-subset(HPC, Date=="1/2/2007" | Date=="2/2/2007")
View(sub_data)

sub_data$Date <- as.Date(sub_data$Date, format="%d/%m/%Y")
sub_data$Time <- format(sub_data$Time, format="%H:%M:%S")
sub_data$Global_active_power <- as.numeric(sub_data$Global_active_power)
sub_data$Global_reactive_power <- as.numeric(sub_data$Global_reactive_power)
sub_data$Voltage <- as.numeric(sub_data$Voltage)
sub_data$Global_intensity <- as.numeric(sub_data$Global_intensity)
sub_data$Sub_metering_1 <- as.numeric(sub_data$Sub_metering_1)
sub_data$Sub_metering_2 <- as.numeric(sub_data$Sub_metering_2)
sub_data$Sub_metering_3 <- as.numeric(sub_data$Sub_metering_3)

#make the plot and save it as png format 
png("plot3.png",width=480, height=480) 
with(sub_data, plot(Date_Time, Sub_metering_1,type="n",xlab="",ylab="Energy sub metering"))
lines(sub_data$Date_Time, sub_data$Sub_metering_1,type="l", col= "black")
lines(sub_data$Date_Time, sub_data$Sub_metering_2,type="l", col= "red")
lines(sub_data$Date_Time, sub_data$Sub_metering_3,type="l", col= "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty= 1, lwd=2)
dev.off()