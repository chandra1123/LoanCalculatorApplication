library(scales)

#-----------------------------------------------------
# Server logic for Loan Calculator Shiny Application.
#
# author: Chandra Prakash
# 
#----------------------------------------------------

#Calculate Regular Payment.
pmt <- function(rate, nper, pv) {
  if (rate == 0) return (pv / nper)
  
  factor <- rate / (1 - 1/(1+rate)^nper)
  return (pv * factor)
}

#Calculate Amortization Table.
amortization <- function(rate, nper, pv) {
  pmt <- pmt(rate, nper, pv)
  data <- data.frame(month = 1:nper, payment = c(rep(pmt, nper)), 
                     interestPayment = NA,
                     principalPayment= NA, remainingPrincipal=NA)
  data$totalPaid <- cumsum(data$payment)
  principal <- pv
  for (i in 1:nper) {
    interestPayment <- principal * rate
    principalPayment <- pmt - interestPayment
    principal <- principal - principalPayment
    data$interestPayment[i] <- interestPayment
    data$principalPayment[i] <- principalPayment
    data$remainingPrincipal[i] <- principal
  }
  data
}

shinyServer(function(input, output) {
  
  rate <- reactive ({
    input$rate/(100*12)
  })
  
  nper <- reactive ({
    input$years * 12
  })

  payment <- reactive ({
    pmt(rate(), nper(), input$amount)
  })
  
  amort <- reactive ({
    amortization(rate(), nper(), input$amount)
  })
  
  output$payment <- renderText({dollar(payment())})
  output$totalPaid <- renderText({dollar(payment()*input$years*12)})
  output$amort <- renderTable({
    amort()
  })
  
})