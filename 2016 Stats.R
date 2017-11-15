library(tidyr)
library(dplyr)
library(dummies)
library(readr)
library(ggplot2)

# Import Data Set
getwd()
setwd("/Users/Diane/Desktop/Project/Prosperity")
legatum16 <- read.csv("2016.csv",
                      header = TRUE)

legatum16

# Delete Columns
KeepCols <- c("Rank", "Country")
legatum16 <- legatum16[ , KeepCols ]
legatum16

# Save new data as legatum16.csv
write.csv(legatum16, file = "legatum16.csv")

# Import Data Set
getwd()
setwd("/Users/Diane/Desktop/Project/WHR")
whr16 <- read.csv("2016.csv",
                  header = TRUE)

whr16

# Delete Columns
KeepCols <- c("Country", "Happiness.Rank")
whr16 <- whr16[ , KeepCols ]
whr16

# Save new data as whr16.csv
write.csv(whr16, file = "whr16.csv")

# Merge two columns together by Country
merged.data16 <- merge(legatum16, whr16, by="Country")
merged.data16

# Rename column names
library(plyr)
library(dplyr)
merged.data16 <- rename(merged.data16, c("Rank"="Legatum", "Happiness.Rank"="WHR"))
merged.data16

# Sort by Legatum Rankings
new.data16 <- merged.data16 %>% arrange(Legatum)
new.data16

# Create new column of consecutive numbers to remove missing numbers
new.data16$LegatumRank <- 1:nrow(new.data16) 
new.data16

# Sort by WHR Rankings
new.data16 <- new.data16 %>% arrange(WHR)
new.data16

# Create new column of consecutive numbers to remove missing numbers
new.data16$WHRRank <- 1:nrow(new.data16) 
new.data16

# Remove old columns
KeepCols <- c("Country", "LegatumRank", "WHRRank")
new.data16 <- new.data16[ , KeepCols ]

new.data16

# Create scatterplot
attach(new.data16)
plot(LegatumRank, WHRRank, main="2016 Rankings", 
     xlab="Legatum Ranking ", ylab="World Happiness Report Ranking ", pch=19)

