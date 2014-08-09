## @knitr ui
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
        
        # Application title
        titlePanel("Visualizing cluster-level outcomes"),
        
        fluidRow(
                column(width=9,
                       p("This Shiny app is designed to provide intuition about simple random effects models. Its development was motivated by working on the design of cluster randomized clinical trials and in particular conducting simulations to calculate power for such studies.",
                         a(href="http://www.plosone.org/article/info%3Adoi%2F10.1371%2Fjournal.pone.0035564", "Our PLoS ONE paper"),
                         "provides an overview of this topic.")
                )
        ),
        
        # Sidebar with a slider input for the number of bins
        fluidRow(
                # Show a plot of the generated distribution
                column(width=9,
                       plotOutput("distPlot")#,
                       #textOutput("q10_text"),
                       #textOutput("q90_text")
                ),
                
                column(width=3,
                        ## mathjax to enable equations in labels
                        tags$head( tags$script(src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML-full", type = 'text/javascript'),
                                   tags$script( "MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}});", type='text/x-mathjax-config')
                        ),
                        helpText("Specify parameters of the random effects model shown below."),
                        selectInput("model", 
                                    label = "Model type",
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
                        
                )
                
        ),
        
        fluidRow(
                column(width=12,
                       HTML("We aim to simulate data from the following generalized linear mixed effects model $$g( E[Y_k|\\alpha_k] ) = \\pi + \\alpha_k$$  $$\\alpha_k \\sim N(0, \\sigma^2_\\alpha)$$ where $Y_k$ can be either binary or count data, corresponding to logistic or log-linear Poisson models, respectively. The app determines, for particular values of $\\pi$ and $\\sigma^2_\\alpha$, what the distribution of cluster-level outcomes looks like. For a logistic model, this requires simulation. For a Poisson model, a closed-form solution is availale. [Note: we currently only implement the logistic model.]")
                )
        ),
        
        fluidRow(column(width=10, p(" "))),
        
        fluidRow(
                column(width=12,
                       p("Source code on ",
                         a(href="https://github.com/nickreich/clustr/app", "GitHub"))
                )
        )
))
