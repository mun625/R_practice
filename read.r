heisenberg <- read.csv(file="seaflow_21min.csv",head=TRUE,sep=",")
sink("step1.txt")
print(summary(heisenberg))
sink()