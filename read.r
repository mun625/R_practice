library(ggplot2)
library(rpart)
library(randomForest)
library("e1071")

# STEP1. Read CSV data and summarize it to step1.txt
seaflow <- read.csv(file="seaflow_21min.csv",head=TRUE,sep=",")
sink("step1.txt")
print(summary(seaflow))
sink()

# STEP2. Split the data into traing and test sets
dt = sort(sample(nrow(seaflow), nrow(seaflow)*.7))
train <- seaflow[dt,]
test <- seaflow[-dt,]

# STEP3. Plot the data
pe_plot <- ggplot(seaflow, aes(x=chl_small, y=pe)) + geom_point(aes(colour=pop, group=pop))
save(pe_plot,file="step3.RData")
load("step3.RData")
ggsave("step3.png")

# Step4. Train a decision tree
sink("step4.txt")
fol <- formula(pop ~ fsc_small + fsc_perp + fsc_big + pe + chl_big + chl_small)
model <- rpart(fol, method="class", data=train)
print(model)
sink()

# Step 5: Evaluate the decision tree on the test data
sink("step5.txt")
pred <- predict(model, test, type='class')
accuracy <- pred == test$pop
print(sum(accuracy)/length(accuracy))
sink()

# Step 6: Build and evaluate a random forest
sink("step6.txt")
model2 <- randomForest(fol, method="class", data=train)
pred <- predict(model2, test, type='class')
accuracy <- pred == test$pop
print(sum(accuracy)/length(accuracy))
sink()

# Step 7: Train a support vector machine model and compare results.
sink("step7.txt")
model3 <- svm(fol, method="class", data=train)
pred <- predict(model3, test, type='class')
accuracy <- pred == test$pop
print(sum(accuracy)/length(accuracy))
sink()

