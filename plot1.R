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
data$Date<-as.Date(data$Date, '%d/%m/%Y')

# Select data subset between 2007-02-01 and 2007-02-02
subset<-data[as.Date(data$Date, '%d/%m/%Y') >= as.Date('2007-02-01') & 
             as.Date(data$Date, '%d/%m/%Y') <= as.Date('2007-02-02'), ]

# Make the histogram plot
png('plot1.png', width=480, height=480, units='px')
hist(
        subset$Global_active_power, 
        col='red', 
        main='Global Active Power', 
        xlab='Global Active Power (kilowatts)'
)
dev.off()