# TASK-2 
# 2. Have total emissions from PM2.5 decreased in the Baltimore City,
# Maryland (fips == “24510”) from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.


## step - 1 loading data

# data paths
summary_rds_file <- "data/summarySCC_PM25.rds"
source_codes_rds_file <- "data/Source_Classification_Code.rds"

# reading file
df_summary <- readRDS(summary_rds_file)
# head(df_summary)
baltimore_emissions_df <- df_summary[df_summary$fips == "24510", ]

## step - 2 creating plot

# calculate
baltimore_emissions <- aggregate(Emissions ~ year, 
                                 baltimore_emissions_df, 
                                 sum)

# plot
colors <- c("darkblue", "blue", "lightblue", "seagreen")
barplot(height = baltimore_emissions$Emissions/1000, 
        names.arg = baltimore_emissions$year, 
        xlab = "Year", 
        ylab = "Amount of pm2.5 emissions",
        main = "Amount of PM2.5 emissison in Baltimore City, Maryland, through years", 
        col = colors)

# save to PNG
dev.copy(png, 
         file = "plot2.png", 
         width = 480, 
         height = 480)
dev.off()

# emissions decreased by the year 2008 compared to 1999
