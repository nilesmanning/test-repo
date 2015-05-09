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

#add gTime column to POSIXTlt so as to use it in the graphs
energy$gTime<-as.POSIXlt(paste(energy$Date,energy$Time,sep=" "))




## open png device
png(file="plot3.png", width=480, height=480)

## graph
plot(energy$gTime,energy$Sub_metering_1,"l",col="black",xlab="",ylab="Energy sub metering")
lines(energy$gTime,energy$Sub_metering_2,col="red")
lines(energy$gTime,energy$Sub_metering_3,col="blue")
legend("topright", lty=1,col = c("black", "red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

##close png device
dev.off()
