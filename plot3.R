#clear the cache (comment out if other stuff is open !)
rm(list=ls())
#Read file from current directory
hPow <- read.table('household_power_consumption.txt'
                   ,header=TRUE,sep=';',stringsAsFactors=FALSE)



hPow_sub <- subset(hPow,Date=='1/2/2007' | Date=='2/2/2007')
rm(hPow) #Clear the memory

#Likely a very messy way to do it... timestamp column
hPow_sub$timestamp <- strptime((paste(hPow_sub$Date,
                                      format(
                                        strptime(hPow_sub$Time,format='%H:%M:%S')
                                        ,"%H:%M:%S"))),'%d/%m/%Y %H:%M:%S')
hPow_sub$Date<-as.Date(strptime(hPow_sub$Date,"%d/%m/%Y"))
hPow_sub$Time <- strptime(hPow_sub$Time,'%H:%M:%S',format="%H:%M:%S")

hPow_sub$Voltage = as.numeric(hPow_sub$Voltage)
hPow_sub$Global_intensity = as.numeric(hPow_sub$Global_intensity)
hPow_sub$Global_active_power = as.numeric(hPow_sub$Global_active_power)
hPow_sub$Global_reactive_power = as.numeric(hPow_sub$Global_reactive_power)
hPow_sub$Sub_metering_1 = as.numeric(hPow_sub$Sub_metering_1)
hPow_sub$Sub_metering_2 = as.numeric(hPow_sub$Sub_metering_2)
hPow_sub$Sub_metering_3 = as.numeric(hPow_sub$Sub_metering_3)

#plot
png(filename='plot3.png',width=480,height=480)
with(hPow_sub,plot(timestamp,Sub_metering_1,type="n",xlab=""
                   ,ylab="Energy sub metering"))
points(hPow_sub$timestamp,hPow_sub$Sub_metering_1,type="l",col="black")
points(hPow_sub$timestamp,hPow_sub$Sub_metering_2,type="l",col="red")
points(hPow_sub$timestamp,hPow_sub$Sub_metering_3,type="l",col="blue")
legend("topright"
       ,c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,col=c("black","red","blue")
       ,lwd=1)
dev.off()