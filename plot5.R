# TASK-5
# 5. How have emissions from motor vehicle sources changed 
# from 1999–2008 in Baltimore City?

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
# summarize emissions data on the coal parameter
BLT_m_veh_emiss_per_year <- match_data %>% filter(fips == "24510") %>% group_by(year) %>% summarise(total = sum(Emissions))

# plot

colors <- c("darkblue", "blue", "lightblue", "seagreen")
plot_5 <- ggplot(BLT_m_veh_emiss_per_year, 
                 aes(factor(year), 
                     total/1000, 
                     label = round(total/1000)))
plot_5 <- plot_5 + 
        geom_bar(stat = "identity", fill = colors) +
        labs(x = "Year") +
        labs(y = "Amount of pm2.5 emissions") +
        labs(title = "Total amount of PM2.5 emissisons from motor vehicle in Baltimore City, Maryland, through years" ) 

print(plot_5)

# save to PNG
dev.copy(png, 
         file = "plot5.png", 
         width = 600, 
         height = 600)
dev.off()

# from 1999 to 2008 amount of emissions from motor vehicle in Baltimore City decreased
