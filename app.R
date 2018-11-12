
library(shiny)
grades <- as.numeric(unlist(read.csv("grades")))

ui <- fluidPage(
   
   titlePanel("Power Adjustment"),
   sidebarLayout(
      sidebarPanel(
         sliderInput("power",
                     "Power adjustment",
                     min = 0,
                     max = 1,
                     value = 1, step = 0.1)
      ),

      mainPanel(
         plotOutput("distPlot")
      )
   )
)

server <- function(input, output) {

   output$distPlot <- renderPlot({
      denominator <- 30
      numerator <- floor(grades*denominator/100)
      finalMark <- (numerator/denominator)^input$power*denominator
      hist(finalMark, breaks = 12, xlab = "Mark (out of 30)", main = "Histogram of Grades after adjustment")
   })
}

shinyApp(ui = ui, server = server)
