#================================================================================================
# UI function
GeneralLinePlotUI <- function(id, selected_dataset, dataset_type) {
  ns <- NS(id)
  fillCol(height = 600, flex = c(NA, 1), 
          inputPanel(
            selectInput(ns("lp_var_x"), 
                        label = "Choose a Column to display",
                        choices = colnames(selected_dataset),
                        selected = colnames(selected_dataset)[1]),
            selectInput(ns("lp_var_y"), 
                        label = "Choose a Column to display",
                        choices = colnames(selected_dataset),
                        selected = colnames(selected_dataset)[2])
          ),
          plotOutput(ns("lp_graph_plot"), height = "100%"),
          textOutput(ns("lp_selected_var_x")),
          textOutput(ns("lp_selected_var_y"))
  )
}

#================================================================================================
# Server function
GeneralLinePlot <- function(input, output, session, selected_dataset, dataset_type, fill_by) {
  output$lp_graph_plot <- renderPlot({
    ggplot(selected_dataset, mapping = aes(x = selected_dataset[,input$lp_var_x], y = selected_dataset[,input$lp_var_y])) + geom_point(aes(color = selected_dataset[,fill_by])) + geom_line(aes(color = selected_dataset[,fill_by])) + labs(x = input$lp_var_x, y = input$lp_var_y, title = paste("Line Plot For", dataset_type,"Dataset."))
  })
  output$lp_selected_var_x <- renderText({ 
    paste("You have selected", input$lp_var_x, "for x-axis")
  })
  
  output$lp_selected_var_y <- renderText({ 
    paste("You have selected", input$lp_var_y, "for y-axis")
  })
}
