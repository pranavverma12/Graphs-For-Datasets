#================================================================================================
# UI function
GeneralScatterPlotUI <- function(id, selected_dataset, dataset_type) {
  ns <- NS(id)
  fillCol(height = 600, flex = c(NA, 1), 
          inputPanel(
            selectInput(ns("sp_var_x"), 
                        label = "Choose a Column to display",
                        choices = colnames(selected_dataset),
                        selected = colnames(selected_dataset)[1]),
            selectInput(ns("sp_var_y"), 
                        label = "Choose a Column to display",
                        choices = colnames(selected_dataset),
                        selected = colnames(selected_dataset)[2])
          ),
          plotOutput(ns("sp_graph_plot"), height = "100%"),
          textOutput(ns("sp_selected_var_x")),
          textOutput(ns("sp_selected_var_y"))
  )
}

#================================================================================================
# Server function
GeneralScatterPlot <- function(input, output, session, selected_dataset, dataset_type, fill_by) {
  output$sp_graph_plot <- renderPlot({
    ggplot(selected_dataset, mapping = aes(x = selected_dataset[,input$sp_var_x], y = selected_dataset[,input$sp_var_y])) + geom_point(aes(color = selected_dataset[,fill_by])) + labs(x = input$sp_var_x, y = input$sp_var_y, title = paste("Scatterplot For", dataset_type,"Dataset."))
  })
  output$sp_selected_var_x <- renderText({ 
    paste("You have selected", input$sp_var_x, "for x-axis")
  })
  
  output$sp_selected_var_y <- renderText({ 
    paste("You have selected", input$sp_var_y, "for y-axis")
  })
}
