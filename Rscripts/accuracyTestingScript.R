load("image1.MLCmodel.rda")
load("image2.MLCmodel.rda")
load("image3.MLCmodel.rda")
load("image4.MLCmodel.rda")

dataset = read.csv("AccuracyData-2015-04-19.csv")
dataset = dataset[,-c(1,2,3)]
head(dataset)

current.model = image1.MLCmodel[[1]]

table(predict(current.model,dataset[,-1]),dataset[,1])
accuracy = sum(predict(current.model,dataset[,-1])==dataset[,1])
accuracy = accuracy/nrow(dataset)
print(accuracy)
print(paste("Expected prediction accuracy:",(1-image1.MLCmodel[[2]])))