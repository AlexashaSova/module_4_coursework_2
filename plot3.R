# TASK-3 
# 3. Of the four types of sources indicated by the 
# type(point, nonpoint, onroad, nonroad) variable, which of these four sources 
# have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? Use the ggplot2
# plotting system to make a plot answer this question.

library(ggplot2)

## step - 1 loading data

# data paths
summary_rds_file <- "data/summarySCC_PM25.rds"
source_codes_rds_file <- "data/Source_Classification_Code.rds"

# reading file
df_summary <- readRDS(summary_rds_file)
# head(df_summary)
# subsetting values as at the previous task (plot-2)
baltimore_emissions_df <- df_summary[df_summary$fips == "24510", ]

## step - 2 creating plot

# aggregate data
baltimore_emissions <- aggregate(Emissions ~ year +type, 
                                 baltimore_emissions_df, 
                                 sum)

# plot
plot_3 <- ggplot(baltimore_emissions,
                 aes(year, Emissions, color = type))

plot_3 <- plot_3 + 
        geom_line() +
        labs(x = "Year") +
        labs(y = "Amount of pm2.5 emissions") +
        labs(title = "Total amount of PM2.5 emissison in Baltimore City, Maryland, through years" ) 

print(plot_3)

# save to PNG
dev.copy(png, 
         file = "plot3.png", 
         width = 500, 
         height = 500)
dev.off()

# descreases are seen mostly on the NONPOINT source. 
# slightly descreased NON-ROAD and ON-ROAD resources 
