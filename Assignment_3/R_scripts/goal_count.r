
weighted_Random_Sample <- function(
  .data,
  .weights,
  .n
){
  #This section of code is slightly incorrect, Our team is currently working on it.
  key <- runif(length(.data)) ^ (1 / as.double(.weights))
  return (.data) 
  # Currently returns all rows, this line will be changed in the final version
}

mydata = read.csv("MLS_Schedule_April_2015.csv")
myData = read.csv("MLS_Schedule_April_2015.csv")
mysample <- mydata[sample(1:nrow(mydata), 20, replace=FALSE),] 

mydata$Composite <- strptime(mydata$Composite,"%Y-%m-%d %H:%M")
dateFields <- as.Date(mydata$Composite, "%Y-%m-%d %H:%M")
N <- length(dateFields)
diff <- dateFields[1:N] - Sys.Date()
weights <- as.list(diff)
weight <- t(weights)
weighted_Random_Sample(myData,weight,20)

