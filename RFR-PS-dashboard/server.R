#------------------------------------------------------------------------------#

#				GoR - DIME Price Survey app
#       Server

#------------------------------------------------------------------------------#

#### WARNING: ####
cat(paste("This code contains the backend of the dashbaord.",
           sep = "\n"))


#------------------------------------------------------------------------------#  
#### SETTINGS ####

#------------------------------------------------------------------------------#  
#### SERVER ####

server <- function(input, output, session) {
  
  #--------------------#
  #### Testing pane ####
  output$test <- renderPrint({
    plotData()[[2]] %>% summary()
    })
  
  
  #----------------------------------------------------------------------------#  
  #### UI overall interactivity ####
  observeEvent(input$jumpToP2, {
    updateTabsetPanel(session, "inTabset",
                      selected = "panel2") 
  })
  
  
  #----------------------------------------------------------------------------#  
  #### Number of markets ####
  
  nMarkets_reac <- reactive({
    if( multiProv()){
      aggData <- 
        plotData()[[2]] %>%
        dplyr::group_by(Group_var) %>%
        dplyr::summarise(maxNmarkets = max(n_markets)) %>%
        mutate(maxNmarkets = as.integer(maxNmarkets)) %>%
        dplyr::rename("Approximate number of markets:" = maxNmarkets,
                      "Province:" = Group_var)
      return(aggData)
    } else{
      data.frame("maxNmarkets" = max(plotData()[[2]]$n_markets)) %>% 
        dplyr::rename("Approximate number of markets:" = maxNmarkets)
    }

  })

  output$nMarkets_prov <- renderTable({ 
    
    # Error management
    if (is.null(input$product) | 
       (input$geo_agg == "Province" & 
        is.null(input$province) )){
      return(NULL) 
    } 
    
    # Actual table
    nMarkets_reac()
  })
  
  #----------------------------------------------------------------------------#  
  #### REACTIVES AND OBSERVERS ####
  
  #-------------------------#
  #### Logical reactives ####
  
  # Multiple provinces selected
  multiProv <- reactive({
    (input$geo_agg == "Province" & 
       length(input$province) != 1) 
  })
  
  
  # Multiple brands selected
  multiBrand <- reactive({
    (length(input$product_brand) > 1) 
  })
  
  
  #---------------#
  #### Vectors ####
  
  # Products vector
  # This updates product choices vector based on measurement unit input 
  prodList <- reactive({
    prod_list$product[prod_list$std_unit_str == input$product_measure]
    
  })
  
  
  # # Product types vector
  # # This updates product types vector based on each product choices
  # prodType <- reactive({
  #   unique(psTdLong_month$type[psTdLong_month$product_lb == input$product])
  #   
  # })
  
  
  
  # Last product selected
  # Keep consistency when updating selection
  lastProdInput <- reactive({
    lastProdInput <- input$product[1]
    return(lastProdInput)
  })
  
  #-------------------------------------------#
  #### Observers - non conditional updates ####
  
  # # Brand choices
  # observeEvent(input$product, {
  #   updateCheckboxGroupInput(session,
  #                            "product_brand",
  #                            choices = as.list(prodType())
  #   )
  #   
  # })
  # 
  #---------------------------------------#
  #### Observers - conditional updates ####
  
  # Product choices
  # If multiple products selected
  observeEvent(c(input$multiProd,input$product_measure), {
    if(!input$multiProd){
      updateSelectizeInput(session, "product",
                           choices = prodList(),
                           selected = lastProdInput(),
                           options = list(maxItems = 1))
    }
    else{
      updateSelectizeInput(session, "product",
                           options = list(maxItems = 100),
                           choices = prodList(),
                           selected = lastProdInput()
      )
    }
  })
  
  # Set multiProd to FALSE if multiple provinces selected
  observeEvent(input$province,{
    if(multiProv()){
      updateCheckboxInput(session, "multiProd", value = FALSE)
    }

  })

  # Updatade type selection if multiple provinces are selected
  observeEvent(input$province,{
    
    if(multiProv() ){
      updateCheckboxGroupInput(session, 
                               "product_brand",
                               selected= head(input$product_brand,1))
    }
  })
  
  # Updatade province selection if multiple provinces are selected
  observeEvent(input$product_brand,{
    
    if(multiProv() ){
      updateCheckboxGroupInput(session, 
                               "province",
                               selected= head(input$province,1))
    } 
  })
  

  
  #----------------------------------------------------------------------------#  
  #### DATA REACTIVE ####
  
  plotData <- reactive({
    
    #### No type selected ------------------------------
    
    #### Month level data
    if(input$time == "Month"){
      # Level of aggregatrion input
      if(input$geo_agg == "Country"){
        pData <- psLong_month
      } 
      else{ # If input$geo_agg == "Province"
        pData <-
          psLong_month_province[psLong_month_province$province %in% input$province,]
      }
      
    }
    #### Year level data
    else if(input$time == "Year"){
      if(input$geo_agg == "Country"){
        pData <- psLong_year
      } 
      else{ # If input$geo_agg == "Province"
        pData <-
          psLong_year_province[psLong_year_province$province %in% input$province,]
      }
      
    } 
    #### Season level data
    else{ #If input$time == "Season"
      if(input$geo_agg == "Country"){
        pData <- psLong_season
      } else{ # If input$geo_agg == "Province"
        pData <-
          psLong_season_province[psLong_season_province$province %in% input$province,]
      }
    }
    
    # Change grouping of graphs lines to province 
    #if more than one is selected.
    if(input$geo_agg == "Province" & multiProv()){
      pData$Group_var <- pData$province
    }else{
      pData$Group_var <- pData$product_lb
    }
  
    #### Assign final data
    finalData <- pData 
    
    #### Product seleced input
    pData <- pData[pData$product_lb %in% input$product,]
    
    # Price data at the market level, that is the average across traders
    finalData_price <- pData
    
    
    #### At least one type selected --------------------
    # if(!is.null(input$product_brand)){
    #   #### Month level data
    #   if(input$time == "Month"){
    #     # Level of aggregatrion input
    #     if(input$geo_agg == "Country"){
    #       pData_td <- psTdLong_month
    #     } else{ # If input$geo_agg == "Province"
    #       pData_td <-
    #         psTdLong_month_province[psTdLong_month_province$province %in% input$province,]
    #     }
    #     
    #   }else if(input$time == "Year"){
    #     if(input$geo_agg == "Country"){
    #       pData_td <- psTdLong_year
    #     } else{ # If input$geo_agg == "Province"
    #       pData_td <-
    #         psTdLong_year_province[psTdLong_year_province$province %in% input$province,]
    #     }
    #     
    #   } else{ #If input$time == "Season"
    #     if(input$geo_agg == "Country"){
    #       pData_td <- psTdLong_season
    #     } else{ # If input$geo_agg == "Province"
    #       pData_td <-
    #         psTdLong_season_province[psTdLong_season_province$province %in% input$province,]
    #     }
    #   }
    #   
    #   # Change grouping of graphs lines to province 
    #   #if more than one is selected.
    #   if(input$geo_agg == "Province" & multiProv()){
    #     pData_td$Group_var <- pData_td$province
    #   }else{
    #     pData_td$Group_var <- pData_td$type
    #   }
    #   
    #   #### Subset data to match selected type
    #   pData_td <- pData_td[pData_td$type %in% input$product_brand &
    #                        pData_td$product_lb %in% input$product,]
    #   
    #   #### Assign final data
    #   finalData_price <- pData_td
    #   
    # }
    # else{
    #   finalData_price <- pData
    # }
    
    # Availability always in market level
    finalData_avail <- pData
  
    
    # Return a list containing two differnt data frames
    finalData_avail <- as.data.frame(finalData_avail)
    finalData_price <- as.data.frame(finalData_price)
    
    return_list <- list(finalData_price,
                        finalData_avail)
    
    
    return(return_list)
  })
  

  
  
  #-----------------------------#
  #### Format data for table ####
  tableData <- reactive({
    tabData <- plotData()[[1]]
    
    # Remove other variables
    keepVars <- c("product_lb",
                  "Group_var",
                  "price",
                  "avail",     
                  "n_markets",      
                  "Time_Yaxis")
    
    if (length(input$product_brand) > 0){
      tabData$Kind <- tabData$type
      keepVars <- c(keepVars,"Kind")
    }

    
    # Round avail and price
    tabData$price <- round(tabData$price, 2)
    tabData$avail <- round(tabData$avail, 2)
    
    
    # Variable renameinf and selection
    tabData <- 
      tabData[, keepVars] %>% 
      rename("Product" = "product_lb",
             "Average price" = "price",
             "Availability"= "avail",     
             "Markets"= "n_markets")
    
  
    
    # Group var
    if (input$geo_agg == "Country"){
      tabData <- tabData %>% 
        select(-Group_var)
    }
    else if (multiProv()){
      tabData <- tabData %>% 
        rename("Province" = "Group_var")
    }else{
      tabData <- tabData %>% 
        mutate(Province = input$province)%>%
        select(-Group_var)
    }
      
    
    # Time aggregation
    if(input$time == "Month"){
      tabData <- 
        tabData%>% 
          rename("Month" = "Time_Yaxis")
    }
    else if(input$time == "Season"){
      tabData <- 
        tabData%>% 
        rename("Season" = "Time_Yaxis")
    }
    else{ #if(input$time == "Year"
      tabData <- 
        tabData%>% 
        rename("Year" = "Time_Yaxis")
    }
    
    return(tabData)
  })
  
  
  #----------------------------------------------------------------------------#  
  #### Outputs ####
  
  #### Graph conditional formating
  plotFormat <- reactive({
    unit <- prod_list$std_unit[match(input$product_measure, 
                                     prod_list$std_unit_str)]
    product <- input$product
      
    formatDf <- 
      data.frame(title = "",
                 unit = paste("Price per", unit, "<br>(RWFs)") 
                 )
                   
    if(length(product)==1){
      formatDf$title <- product
    } else{
      formatDf$title <- paste(
        paste(
          head(product, length(product) - 1), 
          collapse = ", "),
        "and", 
        tail(product,1))


    }
    
    return(formatDf)
    
  })
  
  
  #--------------#  
  #### GRAPHS ####
  output$product_plots <- renderPlotly({
    
    # Error management
    if (is.null(input$product) | 
       (input$geo_agg == "Province" & 
        is.null(input$province) )){
      return(NULL) 
    }    
    
    p1 <- 
      PlotlyGraph_function_p(
        plotData()[[1]],
        plotData()[[1]]$Group_var,
        ylegend = plotFormat()$unit,
        plotTitle = plotFormat()$title,
        showLegendBol = multiBrand())
    
    p2 <- 
      PlotlyGraph_function_a(
        plotData()[[2]],
        plotData()[[2]]$Group_var,
        "Availability",
        plotTitle = plotFormat()$title)
    
    plotly::subplot(p1, p2 , 
            nrows = 2,
            margin = .05,
            shareX = T) %>% 
      layout(yaxis = list(title = plotFormat()$unit ), 
             yaxis2 = list(title = "Availability <br> Number of markets (%)")
            
             #,
             #which_layout = "merge"
      )
    
  })
  
  #-------------#
  #### TABLE ####
  output$table <- renderDT( #renderDataTable(
    tableData(),
    class = "display nowrap compact", # style
    filter = "top", # location of column filters
    options = list(
      "pageLength" = 10)
    )
  
  
  #----------------------------------------------------------------------------#  
  #### Product description table ####
  
  output$product_table <- renderDT ( #renderTable({ 
    prod_desc %>%
      rename("Product" =  "product",
             "Category" = "type",
             "Standardized measurement" = "std_unit",
             "Preferred kind" = "main_brand",
             "If preferred kind not available" = "OtherBrands") %>%
      arrange(Category),
    class = "display nowrap compact", # style
    
  )
    #} )
  
  #----------------#
  #### DOWNLOAD ####

  output$data.csv <- downloadHandler(
    filename = function() {
      paste("data-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv(tableData(), file, row.names = FALSE)
    }
  )
  
  
  
  
  
  
}
