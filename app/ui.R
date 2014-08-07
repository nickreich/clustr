## @knitr ui
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
        
        # Application title
        titlePanel("Visualizing cluster-level outcomes"),
        
        # Sidebar with a slider input for the number of bins
        sidebarLayout(
                sidebarPanel(
                        ## mathjax to enable equations in labels
                        tags$head( tags$script(src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML-full", type = 'text/javascript'),
                                   tags$script( "MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}});", type='text/x-mathjax-config')
                        ),
                        helpText("This app provides visualizations of cluster-level outcomes based on a random effects model, e.g.",
                                 HTML("$g(E[Y_k|\\alpha_k]) \\sim N( \\pi, \\sigma^2_\\alpha) $")),
                        selectInput("model", 
                                    label = h5("Model type"),
                                    choices = list("Logistic" = "logistic"), #"Poisson" = "poisson"), 
                                    selected = "logistic"),
                        numericInput("pi_response", 
                                     label = HTML("mean cluster-level outcome $(g^{-1}(\\pi))$"), 
                                     value = .5,
                                     min = 0, max = 1, step = .05),
                        numericInput("sigma2_alpha", 
                                     label = HTML("random effect variance  $(\\sigma^2_\\alpha)$  "), #"random effect variance", 
                                     value = .2,
                                     min = 0, step = .01)
                        
                ),
                
                # Show a plot of the generated distribution
                mainPanel(
                        plotOutput("distPlot"),
                        textOutput("q10_text"),
                        textOutput("q90_text")
                )
        )
))
