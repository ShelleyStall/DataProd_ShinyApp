library(shiny)
suppressPackageStartupMessages(library(googleVis))
## read the school data and group by state.  Assign column names.
schooldata <- read.csv("postscndryunivsrvy2013dirinfo.csv", stringsAsFactors = FALSE)
school_sum_by_state <- as.data.frame(table(schooldata$STABBR))
colnames(school_sum_by_state) <- c("state.abb", "Num_of_schools")
## Make available the state information in the R package datasets.  Create a data frame of state abbreviations and names.
require(datasets)
state_and_abb <- cbind(state.abb,state.name)
## Merging the school data with the state information drops the 9 territories that don't match the 50 states
school_by_state <- merge(school_sum_by_state,state_and_abb,by="state.abb")

## Add a new colume with the latitude and longitude information needed by gvisMap.
schooldata$latlong=paste(schooldata$LATITUDE, schooldata$LONGITUD, sep=":")

## Function determineNum that takes as input the name of the state selected and provides
##    the number of schools in that state.
determineNum <- function(state) school_by_state[school_by_state$state.name == state,2]
## Function determineAbb that takes as input the name of the state selected and provides
##    the state abbreviation to be used on the Information tab for the state map.
determineAbb <- function(state) school_by_state[school_by_state$state.name == state,1]

shinyServer(function(input,output) {
  ## Used on the Information by State Tab
  output$Text1 <- renderText(input$state)
  output$Text2 <- renderPrint({determineNum(input$state)})
  ## Renders an interactive US Map.  Used on the US Map Tab
  output$myMap <- renderGvis({
    gvisGeoChart(school_by_state, locationvar = "state.name", colorvar = "Num_of_schools", options=list(region="US", displayMode="regions", resolution="provinces",width=600, height=400))
  })
  ## Renders the markers for a selected state. Used on the Information by State Tab.
  ## Items of note. The markers are custom.  gvisMap has a limitation of only 400 markers.
  output$myStateMap <- renderGvis({
    stateabb <- determineAbb(input$state)
    state_schooldata <- subset(schooldata,STABBR==stateabb)
    ##the max number rows is 400
    if (nrow(state_schooldata) > 400) {
      state_schooldata2 <- state_schooldata[1:400, c("latlong","INSTNM")]
    }  else  {
      state_schooldata2 <- state_schooldata[, c("latlong","INSTNM")]
    }
    gvisMap(state_schooldata2, "latlong" , "INSTNM", 
            options=list(showTip=TRUE, showLine=TRUE, enableScrollWheel=TRUE, mapType='terrain', useMapTypeControl=TRUE, width=400, height=400,
            icons=paste0("{",
              "'default': {'normal': 'http://icons.iconarchive.com/",
              "icons/fatcow/farm-fresh/32/",
              "bullet-blue-icon.png',\n",
              "'selected': 'http://icons.iconarchive.com/",
              "icons/fatcow/farm-fresh/32/",
              "bullet-blue-icon.png'",
              "}}")))
})
    
})