#------------------------------------------------------------------------------#

#				GoR - DIME Price Survey app
#       App

#------------------------------------------------------------------------------#

cat(paste( "This creates and updates the first version of GoR shiny dashboard.",
           "It runs independly from the project master", 
           "The data sets being used here ara all  gitignored",
           "Therefore, you need to run data_process.R to create them.",
           sep = "\n"))


#------------------------------------------------------------------------------#
#### Settings ####
#rm(list = ls())

library(here)

options(shiny.sanitize.errors = F)

# Set app path
GoR_APP <- file.path("C:/Users/wb519128/GitHub/Rwanda-Roads/Analysis/RFR/Shiny Dashboard - MINAGRI")
# setwd(GoR_APP)


#------------------------------------------------------------------------------#
#### Run app ####
#source("ui.R")
source("globals.R")

runApp(appDir = GoR_APP)

