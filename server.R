#setwd("C:/Users/AA/Desktop/Our Files/Avinash/2015/Coursera/Data Science")
#setwd("09 - Developing Data Products/Code/Project")


require(xlsx)
require(forecast)
require (xts)
rm(list=ls())   # Clean the envrionment completely
# Read in data. Invalid entries have values 0 or 2
tsDF = read.xlsx("TimeSeries.xlsx",
                    sheetName = "Sheet1", header = T)
# Clean the data, by removing obvious errors (data <= 2)
for (i in 1:nrow(tsDF)) {
    if (tsDF[i,2] == 0 || tsDF[i,2]==2) 
        (tsDF[i,2] = 'NA')
}
# Replace all 'NA' entries with a numeric, based on na.approx
tsDF2 = tsDF
tsDF2[,2]= na.approx(tsDF[,2])

shinyServer(
    function(input, output){
        output$tsPlot = renderPlot ({
            output$sDate = renderPrint({input$startDate})
            myTsDF = tsDF2[tsDF2$Date > input$startDate,]
            myTsDF = myTsDF[myTsDF$Date < input$endDate,]
            plot(myTsDF$Date, myTsDF$Data, type=input$type,
                 xlab = "Date", ylab = 'Data',
                 main = 'Plot of Selected Data')
            output$typeOfPlot = renderPrint({input$type}) 
            if (input$fitting == 'linear') {                
                # Ceate a linear regression line, and print in red
                reg = lm( Data ~ Date, data = myTsDF)
                abline(reg, col='red')
            }
            else {
                # Create a loess model line and print in blue                
                ind = 1:nrow(myTsDF)
                data.lo = data.frame(ind, myTsDF$Data)
                lo = loess(myTsDF$Data ~ ind)
                predict.lo = predict(lo)
                preDF = data.frame(myTsDF$Date, predict.lo)
                lines(preDF, col = "blue")
            }
        })
        output$oid1 <- renderPrint({input$id1})
        output$oid2 <- renderPrint({input$id2})
        output$odate <- renderPrint({input$date})
    }
)