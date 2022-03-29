library(ggplot2)
library(plotly)
library(bslib)

data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

intro_tab <- tabPanel(
  "Introduction",
  fluidPage(theme = bs_theme(bg = "#1E59B5", fg = "white"),
            h5("Welcome to my climate change app. The feature of the data I analyze here is how does the total of each country's annual greenhouse gas emissions change and whether the total amount of greenhouse gases emitted is related to overall advances in technology."),
            h5("The dataset I am analyzing is the data of CO₂ and #Greenhouse Gas Emissions from 1800 to 2020. This data has been collected, aggregated, and documented by Hannah Ritchie, Max Roser, Edouard Mathieu, Bobbie Macdonald and Pablo Rosado. They want to give people a sense of why do greenhouse gas emissions matter and how are greenhouse gas emissions and concentrations changing. The NA and missing data is a limitation of the dataset. As we do some analysis and calculation, we have to remove the data of NA and try to not include the missing data. It is unavoidable that out result from the calculation is kind of inexact."),
            h5("The representative data I find is..."),
            textOutput(outputId = "maxStr"),
            textOutput(outputId = "maxValue"),
            textOutput(outputId = "minStr"),
            textOutput(outputId = "minValue"),
            textOutput(outputId = "meanStr"),
  )
)


plot_sidebar <- sidebarPanel(
  selectInput(
    inputId = "user_category",
    label = "Select Country",
    choices = data$country,
    selected = "United States",
    multiple = TRUE),
  sliderInput(
    inputId="start_year", label = "Year Range (from to end):", min=1949, value=c(1990,2020), max=2020
  )
)

plot_main <- mainPanel(
  plotlyOutput(outputId = "climatePlot"),
  p("I use this chart because it can show the trend of gas emissions for each country in certain time period obviously. The option for changing country can contrast the air emissions between different country. The greenhouse gas emissions for alomost every country has a overall upward trend.")
)


plot_tab <- tabPanel(
  "Plot",
  sidebarLayout(
    plot_sidebar,
    plot_main
  )
)

value_sensitive_tab <- tabPanel(
  "Value Sensitive Design",
  fluidPage(theme = bs_theme(bg = "#1E59B5", fg = "white"),
            h5("The widespread use may improve the data integrity. The NA value may becomes less and less as everyone notice my app. "),
            h3("Benefits:"),
            h5("Improve the datagrity, reduce NAs and missing value."),
            h5("Increase awareness of the greenhouse effect."),
            h5("The app can include more fliter option which is contributed by others as the app is open-source."),
            h3("Breakdowns:"),
            h5("As more people use apps, the consequences of incomplete data will be magnified."),
            h5("As more people use apps, the website of the app may crash."),
            h5("As more and more people use apps, people may care more about the number of data itself rather than how to reduce carbon emissions.")
  )
)


ui <- navbarPage(
  "Climate Change",
  intro_tab,
  plot_tab,
  value_sensitive_tab
)
