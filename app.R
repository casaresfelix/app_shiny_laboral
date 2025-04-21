library(shiny)

# Define UI
ui <- fluidPage(
  titlePanel("Probabilidad de Conseguir Empleo"),
  sidebarLayout(
    sidebarPanel(
      numericInput("p02", "p02", value = 0),
      numericInput("p03", "p03", value = 0),
      numericInput("p37", "p37", value = 1),
      numericInput("p74a", "p74a", value = 0),
      actionButton("calcular", "Calcular")
    ),
    mainPanel(
      h4("Resultado:"),
      verbatimTextOutput("resultado")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  modelo <- reactiveVal(NULL)
  
  observeEvent(input$calcular, {
    # Cargar modelo solo si no está cargado aún
    if (is.null(modelo())) {
      modelo(readRDS("motor_calculo.rds"))
    }
    
    # Crear nuevo data.frame con input del usuario
    newdata <- data.frame(
      p02 = input$p02,
      p03 = input$p03,
      p03_2 = input$p03^2,
      p37 = input$p37,
      p74a = input$p74a
    )
    
    # Predecir probabilidad
    prob <- predict(modelo(), newdata = newdata, type = "response")
    
    output$resultado <- renderPrint({
      cat("Probabilidad de conseguir empleo:", round(prob, 4))
    })
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
