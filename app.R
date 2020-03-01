library(shiny)
library(leaflet)
library(tidyverse)


ui <- fluidPage(
    leafletOutput("mymap", height = 800)
)

server <- function(input, output, session) {
    
    points <- read_csv("psigeo.csv") %>%
        rename(endereco = `Endereço`) %>% 
        mutate(y = lat, x = lon)
        
        
        
    output$mymap <- renderLeaflet({
        leaflet() %>%
            addProviderTiles(providers$OpenStreetMap.HOT,
                             options = providerTileOptions(noWrap = TRUE)
            ) %>%
            addMarkers(data = points, label = points$endereco)
    })
}

shinyApp(ui, server)