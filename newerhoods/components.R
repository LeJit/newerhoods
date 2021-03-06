header_nav <- withTags(
  header(class ="header",
         div(class="content col-xs-11", 
             div(class="navbar-wrapper", 
                 a(href="https://www.twosigma.com/about/data-clinic/", target="_blank",
                   div(class="navbar-title", "NewerHoods"),
                   div(class="navbar-subtitle", "FROM TWO SIGMA DATA CLINIC")
                 )
             )
         )
  )
)
### Modals
modal_features <- 
  bsModal(
    id = "modal_features",
    title="Getting started with NewerHoods",
    body= includeMarkdown("markdowns/tutorial.md"),
    size="medium",
    trigger = "Help"
  )

modal_plots <- 
  bs_modal(
    id = "modal_plots",
    title="Interpreting Plots",
    body= includeMarkdown("markdowns/plots.md"),
    size="medium"
  )

modal_credits <- 
  bsModal(
    id = "modal_credits",
    title="NewerHoods",
    body= includeMarkdown("markdowns/intro.md"),
    size="medium",
    trigger = "Credits"
  )

modal_feedback <- 
  bsModal(
    id = "modal_feedback",
    title="Feedback",
    body= includeMarkdown("markdowns/appendix.md"),
    size="medium",
    trigger = "Feedback"
  )

### Info
info <- 
  div(class="text",
      div("Choose characteristics to draw neighborhoods.")
  ) 


### Inputs
input_housing <- checkboxGroupInput(
  inputId = 'housing',label="HOUSING",
  choices=c("Age of buildings"="bldg_age","Median Sale Price"="sale_price"),
  selected = "bldg_age"
)

input_housing_sales <- conditionalPanel(condition="input.housing.includes('sale_price')",
                                        radioButtons(
                                          inputId = 'sales_features',label="",
                                          choices=c("1y Average"="med_price_1y|sd_price_1y",
                                                    "3y Average"="med_price_3y|sd_price_3y",
                                                    "5y Average"="med_price_5y|sd_price_5y"
                                          ),selected = NULL))


input_crime <- 
  checkboxGroupInput(
    inputId = 'crime_features', label="CRIME",
    c("Violations"="violation_rate",
      "Felonies"="felony_rate",
      "Misdemeanors"="misdemeanor_rate"
    )
  )

input_noise <- 
  checkboxGroupInput(
    inputId = 'call_features',label="311 COMPLAINTS",
    c("Ice Cream truck"="icecream_rate",
      "Barking Dog"="animal_rate",
      "Loud Music/party"="party_rate"
    )
  )

input_clusters <-
  sliderInput("num_clusters",
              label="Number of neighborhoods",
              ticks = FALSE,
              min = 5,
              max = 200,
              value = 100)

input_enable_heatmap <- 
  materialSwitch(inputId = "enable_heatmap", label = "Cluster map", status = "info")

# info_plot_type <- shiny_iconlink() %>%
#   bs_attach_modal(id_modal = "modal_plots")

info_plot_type <- shiny_iconlink() %>%
  bs_embed_tooltip(title="The cluster map shows the city divided into the selected neighborhoods.
                          The colors are only to differentiate clusters from one another.
                          The heatmap shows the relative value for clusters averaged over the 
                          chosen characteristics.",
                   placement = "top")

input_baseline <- 
  selectInput('baseline',label='Compare against',
              choices=list("None"="none",
                           "Community Districts (59)"="cds",
                           "Public use Microdata Areas (55)"="pumas",
                           "Neighborhood Tabulation Areas (195)"="ntas",
                           "Police Precincts (77)"="precincts",
                           "School Districts (33)"="school_dists"),
              selected = "none")

map_control_panel <- div(
  class="flex flex-between map-control", 
  div(class="xsflex", 
      input_clusters,
      input_baseline
  ),
  div(
    class="flex flex-end auto heatmap-group", 
    input_enable_heatmap,
    div(class="heat-map-label", "Heat map"),
    info_plot_type
  )
)

help_link <- actionLink(inputId = "Help",label="Help")
feedback_link <- actionLink(inputId = 'Feedback',label="Feedback")
credits_link <- actionLink(inputId = 'Credits',label="About")

intro_links <- 
  div(class="links flex",
      div(class="mainlink",credits_link),
      div(class="mainslink",help_link),
      div(class="mainslink",feedback_link)
  )

footer <-
  div(class="footer", 
      div(class="content flex-between col-xs-11 xsflex",
          div(class="links", a(href="https://www.twosigma.com/about/data-clinic/", "© 2019 Data Clinic. All rights reserved.")),
          div(class="flex",
              div(class="links", a(href="https://www.twosigma.com/legal-disclosure/", "Legal Disclosure", target="_blank")),
              div(class="slink links", a(href="https://www.twosigma.com/legal-disclosure/privacy-policy/", "Privacy Policy", target="_blank"))
          )
      )
  )