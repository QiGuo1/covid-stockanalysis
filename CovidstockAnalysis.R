#loading required R libraries 
library(ggplot2)
library(dplyr)
options(warn=-1)

#Load Covid Data
dfcovid <- read.csv(file = 'data/Covid19_6July/covid_19_data.csv', header = TRUE)
dfcovid <- subset(dfcovid, select =c(Date,Confirmed,Deaths,Recovered))
dfcovid <- dfcovid %>% group_by(Date) %>% summarise_all(sum)
head(dfcovid)

#Read Stock Indices of Various Contries
dfChina<-read.csv(file = 'data/StockIndices/000001.SS.csv', header = TRUE)
dfUS<-read.csv(file = 'data/StockIndices/XAX.csv', header = TRUE)
dfRussia<-read.csv(file = 'data/StockIndices/IMOEX.ME.csv', header = TRUE)
dfJapan<-read.csv(file = 'data/StockIndices/N225.csv', header = TRUE)

#Select the Date and Stock Index value
dfUS <- subset(dfUS, select =c(Date,Adj.Close))
colnames(dfUS)[2]<-"US"
dfChina <- subset(dfChina, select =c(Date,Adj.Close))
colnames(dfChina)[2]<-"China"
dfRussia <- subset(dfRussia, select =c(Date,Adj.Close))
colnames(dfRussia)[2]<-"Russia"
dfJapan <- subset(dfJapan, select =c(Date,Adj.Close))
colnames(dfJapan)[2]<-"Japan"

#Merge the dataset
merge1<-merge(dfUS,dfChina, by = c("Date"))
merge2<-merge(dfJapan,dfRussia, by = c("Date"))
dfstock<-merge(merge1,merge2, by = c("Date"))
#Display Stock Indices
head(dfstock)

#Stock Indices dataset with Covid Dataset
dfmerge<-merge(dfstock,dfcovid, by = c("Date"))
head(dfmerge)

#Scatter Plot between Stock Indices & Covid Dataset
pairs(dfmerge[2:8], pch = 21)

#Correlation Between Stock Indices & Covid Cases
dfcor <- subset(dfmerge, select =-c(Date))
round(cor(dfcor),2)