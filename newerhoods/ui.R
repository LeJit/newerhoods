#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

require(shiny)
require(shinyBS)
require(shinyjs)
require(htmltools)
require(bsplus)
require(shinythemes)
require(shinyWidgets)
require(leaflet)
require(markdown)
require(shinycssloaders)

### Definitions
source("components.R")

# UI
bootstrapPage(
  theme = "custom.css",
  title = "NewerHoods",
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "https://fonts.googleapis.com/css?family=Lato:300,400,400italic,500,500italic,700,700italic,900")
  ),
  header_nav,
  div(
    class="main col-xs-11",
    div(
      class="sidebar",
      div(class="orange-border", ""),
      div(
        class="well",
        ## add modals
        modal_features,
        modal_credits,
        modal_plots,
        modal_feedback,
        info,
        input_housing,
        input_housing_sales,
        input_crime,
        input_noise,
        actionButton("select","Apply",class="btn-custom")
      ),
      intro_links
    ),
    div(
      class="map-content",
      div(class="blue-border", ""),
      div(
        class="map custom",
        withSpinner(leafletOutput("map", height = "535"),type=3,
                    color.background = "white",color="#0099a6"),
        map_control_panel
      ),
      bsTooltip("select", "Click to select or update features to be used for clustering",
                          "right", options = list(container = "body"))
    )
  ),
  footer,
  # activate tooltips, popovers
  use_bs_tooltip(),
  use_bs_popover()
)


