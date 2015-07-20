library(shiny)

if ("server.R" %in% dir()) {
  setwd("..")
}
source("lib/libraries.r", encoding = "UTF-8")
source("uvoz/uvoz.r", encoding = "UTF-8")
source("vizualizacija/vizualizacija.r", encoding = "UTF-8")
source("analiza/analiza.r", encoding = "UTF-8")

shinyServer(function(input, output) {
  output$druzine <- DT::renderDataTable({
      t <- data.frame(druzine)
      colnames(t) <- c("1 otrok", "2 otroka", "3 otroci",
                       ">= 4 otroci", "Povprečje")
      t
    })
  
  output$pokrajine <- renderUI(
    selectInput("pokrajina", label="Izberi pokrajino",
                choices=c("Vse", levels(obcine$Pokrajina)))
  )
  output$naselja <- renderPlot({
    main <- "Pogostost števila naselij"
    if (!is.null(input$pokrajina) && input$pokrajina %in% levels(obcine$Pokrajina)) {
      t <- obcine[obcine$Pokrajina == input$pokrajina,4]
      main <- paste(main, "v regiji", input$pokrajina)
    } else {
      t <- obcine[,4]
    }
    hist(t, main = main,
         xlab = "Število naselij", ylab = "Število občin")
  })
  
  output$zemljevid <- renderPlot({
    n <- 100
    barve <- topo.colors(n)[1+(n-1)*(druzine$povprecje-min.povprecje)/(max.povprecje-min.povprecje)]
    plot(zemljevid, col = barve)
    title("Povprečno število otrok v družini")
  })
  
  output$povrsina <- renderPlot({
    plot(obcine[[1]], obcine[[4]],
         main = "Število naselij glede na površino občine",
         xlab = expression("Površina (km"^2 * ")"),
         ylab = "Št. naselij",
         col = barve[obcine[[7]]],
         pch = 18)
    legend("topright", legend = names(barve), col = barve,
           pch = 18, cex = 0.7, bg = "white")
  })
})
