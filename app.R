library(bslib)
library(shiny)
# install.packages(rsconnect)
library(rsconnect)
source("ui.R")
source("server.R")

shinyApp(ui = ui, server = server)