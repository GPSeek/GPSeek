library(leaflet)

vars <- c(
  "english" = "english",
  "chinese" = "chinese"
)

navbarPage("GPSeek", id="nav",

  tabPanel("Map",
    div(class="outer",

      tags$head(
          # Include our custom CSS
          includeCSS("styles.css"),
          includeScript("gomap.js")
        ),

      leafletOutput("map", width="100%", height="100%"),

      # Shiny versions prior to 0.11 should use class="modal" instead.
      absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
        draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
        width = 150, height = "auto",
        h4("Filters"),
        selectInput("language", "Language", vars)
      )

    )
  )
)
