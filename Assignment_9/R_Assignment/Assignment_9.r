#Language: R

#number of trials
trialCount = 10000

#create an empty list
headCount=list() 

for(i in 1:trialCount) 
{ 
  coin <- c("Heads", "Tails")
  tempSample <- sample(coin, size = 3, replace = TRUE) #store result of sample
  headCount[i] <- length(tempSample[tempSample=="Heads"]) #calculate number of heads
}

#This file stores the number of heads in each trial
myFile <- "headCount.txt"
if (file.exists(myFile)) 
  invisible(file.remove(myFile))

#Write the data to file, use invisible to suppress output of lapply on console
invisible(lapply(headCount, write, "headCount.txt", append=TRUE))

#Read data from file
headCountNew <- read.table(myFile, header=FALSE)

#if number of heads>=1, mark as 1
headCountNew[headCountNew >= 1] <- 1 

#count number of 1, hence count number of occurances of at least 1 head
ans<-length(headCountNew[headCountNew==1]) 

cat("Fraction = ",ans,"/",trialCount)