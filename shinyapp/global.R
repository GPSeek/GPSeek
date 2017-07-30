library(rjson)

credentials_mapbox <- "?access_token=pk.[YOUR TOKEN HERE]"
tiles_mapbox <- "https://api.mapbox.com/styles/v1/mapbox/streets-v10/tiles/256/{z}/{x}/{y}"

credential_here <- "&app_id=[YOUR API ID TOKEN HERE]&app_code=[YOUR APP CODE TOKEN HERE]"
poi_here <- "https://places.cit.api.here.com/places/v1/discover/explore?at=-43.525650%2C172.639847&cat=hospital%2Chospital-health-care-facility&size=50"

credential_google_places <- "&key=[YOUR GOOGLE PLACES TOKEN HERE]"
reference_google <- "https://maps.googleapis.com/maps/api/place/textsearch/json?query="
details_google <- "https://maps.googleapis.com/maps/api/place/details/json?reference="

#poi_json_data <- fromJSON(file='data/health_poi_here_api.json')
poi_json_data <- fromJSON(file=paste(poi_here, credential_here, sep=""))

lat <- c()
lon <- c()
color <- c()
language <- c()
popup <- c()

clean_html_tags <- function(string) {
  return(gsub("<.*?>", " ", string))
}

get_google_detail <- function(title, address) {
  address_query <- URLencode(paste(clean_html_tags(title), clean_html_tags(address), sep=" "), reserved = TRUE)
  poi_json_data <- fromJSON(file=paste(reference_google, address_query, credential_google_places, sep=""))
  reference <- NULL
  for (item in poi_json_data$results) { # this will keep only the last reference but good for now
    if("health" %in% item$types) {
      reference <- item$reference
    }
  }
  if(!is.null(reference)) {
    poi_json_data <- fromJSON(file=paste(details_google, reference, credential_google_places, sep=""))
    opening_hours <- poi_json_data$result$opening_hours$weekday_text
    reviews <- poi_json_data$result$reviews
    details <- ""
    if(!is.null(opening_hours)) details <- paste(opening_hours, collapse="<br/>")
    if(length(reviews)>0) {
      rating <- c()
      for (review in reviews) {
        rating <- c(rating, review$rating)
      }
      details <- paste(details, paste("Rated: ", round(sum(rating)/length(rating), 1), "/5"), sep="<br/><br/>")
    }
    return(details)
  } else {
    return("")
  }
}


for (item in poi_json_data$results$items) {
  if(length(item$position)>0) {
    if(runif(1) <= 0.2) color <- c('red', color) else color <- c('blue', color)
    if(runif(1) <= 0.15) language <- c('english, chinese', language) else language <- c('english', language)
    lat <- c(item$position[2], lat)
    lon <- c(item$position[1], lon)
    details <- get_google_detail(item$title, item$vicinity)
    popup <- c(paste("<b>", item$title, "</b><br/><br/>", item$vicinity, "<br/><br/>", details, sep=""), popup)
  }
}

dat <- cbind(lat, lon)


