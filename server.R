library(ggplot2)
library(plotly)
library(dplyr)

climate_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

# Make relevant value
calculated_data <- na.omit(climate_data) %>% mutate(total_gas = co2+total_ghg+methane+nitrous_oxide)
data_set <- calculated_data %>% group_by(country)
max_set <- data_set %>% summarize(max_gas=max(total_gas))
max_set <- head(max_set, -1)
max_emission <- as.numeric(max_set %>% summarize(max_gas_country=max(max_gas)))
max_country <- "United States"
min_set <- data_set %>% summarize(min_gas=min(total_gas))
min_set <- head(min_set, -1)
min_emission <- as.numeric(min_set %>% summarize(min_gas_country=min(min_gas)))
min_country <- "Romania"
mean_set <- data_set %>% summarize(mean_gas=mean(total_gas))
mean_set <- head(mean_set, -1)
mean_emission <- as.numeric(mean_set %>% summarize(mean_gas_country=mean(mean_gas)))


server <- function(input, output) {
  
  output$climatePlot <- renderPlotly({
    
    climate_data <- climate_data %>% filter(country %in% input$user_category)
    climate_data <- climate_data %>% mutate(total_gas = co2+total_ghg+methane+nitrous_oxide)
    climate_data <- climate_data %>% filter(((year>=input$start_year[1])&(year<=input$start_year[2])))
    # Make a scatter plot
    my_plot <- ggplot(data = climate_data) +
      geom_line(mapping = aes(x = year, 
                              y = total_gas, 
                              color= country), na.rm = TRUE) +
      labs(title="Total Greenhouse Gas Emissions",y="Total Emission (million tonnes)")
    
    # Make interactive plot
    my_plotly_plot <- ggplotly(my_plot) 
    
    return(my_plotly_plot)
    
  })
  
  output$maxStr <- renderText({
    
    max_str <- paste0("The country that has the largest annual emission of greenhouse gas is ", max_country, ".")
    
    return(max_str)
    
  })
  
  output$maxValue <- renderText({
    
    max_str <- paste0(max_country, " has a maximum emission of ", max_emission, ".")
    
    return(max_str)
    
  })
  
  output$minStr <- renderText({
    
    min_str <- paste0("The country that has the least annual emission of greenhouse gas is ", min_country, ".")
    
    return(min_str)
    
  })
  
  output$minValue <- renderText({
    
    min_str <- paste0(min_country, " has a minimum emission of ", min_emission, ".")
    
    return(min_str)
    
  })
  
  
  output$meanStr <- renderText({
    
    mean_str <- paste0("The mean annual emission of greenhouse gas for countries in the world is ", mean_emission, ".")
    
    return(mean_str)
    
  })
  
}