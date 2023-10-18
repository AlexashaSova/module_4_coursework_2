# TASK-1 
# 1. Have total emissions from PM2.5 decreased in the United States 
# from 1999 to 2008? Using the base plotting system, 
# make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.


## step - 1 loading data

# data paths
summary_rds_file <- "data/summarySCC_PM25.rds"
source_codes_rds_file <- "data/Source_Classification_Code.rds"

# reading file
df_summary <- readRDS(summary_rds_file)
# head(df_summary)

## step - 2 creating plot

# calculate
pm_emissions_per_year <- aggregate(Emissions ~ year, 
                                   df_summary, 
                                   sum)

# plot
colors <- c("darkblue", "blue", "lightblue", "seagreen")
barplot(height = pm_emissions_per_year$Emissions/1000, 
        names.arg = pm_emissions_per_year$year, 
        xlab = "Year", 
        ylab = "Amount of pm2.5 emissions",
        main = "Amount of PM2.5 emissison through years", 
        col = colors)

# save to PNG
dev.copy(png, 
         file = "plot1.png", 
         width = 480, 
         height = 480)
dev.off()

# emissions decreased