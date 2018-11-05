
library(shiny)
library(tidyverse)
library(readxl)

nz_wines <- read_rds("nz_wine/wine.rds")

View(nz_wines)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("New Zealand Wine"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Number of bins:",
                     min = 1,
                     max = 50,
                     value = 30)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      wineries <- nz_wines %>%
       gather() %>%
       filter(!is.na(ENROLLMENT_12)) %>%
       ggplot(aes(x = ENROLLMENT_12)) +
       geom_histogram(binwidth = input$bins + 1) +
       labs(title = "Frequency of Enrollment in Infant Care Centers",
            x = "Total Center Enrollment of 12-Month Center")
     
      nz_wines
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

