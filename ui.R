library(shiny)

shinyUI(pageWithSidebar(  
    headerPanel("Word Prediction"),  
    sidebarPanel( 
        span(h3('Input'), style = "color:steelblue"),
        textInput(inputId="text1", label = "Enter a phrase here"),
        
        submitButton('Submit')
    ),
    mainPanel( 
      span(h3('Output'),style = "color:steelblue"),
      helpText('The most probable word option is shown below. If nothing is typed, you will see a warning message that nothing 
               has been entered.' ),
      textOutput('text1'),
  
      span(h4('Instructions'), style = "color:steelblue"),
      helpText(
          'This is a simple algorithm that uses n-grams (n = 1, 2, and 3) and the stupid backoff to predict the next word 
          given an input phrase. '),
    helpText('To use this application, enter a phrase in the Input box and click the Submit button. 
            The prediction will appear in the Output section.'
      )
        
    )
))