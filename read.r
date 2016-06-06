library(ggplot2)
library(rpart)

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