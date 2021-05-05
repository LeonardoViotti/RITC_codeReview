#------------------------------------------------------------------------------#

#				GoR - DIME Price Survey app
#       Data processing

#------------------------------------------------------------------------------#

## PURPOSE: Prepare data to shiny dashboard

## Written by:	                                        Leonardo Teixeira Viotti

## Last updated:                                                        MAR 2019

#### WARNING: ####
cat(paste( "This code depends on Master_RFR_analysis.R to run.",
           "Please, find the master code in the project repository:",
           "https://github.com/worldbank/Rwanda-Roads/tree/master/Analysis/RFR",
           "Please, switch on LOAD_core_datasets",
           "Run it with to set the correct paths", sep = "\n"))



#------------------------------------------------------------------------------#
#### TO DO ####

# Use tidy data


# Constant sample


#------------------------------------------------------------------------------#
#### SWITCHES ####

EXPORT_data = T

#------------------------------------------------------------------------------#
#### Settings ####

#---------------------#
#### Load packages ####

library(tidyverse)
library(reshape2)
library(readstata13)
library(stringr)
library(gridExtra)
library(zoo)
library(data.table)              # Added data table since you are using fread


#------------------------------------------------------------------------------#
#### Load data ####
# ps		<- read.dta13(file.path(PRICE_SV, "Price_survey_preprocess.dta"), 
#                   convert.factors = T)

ps		<- fread("Data/PS-data/tidy_panel.csv",
             stringsAsFactors = F)


# Remove most recent month
#ps <- ps %>% subset(year_month != max(ps$year_month))

# Product list
prod_list <- read.csv("Data/PS-data/product_list.csv", 
                      header = T,
                      stringsAsFactors = F)
prod_list <- prod_list[prod_list$type != "input",] #remove ag inptus

# Market sample list
market_sample <- fread("Data/PS-data/Sample_Markets.csv",
                       stringsAsFactors = F)


#------------------------------------------------------------------------------#
#### Keep constant sample #### 

constSample_markets <- market_sample$market_uid[market_sample$constant_sample == 1]

ps <- ps[ps$market_uid %in% constSample_markets,]


#------------------------------------------------------------------------------#
#### Processing data #### 

# psLong <- merge(prices_long, avail_long, by = c(idVars, "product"))
# psLong_backup <- psLong

psLong <- ps %>% rename(avail = q10_available,
                     price = avg_price,
                     product = prod) %>% 
  dplyr::select(-survey_round, -province, -sector, -cell)

# Remove availability data for April 2020, since data was not fully collected
psLong$avail[psLong$year == 2020 & psLong$month == 4] <- NA

# Remove March 2020 data since it was not completed due to the lockdown

psLong$avail[psLong$year == 2020 & psLong$month == 3] <- NA
psLong$price[psLong$year == 2020 & psLong$month == 3] <- NA


#------------------------------------------------------------------------------#
#### Add new variables ####

# Availability in percentage
psLong$avail_num <- ifelse(psLong$avail == "Yes", 1, 0)
psLong$avail <- psLong$avail_num*100


# Province
EasternProv_districts  <- c("Bugesera",  "Gatsibo",  "Kayonza",
                            "Kirehe",    "Ngoma",    "Nyagatare",
                            "Rwamagana")
NorthernProv_districts <- c("Burera",    "Gakenke",  "Gicumbi",
                            "Musanze",   "Rulindo")
SouthernProv_districts <- c("Gisagara",  "Huye",     "Kamonyi",
                            "Muhanga",   "Nyamagabe","Nyanza",
                            "Nyaruguru", "Ruhango")   
WesternProv_districts  <- c("Karongi",   "Ngororero","Nyabihu",
                            "Nyamasheke","Rubavu",   "Rusizi",
                            "Rutsiro")
# Add to market level data
psLong$province <- NA
psLong$province[psLong$district %in% EasternProv_districts] <- "Eastern"
psLong$province[psLong$district %in% WesternProv_districts] <- "Western"
psLong$province[psLong$district %in% NorthernProv_districts] <- "Northern"
psLong$province[psLong$district %in% SouthernProv_districts] <- "Southern"


#### Season

# A is september to feb

Amonths <- c(9,10,11,12,01,02)

# B is March to jun
Bmonths <- c(3,4,5,6)

# C is july to august
Cmonths <- c(7,8)

psLong$season <- ""
psLong$season[psLong$month %in% Amonths] <- "A"
psLong$season[psLong$month %in% Bmonths] <- "C"
psLong$season[psLong$month %in% Cmonths] <- "B"



#### Fix season A
psLong$yearS <- ifelse(psLong$month %in% c(9,10,11,12), 
                       psLong$year +1, 
                       psLong$year)


#### Year season variable
psLong$year_season <- paste(psLong$yearS, psLong$season)
psLong$yearS <- NULL

#----------------------------#
#### Factors  and Strings ####

# Make sure product_lb is character
# Match with labels
psLong$product_lb <- prod_list$product[match(psLong$product, prod_list$variable)]
psLong$product_lb <- as.character(psLong$product_lb)


#### Dates
psLong$year_month <- 
  paste(psLong$year, psLong$month, "01", sep ="-") %>% 
  as.Date() #%>%
#format(format="%Y %b")


#------------------------------------------------------------------------------#
#### GRAPH VARS ####

# Group var
psLong$plot_group <- psLong$product_lb


#------------------------------------------------------------------------------#
#### PRODUCT LIST EDITING ####

#### Names edits

# Sort by alphabetic order
prod_list <- prod_list[order(prod_list$product),]

# Put tomato first
prod_list <- 
  rbind(
    prod_list[grep("tomato", prod_list$variable, fixed = T)[1],],
    prod_list[-grep("tomato", prod_list$variable, fixed = T)[1],]
  )

# Small name changes
prod_list$product[prod_list$variable == "detergent"] <- "Detergent"
prod_list$product[prod_list$variable == "airtime"] <- "Airtime"
prod_list$product[prod_list$variable == "amarante"] <- "Amarante"
prod_list$product[prod_list$variable == "comm_beer"] <- "Commercial Beer"

prod_list$product[prod_list$variable == "tomato"] <- "Tomato"
prod_list$product[prod_list$variable == "dress"] <- "Dress"
prod_list$product[prod_list$variable == "tea_local"] <- "Tea"
prod_list$product[prod_list$variable == "green_pea"] <- "Green Pea"
prod_list$product[prod_list$variable == "milk"] <- "Milk"
prod_list$product[prod_list$variable == "dress"] <- "Dress"

#### Unities and types
prod_list$std_unit_str <- NA
prod_list$std_unit_str[prod_list$std_unit == "KG"] <- "Sold by weight"
prod_list$std_unit_str[prod_list$std_unit == "unit"] <- "Sold by unit"
prod_list$std_unit_str[prod_list$std_unit == "liter"] <- "Sold by volume"


#------------------------------------------------------------------------------#
#### PRODUCT DESCRIPTION ####

product_desc <- prod_list

#### Keep interest vars
otherBrandNames <- names(product_desc)[grep("other_brand", names(product_desc))]
keepVarsDesc <- c("product", "type", "std_unit", "main_brand", otherBrandNames )

product_desc <- product_desc[,keepVarsDesc]

# Other brands column

# Customized paste function
pasteFun <- function(x){
  paste(
    paste(
      x[1:sum(x != "")-1], 
      collapse = ", "),
    "and", 
    x[sum(x != "")])
  
}


# Add new column
product_desc$OtherBrands <-
  apply(product_desc[,otherBrandNames] , 
        1 , 
        pasteFun )

# Replace if only one other brand (to remove 'and brand')
product_desc$OtherBrands <- ifelse(product_desc$other_brand2 == "", 
                                   product_desc$other_brand1, 
                                   product_desc$OtherBrands)

product_desc$OtherBrands[product_desc$other_brand1 == ""] <-""

# Remove other brands
product_desc <- 
  product_desc %>% dplyr::select(-otherBrandNames)

#### Rename columns

# product_desc <- product_desc %>% 
#   rename("product",
#          "type",
#          "std_unit",
#          "main_brand",
#          "OtherBrands")


#------------------------------------------------------------------------------#
#### Aggregated Datasets ####

start.time <- Sys.time()


#-----------------------------------#
#### Average prices per month df ####

psLong_month <-
  psLong %>%
  group_by(year_month, product_lb) %>% 
  dplyr::summarise(price = mean(price, na.rm = T),
                   avail = mean(avail, na.rm = T), 
                   n_markets = n_distinct(market_uid)) %>%
  mutate(Time = year_month,
         Time_Yaxis = format(Time, format="%Y %b"))


#-----------------------------------#
#### Average prices per year df ####


psLong_year <-
  psLong %>%
  group_by(year, product_lb) %>% 
  dplyr::summarise(price = mean(price, na.rm = T),
                   avail = mean(avail, na.rm = T), 
                   n_markets = n_distinct(market_uid)) %>%
  mutate(Time = year,
         Time_Yaxis = Time)


#-----------------------------------#
#### Average prices per season df ####


psLong_season <-
  psLong %>%
  group_by(year_season, product_lb) %>% 
  dplyr::summarise(price = mean(price, na.rm = T),
                   avail = mean(avail, na.rm = T), 
                   n_markets = n_distinct(market_uid)) %>%
  mutate(Time = year_season,
         Time_Yaxis = Time)



#------------------------------------------------#
#### Average prices per month and province df ####

psLong_month_province <- 
  psLong %>%
  group_by(year_month, product_lb, province) %>% 
  dplyr::summarise(
    price_sd = sd(price, na.rm = T),
    price = mean(price, na.rm = T),
    avail_sd = sd(avail, na.rm = T),
    avail = mean(avail, na.rm = T),
    n_markets = n_distinct(market_uid)) %>%
  mutate(Time = year_month,
         Time_Yaxis = format(Time, format="%Y %b"))



#------------------------------------------------#
#### Average prices per year and province df ####

psLong_year_province <- 
  psLong %>%
  group_by(year, product_lb, province) %>% 
  dplyr::summarise(price = mean(price, na.rm = T),
                   avail = mean(avail, na.rm = T), 
                   n_markets = n_distinct(market_uid)) %>%
  mutate(Time = as.character(year),
         Time_Yaxis = Time)


#------------------------------------------------#
#### Average prices per season and province df ####

psLong_season_province <- 
  psLong %>%
  group_by(year_season, product_lb, province) %>% 
  dplyr:: summarise(price = mean(price, na.rm = T),
                    avail = mean(avail, na.rm = T), 
                    n_markets = n_distinct(market_uid)) %>%
  mutate(Time = year_season,
         Time_Yaxis = Time)



end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken

#------------------------------------------------------------------------------#
#### EXPORT DATA ####

if (EXPORT_data){
  
  if(!dir.exists("Data/Final")){
    dir.create("Data/Final")
  }
  
  # PS per month
  
  saveRDS(psLong_month, "Data/Final/psLong_month.rds")
  
  saveRDS(psLong_year, "Data/Final/psLong_year.rds")
  
  saveRDS(psLong_season, "Data/Final/psLong_season.rds")
  
  saveRDS(psLong_month_province, "Data/Final/psLong_month_province.rds")
  
  saveRDS(psLong_year_province, "Data/Final/psLong_year_province.rds")
  
  saveRDS(psLong_season_province, "Data/Final/psLong_season_province.rds")
  
  # Product list
  write.table(prod_list, "Data/Final/prod_list.csv",
              sep = ",",
              row.names = F)
  
  write.table(product_desc, "Data/Final/prod_desc.csv",
              sep = ",",
              row.names = F)
}
