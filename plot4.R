# Download and extract the data
if(!file.exists('household_power_consumption.txt')) {
        download.file(
                'https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip', 
                destfile='household_power_consumption.zip'
        )
        unzip('household_power_consumption.zip')
        unlink('household_power_consumption.zip')
}

# Import data to the table
data<-read.table(
        'household_power_consumption.txt', 
        header=TRUE, 
        sep=';', 
        stringsAsFactors=FALSE, 
        na.strings='?'
)

# Select data subset between 2007-02-01 and 2007-02-02
subset<-data[as.Date(data$Date, '%d/%m/%Y') >= as.Date('2007-02-01') & 
                     as.Date(data$Date, '%d/%m/%Y') <= as.Date('2007-02-02'), ]

# Parse date and time columns to create new column with date/time value
subset$DateTime<-strptime(paste(subset$Date, subset$Time, sep = ' '), '%d/%m/%Y %H:%M:%S')

# Make the plot
png('plot4.png', width=480, height=480, units='px')
par(mfrow=c(2, 2), ps = 13)
plot(
        subset$DateTime,
        subset$Global_active_power, 
        type='l', 
        xlab='',
        ylab='Global Active Power'
)
plot(
        subset$DateTime,
        subset$Voltage, 
        type='l', 
        xlab='datetime',
        ylab='Voltage'
)
plot(
        subset$DateTime,
        subset$Sub_metering_1, 
        type='l', 
        xlab='',
        ylab='Energy sub metering'
)
lines(
        subset$DateTime,
        subset$Sub_metering_2, 
        col="red"
)
lines(
        subset$DateTime,
        subset$Sub_metering_3, 
        col="blue"
)
legend(
        'topright', 
        c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
        lty=1, 
        bty='n',
        col=c('black', 'red', 'blue')
)
plot(
        subset$DateTime,
        subset$Global_reactive_power, 
        type='l', 
        xlab='datetime',
        ylab='Global_reactive_power'
)
dev.off()