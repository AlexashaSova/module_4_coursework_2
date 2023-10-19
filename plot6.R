# TASK-6
# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == “06037”). 
# Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)
library(dplyr)

## step - 1 loading data

# data paths
summary_rds_file <- "data/summarySCC_PM25.rds"
source_codes_rds_file <- "data/Source_Classification_Code.rds"

# reading file
df_summary <- readRDS(summary_rds_file)
# head(df_summary)
df_codes <- readRDS(source_codes_rds_file)
# head(df_codes)

# extract motor vehicle emissions data from all the data
motor_veh_emissions_data <- df_codes[grepl("Vehicle", 
                                           df_codes$SCC.Level.Two), ]

# select only unique rows
motor_veh_unique <- unique(motor_veh_emissions_data$SCC)
match_data <- df_summary[(df_summary$SCC %in% motor_veh_unique), ]

# select data, corresponding to LA county and Baltimore City  
BC_LA_emissions_per_year <- match_data %>% 
        filter(fips == "24510" | fips == "06037") %>% 
        group_by(fips, year) %>% 
        summarise(total = sum(Emissions))
# mark data as LA county or Baltimore City  
BC_LA_emissions_per_year <- mutate(BC_LA_emissions_per_year, 
                                   county = ifelse(fips == "24510", "Baltimore City", 
                                          ifelse(fips == "06037", "Los Angeles County")))

# plot

plot_6 <- ggplot(BC_LA_emissions_per_year, 
                 aes(factor(year),
                     total,
                     label = round(total), 
                     fill = county))
plot_6 <- plot_6 + 
        geom_bar(stat = "identity") +
        labs(x = "Year") +
        labs(y = "Amount of pm2.5 emissions") +
        labs(title = "Amount of PM2.5 emissisons from motor vehicle in LA county and Baltimore City through years" ) +
        facet_grid(. ~ county)

print(plot_6)

# save to PNG
dev.copy(png, 
         file = "plot6.png", 
         width = 600, 
         height = 600)
dev.off()

# from 1999 to 2008 amount of emissions from motor vehicle in Baltimore City decreased
# at the same time, number of such emissions in LA county slightly grew up
