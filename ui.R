#-----------------------------------------------------
# User Interface logic for Loan Calculator Shiny Application.
#
# author: Chandra Prakash
# 
#----------------------------------------------------

shinyUI(fluidPage(
  
  titlePanel("Loan Calculator"),
  
  sidebarLayout(
    
    sidebarPanel(
      helpText("Use this simple loan calculator to figure monthly payments for loan amount. Use the sliders to adjust loan amount, interest rate and term of loan."),
      sliderInput('amount', 'Loan Amount',value = 1000, min = 0, max = 100000, step = 50),
      sliderInput('rate', 'Annualy Interest Rate (%)',value = 3, min = 0, max = 10, step = .25),
      sliderInput('years', 'Number of Years',value = 3, min = 1, max = 10, step = 1),
      h2("Assumptions"),
      p("Payment Frequency: Monthly"),
      p("Interest Compounding: Monthly")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Monthly Payment",
          h2(class="bg-primary", "How much does that loan really cost?", style="bgcolor:blue"),
          h4('Monthly Payment'),
          textOutput("payment"),
          h4('This loan will really cost you:'),
          textOutput("totalPaid")
        ),
        tabPanel("Amortization Table",
          tableOutput("amort")
        )
      )
    )
    
  )
  
))