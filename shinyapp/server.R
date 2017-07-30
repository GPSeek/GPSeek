library(leaflet)

function(input, output, session) {
  
  output$map <- renderLeaflet({ 
    where <- grep(input$language, language) 
    leaflet() %>%
      addTiles(
        urlTemplate = paste(tiles_mapbox, credentials_mapbox, sep="")
      ) %>%
      setView(lng = 172.639847, lat = -43.525650, zoom = 15) %>%
      addCircleMarkers(data = dat[where, ], 
                       color=color, stroke = FALSE, fillOpacity = 0.8, radius=7, popup=popup)
  })
  
  observe({
    where <- grep(input$language, language)
    leafletProxy("map") %>%
      clearMarkers() %>%
      addCircleMarkers(data = dat[where, ], 
                       color=color, stroke = FALSE, fillOpacity = 0.8, radius=7, popup=popup)
  })

}