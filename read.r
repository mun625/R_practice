
# STEP1. Read CSV data and summarize it to step1.txt
seaflow <- read.csv(file="seaflow_21min.csv",head=TRUE,sep=",")
sink("step1.txt")
print(summary(seaflow))
sink()


# STEP2. Split the data into traing and test sets
dt = sort(sample(nrow(seaflow), nrow(seaflow)*.7))
train <- seaflow[dt,]
test <- seaflow[-dt,]