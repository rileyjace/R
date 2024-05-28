library(shiny)
library(shinytableau)
library(tidyverse)

manifest <- tableau_manifest_from_yaml()

# UI
ui = fluidPage(
  numericInput(inputId = "Num",
               "Window",
               value = 15),
  plotOutput(outputId = "LinePlot")
)

# Server
server = function(input, output) {
  output$LinePlot = renderPlot({
    x = seq(0, input$Num, 0.1)
    y = sin(x)
    df = data.frame(x, y)
    
    ggplot(data = df, aes(x, y)) +
      geom_line() +
      labs(x = "x", y = "sin(x)")
  })
}

# Deploy
shinyApp(ui, server)

tableau_extension(manifest, ui, server, options = ext_options(port = 3456)
)
