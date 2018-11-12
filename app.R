
library(shiny)
grades <- as.numeric(unlist(read.csv("grades")))

ui <- fluidPage(
   
   titlePanel("Power Adjustment"),
   sidebarLayout(
      sidebarPanel(
         sliderInput("power",
                     "Power Adjustment",
                     min = 0,
                     max = 1,
                     value = 1, step = 0.1),
         sliderInput("num_breaks",
                     "Number of Breaks",
                     min = 1,
                     max = 50,
                     value = 20,
                     step = 1)
      
         ),

      mainPanel(
         plotOutput("distPlot")
      )
   )
)

server <- function(input, output) {

   output$distPlot <- renderPlot({
      numerator <- grades/100
      finalMark <- (numerator)^input$power*100
      hist(finalMark, breaks = input$num_breaks, xlab = "Mark %", main = "Histogram of Grades after adjustment")
   })
}

shinyApp(ui = ui, server = server)
