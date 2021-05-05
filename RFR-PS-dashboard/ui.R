#------------------------------------------------------------------------------#

#				GoR - DIME Price Survey app
#       UI

#------------------------------------------------------------------------------#


source("globals.R")

#------------------------------------------------------------------------------#  
#### UI ####
navbarPage(
  'Rwanda Rural Markets Prices',
  id = "inTabset",
  tabPanel(
    title = "Introduction", 
    value = "panel1",
    includeMarkdown("coverPage.Rmd"),
           br(), br(),
    actionButton('jumpToP2', 
                 'Continue') ),
  tabPanel(
    title = "Dashboard", 
    value = "panel2",         
    fluidPage(
      tags$head(tags$style(
        HTML('
          #title {
            color: white;
            background-color: #2c3e50;
            font-style: bold;
            padding-top: 25px;
            padding-right: 30px;
            padding-bottom: 25px;
            padding-left: 30px;
          }
              '
             ) ) ,
        # Format just the third tab CSS fdp
        tags$body(tags$style(
          "
          .nav-tabs li:nth-child(3) {
            font-style: italic;
          }
          "
        ))
        ),
      
      theme = shinytheme("flatly"),
      
    
      
      # Sidebar with a inputs 
      sidebarLayout(
        sidebarPanel(width = 3,
          selectizeInput("product_measure", "Select unity of measure:", 
                         choices = c("Weight" = "Sold by weight", # vaues need to match prodlist
                                     "Unit" = "Sold by unit", 
                                     "Volume" = "Sold by volume"), 
                         selected = "Sold by weight", 
                         multiple = FALSE,
                         width = NULL, 
                         size = NULL),
          selectizeInput("geo_agg", "Select level of geographic aggregation:", 
                         choices = c("Country", "Province"), 
                         selected = "Country", 
                         multiple = FALSE,
                         width = NULL, 
                         size = NULL), 
          conditionalPanel("input['geo_agg'] == 'Province'",
            checkboxGroupInput("province",
                               label = "Select Province",
                               choices = unique(psLong_month_province$province),
                               selected = unique(psLong_month_province$province)[1])

          ),
          selectizeInput("product", "Select products:", 
                         choices = prod_list$product, 
                         selected = "Tomato", 
                         multiple = TRUE,
                         width = NULL, 
                         size = NULL),
          conditionalPanel(
            condition = "input['geo_agg'] == 'Country'",
            checkboxInput("multiProd", label = "Select multiple products", value = FALSE)
          ),          
          selectizeInput("time", "Select level of time aggregation:",
                         choices = c("Month", "Season", "Year"),
                         selected = NULL,
                         multiple = FALSE,
                         width = NULL,
                         size = NULL) ,
          downloadButton("data.csv", "Download data")
          
        ),
        
        # Main panel with outputs
        mainPanel(
          tabsetPanel(
            id = "Tabs",
            tabPanel("Plot",
                     # box(width = NULL,
                     #     h4("Testing pane"),
                     #     verbatimTextOutput("test") ),
                     h4(textOutput("nMarkets")),
                     #br(),
                     tableOutput('nMarkets_prov'),
                     #br(),
                     plotlyOutput(outputId = "product_plots")
                     ), 
            tabPanel("Table", 
                     dataTableOutput('table') ) ,
            #tabPanel("Map") ,
            tabPanel("Product description",
                     dataTableOutput('product_table') )
            )

        )
      ) # Close fluid page
    ) # Close tab2
))
