#Language: R

#Read data from csv file
mydata = read.csv("river_list.csv")

#Generate a random sample of size 20 from the data
mysample <- mydata[sample(1:nrow(mydata), 20, replace=FALSE),] 
