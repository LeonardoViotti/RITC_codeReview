#------------------------------------------------------------------------------#

#				GoR - DIME Price Survey app
#       Globals

#------------------------------------------------------------------------------#

#### WARNING: ####
cat(paste("This code contains the objects that should be accessible",
          "for all different codes contained in the dashboard.",
          sep = "\n"))

#------------------------------------------------------------------------------#
#### Load packages ####

library(shiny)
library(shinydashboard)
library(shinythemes)
library(plotly)
library(rsconnect)
library(zoo)
library(RColorBrewer)
library(tidyverse)
library(processx)
library(DT)

#------------------------------------------------------------------------------#
#### Load data ####


#### Prices per month
psLong_month <- readRDS("Data/psLong_month.rds")
psLong_month_province <- readRDS("Data/psLong_month_province.rds")

psLong_year <- readRDS("Data/psLong_year.rds")
psLong_year$Time <- as.character(psLong_year$Time)
psLong_year_province <- readRDS("Data/psLong_year_province.rds")
psLong_year_province$Time <- as.character(psLong_year_province$Time)

psLong_season <- readRDS("Data/psLong_season.rds")
psLong_season_province <- readRDS("Data/psLong_season_province.rds")

# Product type dfs
# psTdLong_month <- readRDS("Data/psTdLong_month.rds")
# psTdLong_month_province <- readRDS("Data/psTdLong_month_province.rds")
# 
# psTdLong_year <- readRDS("Data/psTdLong_year.rds")
# psTdLong_year$Time <- as.character(psTdLong_year$Time)
# psTdLong_year_province <- readRDS("Data/psTdLong_year_province.rds")
# 
# psTdLong_season <- readRDS("Data/psTdLong_season.rds")
# psTdLong_season_province <- readRDS("Data/psTdLong_season_province.rds")

#### Product List 
prod_list <- read.csv("Data/prod_list.csv", header = T)
prod_desc <- read.csv("Data/prod_desc.csv", header = T)


#------------------------------------------------------------------------------#
#### FUNCTIONS ####

#### Date rage input
dateRangeInputCustom <- function(inputId, label, endview = "years", ...) {
  d <- shiny::dateRangeInput(inputId, label, ...)
  d$children[[2L]]$children[[1]]$attribs[["data-date-min-view-mode"]] <- endview
  d$children[[2L]]$children[[3]]$attribs[["data-date-min-view-mode"]] <- endview
  d
}

#-------------------------------------#
#### Plotly Dropdown menu function ####
# Not used anymore, but kept here just in case


select_prod <-
  function(prodDF){
    
    #### Labels argument: product names
    products_str <- 
      unique(prodDF$product_lb) %>%
      as.list()
    
    #### args argument
    args_bool <- 
      diag(TRUE, length(products_str)) %>%
      split(1:length(products_str))
    
    vis_str <- rep("visible", length(products_str))%>%
      as.list()
    
    args_list <- mapply(list, vis_str, args_bool, SIMPLIFY=FALSE)
    
    #### method argument
    
    method_str <- rep("restyle", length(products_str)) %>%
      as.list()
    
    #### Combine 
    # combine them into the list format plotly needs
    products_list <- 
      mapply(list, 
             args =  args_list, 
             label =  products_str, 
             method = method_str,
             SIMPLIFY=FALSE)
    
    
    all_option <-     
      list(
        list(
          args = c("visible", rep(T, length(products_str))), 
          label = "All", 
          method = "restyle"
        )
      )
    
    
    return(
      append(all_option,
             products_list)
    ) 
    
    
    
  }

#------------------------------------#
#### Plotly prices graph function ####

PlotlyGraph_function_p <- 
  function(prodDF, groupVar, ylegend, plotTitle, showLegendBol){
    
    plot_ly(prodDF,
            x = ~Time, 
            y = ~price,
            height = 500) %>%
      add_lines(color=~groupVar,
                hoverinfo = 'text',
                text = ~paste('</br>', Time_Yaxis,
                              '</br>', groupVar,
                              '</br>', paste(round(price, 2),
                                             "RWFs")),
                showlegend = showLegendBol
                ) %>%
      layout(
        title = plotTitle,
        autosize = T,
        # margin = list(
        #   b = 175, 
        #   autoexpand = F),
        xaxis = list(title = "",
                     # showline = T, 
                     # showticklabels = F,
                     tickangle = 90),
        yaxis = list(title = ylegend)
      )
  }





#------------------------------------------------------------------------------#
#### Plotly availability graph function ####

PlotlyGraph_function_a <- 
  function(prodDF, groupVar, ylegend, plotTitle){

      plot_ly(prodDF,
              x = ~Time, 
              y = ~avail, 
              height = 500) %>%
      add_lines(color=~groupVar,
                hoverinfo = 'text',
                text = ~paste('</br>', Time_Yaxis,
                              '</br>', groupVar,
                              '</br>', paste(round(avail, 2)),
                              '</br>', paste0(round(avail,1),"%")) 
      ) %>%  

      layout(
        title = plotTitle,
        autosize = T,
        margin = list(b = 175, 
                      autoexpand = F),
        xaxis = list(title = "", 
                     #showline = TRUE,
                     tickangle = 90),
        yaxis = list(title = ylegend) ,
        legend = list(x = 0, y = -.4, orientation = 'h',  yanchor = "bottom") ,
        showlegend = T
      )
  }

