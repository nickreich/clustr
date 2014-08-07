## @knitr server
require(shiny)

source('helpers.R')

shinyServer(function(input, output, session){
        distr_data <- reactive({
                if(input$model=="logistic") {
                        dat <- get_data_logistic(pi_response=input$pi_response,
                                                 sigma2_alpha=input$sigma2_alpha)
                        q <- get_quantiles(expit(dat))
                }
                return(list(dat=dat, q=q))
        })
        
        output$distPlot <- renderPlot({
                if(input$model=="logistic") {
                        plot_clustr_distr_logistic(distr_data()$dat)
                }
                #switch(input$model,
                #       "logistic" = plot_clustr_distr_logistic(),
                #       "poisson" = plot_clustr_distr_poisson())
        })
        output$q10_text <- renderText({ 
                q10 <- distr_data()$q[1]
                paste0("1 in 10 clusters would have probabilities less than ", round(q10,2), ".")
        })
        
        output$q90_text <- renderText({ 
                q90 <- distr_data()$q[2]
                paste0("1 in 10 clusters would have probabilities greater than ", round(q90,2), ".")
        })
})
