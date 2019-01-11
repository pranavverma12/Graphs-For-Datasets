#================================================================================================
# UI function
GeneralHistogramUI <- function(id, selected_dataset, dataset_type) {
  ns <- NS(id)
  fillCol(height = 600, flex = c(NA, 1), 
          inputPanel(
            selectInput(ns("var"), 
                        label = "Choose a Column to display",
                        choices = colnames(selected_dataset),
                        selected = colnames(selected_dataset)[1])
          ),
          plotOutput(ns("graph_plot"), height = "100%"),
          textOutput(ns("selected_var"))
  )
}

#================================================================================================
# Server function
GeneralHistogram <- function(input, output, session, selected_dataset, dataset_type, fill_by) {
  output$graph_plot <- renderPlot({
    ns <- session$ns
    ggplot(selected_dataset, mapping = aes(x = selected_dataset[,input$var])) + geom_histogram(aes(fill = selected_dataset[,fill_by]), stat = "count") + labs(x = "Length", title = paste("Histogram For", dataset_type,"Dataset."))
  })
  output$selected_var <- renderText({ 
    paste("You have selected", input$var)
  })
}
