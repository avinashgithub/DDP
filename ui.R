shinyUI(pageWithSidebar(
    headerPanel("Time Series Plotting"),
    sidebarPanel(
        h2('This application plots a time-series with sporadic missing entries'),
        dateInput("startDate", "Start Date:",
                  value = '1/1/2010', min ='12/31/2006'),
        dateInput("endDate", "End Date:",  
                  value = '8/13/2015', max ='8/13/2015'),
        selectInput('type', "Type of Plot", 
                    choices=c("points", "line", "both"), 
                    selected = "line", multiple = FALSE, 
                    selectize = TRUE),
        radioButtons("fitting", "Type of Fitting",
                     choices = list("linear" = "linear", "loess" = "loess"), 
                     selected = "linear"),
        h2('Documentation'),
        h4('This page analyzes daily data from range specified by user.'),
        h4('There is a lot of data, so it may take a while to run.'),
        h4('Select date range by either clicking and selecting from calendar, 
           or entering in the box directly. There is some basic error checking.'),
        h4('Select the type of plot - points, line or both through the drop down
           menu.'),
        h4('Select the type of lines to be fit through radio buttons.')
    ),
    mainPanel(
        plotOutput('tsPlot')
        
        
    )
))
