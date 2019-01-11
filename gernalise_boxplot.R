#================================================================================================
# UI function
GeneralLinePlotUI <- function(id, selected_dataset, dataset_type) {
  ns <- NS(id)
  fillCol(height = 600, flex = c(NA, 1), 
          inputPanel(
            selectInput(ns("bp_var_x"), 
                        label = "Choose a Column to display",
                        choices = colnames(selected_dataset),
                        selected = colnames(selected_dataset)[1]),
            selectInput(ns("bp_var_y"), 
                        label = "Choose a Column to display",
                        choices = colnames(selected_dataset),
                        selected = colnames(selected_dataset)[2])
          ),
          plotOutput(ns("bp_graph_plot"), height = "100%"),
          textOutput(ns("bp_selected_var_x")),
          textOutput(ns("bp_selected_var_y"))
  )
}

#================================================================================================
# Server function
GeneralLinePlot <- function(input, output, session, selected_dataset, dataset_type, fill_by) {
  output$bp_graph_plot <- renderPlot({
    ggplot(selected_dataset, mapping = aes(x = selected_dataset[,input$bp_var_x], y = selected_dataset[,input$bp_var_y])) + geom_boxplot(aes(color = selected_dataset[,fill_by])) + labs(x = input$bp_var_x, y = input$bp_var_y, title = paste("Boxplot For", dataset_type,"Dataset."))
  })
  output$bp_selected_var_x <- renderText({ 
    paste("You have selected", input$bp_var_x, "for x-axis")
  })
  
  output$bp_selected_var_y <- renderText({ 
    paste("You have selected", input$bp_var_y, "for y-axis")
  })
}
