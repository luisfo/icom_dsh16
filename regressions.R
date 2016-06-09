
#
# Author: Luis F. Chiroque
# e-mail: lf.chiroque@imdea.org
#

#NOTE: nlm() might be useful

library("wordcloud")
library("nFactors") #parallel(), nScree(), plotnScree()
#library("MASS")   #factanal(), lda()
#library("psych")  #factor.pa()


# Auxliar function
sanitize_col <- function(col) {
  col[is.null(col) | is.na(col)] <- 0
  col
}

# Variables
dataFileName <- "data3.csv"
teamName <- "uc3m"


# Read and process raw data
raw.data <- read.csv(dataFileName)
## split by time slot (q1, q2, q3, q4, 01, 02, .., 11, 12) quarters and months
data.lst <- split(raw.data, raw.data$time_slot)
## relabel columns for each time slot (ts)
data.lst <- lapply(data.lst, function(df) {
  ts.col <- which(names(df) == "time_slot")
  ts.name <- df$time_slot[1] #e.g. 1
  colVars <- 2:ncol(df)
  colVars <- colVars[-(ts.col-1)]
  names(df)[colVars] <- paste0(names(df)[colVars], ts.name)
  df[,-ts.col]
})

# Note: Q4 (the last quarter) data will be used as ground truth for tests

## merge data in one data.frame
data.full <- Reduce(function(...) merge(..., by="Hashtag", all=T), data.lst)
## filter by hashtag freq > 5 (e.g.)
data.full <- data.full[which(data.full$count_tweetsq3 > 5),]


# Wordcloud
wc.cols <- c("count_tweetsq1", "count_tweetsq2", "count_tweetsq3", "count_tweetsq4")
ht.cloud <- data.frame(ht=as.character(data.full$Hashtag)
                  , freq=rowSums(data.full[,wc.cols]))
ht.cloud$freq <- as.numeric(ht.cloud$freq)
ht.cloud$freq[which(is.na(ht.cloud$freq))] <- 0
wordcloud(ht.cloud$ht, ht.cloud$freq
          , min.freq=50, max.words=50
          , colors=brewer.pal(8, "Dark2"))


# Create input data object
## input.data = {key, y, data}
cols.per.df <- ncol(data.lst[[1]]) - 1 #e.g. 1
month.cols <- split(2:(cols.per.df*12+1), c(mapply(rep, 1:12, cols.per.df)))
q.cols <- split(254:(cols.per.df*4+253), c(mapply(rep, 1:4, cols.per.df)))
## the input object
input.data <- list()
input.data$key <- data.full$Hashtag
## choose between infering either quarter or month
target.q <- 4 #quarter to infer (as test)
#target.m <- 1 # month to infer
### quarter
input.data$y <- data.full[,q.cols[[target.q]][1]]
input.data$data <- data.full[,-c(1, q.cols[[target.q]])]
### month
#input.data$y <- data.full[,month.cols[[target.m]][1]]
#input.data$data <- data.full[,-c(1, month.cols[[target.m]])]


# Split input data in test and training
#set.seed(13)
subset.train <- sample(1:length(input.data$y), length(input.data$y)*.7)
subset.test <- (1:length(input.data$y))[! 1:length(input.data$y) %in% subset.train]
train.data <- list(key=input.data$key[subset.train]
                   , y=input.data$y[subset.train]
                   , data=input.data$data[subset.train,])
test.data <- list(key=input.data$key[subset.test]
                  , y=input.data$y[subset.test]
                  , data=input.data$data[subset.test,])
# sanitize data (null and NaNs to zero)
train.data$data <- data.frame(sapply(train.data$data, sanitize_col))
test.data$data <- data.frame(sapply(test.data$data, sanitize_col))


# Factor discriminant analysis
## estimate best number of variables with eigenvalues
numVars <- which(sapply(input.data$data, is.numeric))
cc <- cor(train.data$data[,numVars], use="complete.obs")
cc[which(is.na(cc))] <- 0
ev <- eigen(cc) # get eigenvalues
ap <- parallel(subject=nrow(train.data$data),var=ncol(train.data$data),
               rep=100,cent=.05)
nS <- nScree(x=ev$values, aparallel=ap$eigen$qevpea)
plotnScree(nS)
### RESULT: 12 or less variables is OK
## factor analysis; try different $k values
k <- 10 # target vars
fit <- fa(train.data$data, nfactors=k, fm="pa")
fit # print results
fit <- principal(train.data$data, nfactors=k)
fit # print results
## PCA alternative
#library("FactoMineR")
#result <- PCA(train.data$data)
## factor analysis; NOT working with all columns
#k <- 5 # target vars
#fit <- factanal(train.data$data[,numVars], k)
#fit <- factanal(train.data$data, k, rotation="promax")
#fit <- factanal(train.data$data, k, scores="Bartlett")
#fit <- factanal(train.data$data, k, scores="Bartlett", rotation="promax")
#print(fit) #, digits=2, cutoff=.3, sort=TRUE)
### look for a high p-value
### the next code is slow!
#fit <- lda(train.data$y ~ ., data=train.data$data, CV=TRUE)
#ct <- table(train.data$y, fit$class)
#diag(prop.table(ct, 1))
### total percent correct
#sum(diag(prop.table(ct)))


# Regression
## general mode zero; as reference
fit.0 <- glm(log(train.data$y+1) ~ .
             , family = gaussian, data=log(train.data$data+1))
summary(fit.0, dispersion=1)
# monthly
fit <- glm(log(train.data$y+1) ~ log(count_tweets01+1)
           , family = gaussian, data=train.data$data)
# quarter
fit <- glm(log(train.data$y+1) ~ log(count_tweetsq3+1) + log(count_tweetsq2+1) + log(count_tweetsq1+1) + log(count_tweets09+1) + log(count_tweets08+1) #+ log(count_tweets06+1) + log(count_tweets05+1) + log(Avgklout_scoreq3+1) + log(MaxFollowers09+1) + log(MaxRetweetCountq3+1)
           , family = gaussian, data=train.data$data)
summary(fit, dispersion=1)
### AIC as low as possible, and as close to min AIC as possible (`y ~ .` model)
### TAKE this model ABOVE
## linear
fit <- lm(log(train.data$y+1) ~ log(count_tweetsq2+1) + log(count_tweetsq3+1) #+ log(count_tweetsq1+1) #+ log(count_tweets09+1) + log(count_tweets08+1) + log(MaxFollowers09+1)
          , data=train.data$data)
summary(fit)
## check linear hypothesis
### homothedasticity
qqnorm(fit$residuals)
abline(0,1, lty=2)
### RESULT: great!


# Evaluation
## try the test set
pred <- predict(fit, newdata=test.data$data, interval="prediction")
subset <- which(!is.na(test.data$y))
cor(pred[subset], log(test.data$y[subset]+1))
### RESULT: >0.7 correlation coef.


# Model
## build a full model
fit.final <- glm(log(input.data$y+1) ~ log(count_tweetsq3+1) + log(count_tweetsq2+1) + log(count_tweetsq1+1) + log(count_tweets09+1) + log(count_tweets08+1)
                 , data=input.data$data)


# Prediction
## read pre-results files
result <- read.csv("hashtag_q116_pred.csv", header=F)
## build full dataset
data.full <- Reduce(function(...) merge(..., by="Hashtag", all=T)
                    , data.lst)
## filter data by target Hashtags
subset <- which(data.full$Hashtag %in% result$V1) # filter
data.pred <- data.full[subset,]
data.pred <- data.frame(Hashtag=data.pred$Hashtag
                        , sapply(data.pred[,-1], sanitize_col))
## move variables to fit the model
### the model is built to predict 'q4' using previous data
### so, we relabel 'q4' to 'q3' and so on, respectively
### recall that we have to predict 'q1_2016'
data.pred[,q.cols[[1]]] <- data.pred[,q.cols[[2]]]
data.pred[,q.cols[[2]]] <- data.pred[,q.cols[[3]]]
data.pred[,q.cols[[3]]] <- data.pred[,q.cols[[4]]]
data.pred[,month.cols[[8]]] <- data.pred[,month.cols[[11]]]
data.pred[,month.cols[[9]]] <- data.pred[,month.cols[[12]]]
## predicted data.frame
pred.final <- data.frame(pred=predict(fit.final, newdata=data.pred, interval="prediction")
                    , Hashtag=data.pred$Hashtag)
## wordcloud
wordcloud(pred.final$Hashtag, pred.final$pred
          , min.freq=4, max.words=50, scale = c(1,.3)
          , colors=brewer.pal(8, "Dark2"))
## build the result object
names(result)[1] <- "Hashtag"
result <- merge(result, pred.final, sort=F)
result$V2 <- NULL
## write results
resultFileName <- paste0("hashtag_q116_", teamName, ".csv")
write.table(result, resultFileName, col.names=F, sep=",")


# Test result file
system(paste0("python score_icom.py ", resultFileName))
