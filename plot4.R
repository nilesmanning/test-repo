## intial check of dataset
initial<-read.csv("household_power_consumption.txt",sep=";",nrow=100)

##check class of dataset columns
classes <- sapply(initial, class)

##prepare classes vector to be used in read.csv function
classes<-c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")

##read dataset into dataframe energy
energy<- read.csv("household_power_consumption.txt",colClasses=classes,sep=";",na.strings="?") 

## subset for the two dates that will be used in the project
energy<-subset(energy,Date=="1/2/2007"| Date=="2/2/2007")

##convert Date to date class
energy$Date<-as.Date(energy$Date, "%d/%m/%Y")

#add gTime column to energy in POSIXTlt class so as to use it in the graphs
energy$gTime<-as.POSIXlt(paste(energy$Date,energy$Time,sep=" "))




## open png device
png(file="plot4.png", width=480, height=480)

## code for four plots per screen
par(mfrow = c(2, 2))

## graph
with(energy, {
        plot(gTime,Global_active_power,"l",xlab="",ylab="Global Active Power (kilowatts)") 
        plot(gTime,Voltage,"l",xlab="datetime",ylab="Voltage")
        plot(gTime,Sub_metering_1,"l",col="black",xlab="",ylab="Energy sub metering")                
        lines(gTime,Sub_metering_2,col="red")
        lines(gTime,Sub_metering_3,col="blue")
        legend("topright", lty=1,col =c("black","red","blue"),cex=.7, bty="n",
               legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
        plot(gTime,Global_reactive_power,"l",xlab="",ylab="Global_reactive_power")
        axis(side=2 , at = c(0.0,0.1,0.2,0,3,0.4,0.5))
        })



##plot(energy$gTime,energy$Global_active_power,"l",xlab="",ylab="Global Active Power (kilowatts)")

##close png device
dev.off()
