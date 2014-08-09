## helper script for clustr shiny app
require(ggplot2)

expit <- function(p) exp(p)/(1+exp(p))
logit <- function(p) log(p/(1-p))

get_data_logistic <- function(pi_response, sigma2_alpha){
        ## set model parameters
        pi <- logit(pi_response)
        s <- sqrt(sigma2_alpha)
        ## generate random ps
        rnorm(100000, mean=pi, sd=s)
}

get_quantiles <- function(dat){
        q <- quantile(dat, c(.1, .9))
}        

plot_clustr_distr_logistic <- function(dat){
        pp <- qplot(expit(dat), geom="density") + xlim(0,1) + theme_bw() +
                xlab("cluster-specific probabilities")
        print(pp)
}

plot_clustr_distr_poisson <- function(pi_response, sigma2_alpha, at_risk_time=10){
        ## set model parameters
        pi <- log(pi_response)
        s <- sqrt(sigma2_alpha)
        ## determine range of log-normal distribution 
        y <- rlnorm()
}