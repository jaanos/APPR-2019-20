library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Slovenske občine"),
  
  tabsetPanel(
      tabPanel("Velikost družine",
               DT::dataTableOutput("druzine")),
      
      tabPanel("Število naselij",
               sidebarPanel(
                  uiOutput("pokrajine")
                ),
               mainPanel(plotOutput("naselja"))),
      
      tabPanel("Zemljevid",
               plotOutput("zemljevid")),
      
      tabPanel("Število naselij in površina",
               plotOutput("povrsina"))
    )
))
