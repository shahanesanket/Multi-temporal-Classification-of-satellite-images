library(e1071)

setwd("C:/Users/Sanket Shahane/Google Drive/MS/ALDA/Project/Multi-Temporal-Classification/TrainingData/ValidationData")
dataset1=read.csv("ValidationData-2015-04-19.csv")
dataset2=read.csv("ValidationData-2015-12-31.csv")
dataset3=read.csv("ValidationData-2016-01-16.csv")
dataset4=read.csv("ValidationData-2016-03-20.csv")
dataset1 = dataset1[,-c(1,2,3)]
dataset2 = dataset2[,-c(1,2,3)]
dataset3 = dataset3[,-c(1,2,3)]
dataset4 = dataset4[,-c(1,2,3)]

setwd("C:/Users/Sanket Shahane/Google Drive/MS/ALDA/Project/Multi-Temporal-Classification/Rscripts")
load("image1.MLCmodel.rda")
load("image2.MLCmodel.rda")
load("image3.MLCmodel.rda")
load("image4.MLCmodel.rda")

# function to calculate the weight of the model
calculateWeight <- function(dataset){
  weight = 1
  for(i in seq(1,nrow(dataset),1)){
    index = as.integer(dataset[i,1])
    weight = weight*dataset[i,index+9]
  }
  return(weight)
}

calculateLogWeight <- function(dataset){
  weight = 0
  for(i in seq(1,nrow(dataset),1)){
    index = as.integer(dataset[i,1])
    weight = weight + log(dataset[i,index+9])
  }
  return(weight)
}

# code to get the probabilites of individual classes and assign class labels to them
image.probs = predict(image4.MLCmodel[[1]],dataset4[,-1],type = "raw")
head(image.probs)
#image.labels = apply(image2.probs,1,which.max)
datasetWithProbs = cbind(dataset4,image.probs)
head(datasetWithProbs) #data points and corresponding data probabilites joined

#w = calculateWeight(datasetWithProbs)
w = calculateLogWeight(datasetWithProbs)
print(w)
image4.BMAmodel.LogWeighted = list(image4.MLCmodel[[1]],image4.MLCmodel[[2]],w)
# save the model with error and weight
save(image4.BMAmodel.LogWeighted,file="image4.BMAmodel.LogWeighted.rda")
