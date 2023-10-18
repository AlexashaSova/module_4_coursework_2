# TASK-4
# 4. Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

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

# extract coal data from all the data
coal_emissions_df <- df_codes[grepl("Comb.*Coal", 
                                    df_codes$EI.Sector), ]
# select only unique rows
coal_emissions_unique <- unique(coal_emissions_df$SCC)
match_data <- df_summary[(df_summary$SCC %in% coal_emissions_unique), ]
# summarize emissions data on the coal parameter
US_coal_emissions_per_year <- match_data %>% group_by(year) %>% summarise(total = sum(Emissions))

# plot

colors <- c("darkblue", "blue", "lightblue", "seagreen")
plot_4 <- ggplot(US_coal_emissions_per_year, 
                 aes(factor(year), 
                 total/1000, 
                 label = round(total/1000)))
plot_4 <- plot_4 + 
        geom_bar(stat = "identity", fill = colors) +
        labs(x = "Year") +
        labs(y = "Amount of pm2.5 emissions") +
        labs(title = "Total amount of PM2.5 emissisons from coal in the USA through years" ) 

print(plot_4)

# save to PNG
dev.copy(png, 
         file = "plot4.png", 
         width = 480, 
         height = 480)
dev.off()

# from 1999 to 2008 amount of emissions from coal in the USA decreased
