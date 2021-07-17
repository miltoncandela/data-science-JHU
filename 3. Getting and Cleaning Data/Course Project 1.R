# Course Project 1
# Milton Osiel Candela Leal
# 16/10/2020

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = '?', 
                   colClasses = c('character', 'character', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'))
correct <- subset(data, Date == '1/2/2007' | Date == '2/2/2007')
par(mfrow = c(1,1))

## Plot 1
hist(correct$Global_active_power, xlab = 'Global Active Power (kilowatts)', main = 'Global Active Power', col = 'red')
dev.copy(png,"plot1.png", width = 480, height = 480)
dev.off()

## Plot 2
correct <- transform(correct, Date = as.Date(Date, "%d/%m/%Y"))

combi <- paste(correct$Date, correct$Time)
combi <- setNames(combi, "Combinados")
correct <- cbind(combi, correct)
correct$combi <- as.POSIXct(correct$combi,"%Y-%m-%d %H:%M:%S", tz = 'UTC')

with(correct, plot(Global_active_power ~ combi, type = 'l', xlab = '', ylab = 'Global Active Power (kilowatts)'))
dev.copy(png,"plot2.png", width = 480, height = 480)
dev.off()

## Plot 3
with(correct, plot(Sub_metering_1 ~ combi, type = 'l', col = 'black', ylab = 'Energy sub metering'))
with(correct, lines(Sub_metering_2 ~ combi, type = 'l', col = 'red'))
with(correct, lines(Sub_metering_3 ~ combi, type = 'l', col = 'blue'))
xlab('')
legend('topright', c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), col = c('black', 'red', 'blue'), pch = '_')
dev.copy(png,"plot3.png", width = 480, height = 480)
dev.off()

## Plot 4
par(mfrow = c(2,2))
with(correct, plot(Global_active_power ~ combi, type = 'l', xlab = '', ylab = 'Global Active Power'))
with(correct, plot(Voltage ~ combi, type = 'l', xlab = 'datetime', ylab = 'Voltage'))
with(correct, plot(Sub_metering_1 ~ combi, type = 'l', col = 'black', ylab = 'Energy sub metering'))
with(correct, lines(Sub_metering_2 ~ combi, type = 'l', col = 'red'))
with(correct, lines(Sub_metering_3 ~ combi, type = 'l', col = 'blue'))
xlab('')
legend('topright', c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), col = c('black', 'red', 'blue'), pch = '_')
with(correct, plot(Global_reactive_power ~ combi, type = 'l', xlab = 'datetime', ylab = 'Global_reactive_power'))
dev.copy(png,"plot4.png", width = 480, height = 480)
dev.off()


