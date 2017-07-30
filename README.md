# GPSeek

Tourist in New Zealand needing medical services? You've come to the right place!

Prototype
https://qgthurier.shinyapps.io/gpseek/

![Screenshot](https://github.com/GPSeek/GPSeek/blob/master/images/GPSeek%20Shinyapp%20prototype%20screenshot.png)


# Building and running

* Clone
`git clone https://github.com/GPSeek/GPSeek`
* Get [RStudio](https://www.rstudio.com/)
* Install R packages `shiny`, `rjson` and `leaflet`
* Get TOKENS to use APIs

  * Here Places API
https://developer.here.com/rest-apis/documentation/places/

  * Map Box API
https://www.mapbox.com/maps/

  * Google Places API
https://developers.google.com/places/

* Manually edit `global.R` and add the tokens (top few lines)

* Open `ui.R` in RStudio and click "Run App"
