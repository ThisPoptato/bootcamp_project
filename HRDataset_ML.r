# load library
install.packages("mlbench")
install.packages("tidyverse")
install.packages("caret")
library(mlbench)
library(tidyverse)
library(caret)
library(dplyr)

data <- read.csv("HRDataset_v15.csv")
mean(complete.cases(data))
data <- na.omit(data)

train_test_split <- function(data, train_size = 0.8){
  set.seed(42)
  n <- nrow(data)
  id <- sample(1:n, size= n*train_size)
  train_data <- data[id, ]
  test_data <- data[-id, ]
  
  return(list(train_data,test_data))
}


split_data <- train_test_split(data)
train_data <- split_data[[1]]
test_data <- split_data[[2]]
nrow(train_data)
nrow(test_data)

# Classification
grid <- data.frame(mtry=c(5,6,11))

ctrl <- trainControl(method = "cv",
                     number = 5,
                     verboseIter = T)

set.seed(12)
rf_model <- train(
  PerformanceScore ~ MaritalDesc + Salary + Sex + Department, 
  data = train_data,
  method = "rf",
  trControl = ctrl,
  tuneGrid = grid
)

p1 <- predict(rf_model,newdata = test_data)

mean(p1 == test_data$PerformanceScore)

varImp(rf_model)

# Salary importance in Performance Score Acc 0.7777778

# Regression

ctrl <- trainControl(method = "cv",
                     number = 5,
                     verboseIter = T)

set.seed(12)
lm_model <- train(
  Absences ~ SpecialProjectsCount + DaysLateLast30 + DeptID, 
  data = train_data,
  method = "lm",
  trControl = ctrl
)

p2 <- predict(lm_model,newdata = test_data)

mean(p2 == test_data$Absences)

varImp(lm_model)

