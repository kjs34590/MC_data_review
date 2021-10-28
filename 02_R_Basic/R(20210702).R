# 2021.07.02.

# 함수 - function()
# for 반복구문

x <- c(2, 3, 4, 5)
x

for (value in x){
  print(value)
}

stu.kor  <- c(81,95,70)
stu.eng  <- c(75,88,78)
stu.mat  <- c(78,99,100)
stu.name <- c('한태형', '임정섭', '강려명')

stu.df <- data.frame(stu.name,stu.kor,stu.eng,stu.mat)
stu.df

str(stu.df)
head(stu.df)

# 파생변수 : 데이터프레임에 있는 열을 이용해 새로운 열을 추가하는 것
# 총점, 평균을 구해 stu.sum, stu.avg 라는 파생변수 추가하기
stu.df$stu.sum <- apply(stu.df[2:4], 1, sum)
stu.df$stu.avg <- apply(stu.df[2:4], 1, mean)
stu.df

## cbind로 하는 법 (굳이)
stu.cbind.df <- cbind(stu.df, stu.cbind.sum = apply(stu.df[2:4], 1, sum))
stu.cbind.df

# 
stu.grade <- ""
size <- nrow(stu.df)

for(i in 1:size){
  if(stu.df$stu.avg[i] >= 90) {
    stu.grade[i] <- "A"
  }else if(stu.df$stu.avg[i] >= 80){
    stu.grade[i] <- "B"
  }else if(stu.df$stu.avg[i] >= 70){
    stu.grade[i] <- "C"
  }else if(stu.df$stu.avg[i] >= 60){
    stu.grade[i] <- "D"
  }else {
    stu.grade[i] <- "F"
  }
}
stu.df$stu.grade <- stu.grade
stu.df

#
stock.df <- read.csv(file.choose())
str(stock.df)
head(stock.df)

rows <- nrow(stock.df)
diff <- ""

for(idx in 1:rows){
  diff[idx] <- (stock.df[idx,3] - stock.df[idx,4])
}
stock.df$diff <- diff
str(diff)

diff<-as.numeric(diff)


str(stock.df$diff)

diffmean <- c()

for (i in 1:rows) {
  if (stock.df$diff[i] > mean(stock.df$diff)){
    stock.df$diffmean[i] <-"mean over"
  } else {
    stock.df$diffmean[i] <-"mean under"
  }
}
head(stock.df)


# 이중 루프
for(i in 2:9){
  cat('row i = ', i, '\n')
  for(j in 1:9) {
    cat(i, '*', j, '=', (i*j),' ')
  }
  cat('\n')
}

# if도 중첩시키기
for(i in 2:9){
  if(i == 2){
  cat('row i = ', i, '\n')
  for(j in 1:9) {
    cat(i, '*', j, '=', (i*j),' ')
  }
  cat('\n')
  }
}

# while 구문
idx <- 1
while(idx <= 10){
  print(idx)
  idx = idx + 1 # 문장 마지막에 증감식 필요
}

idx <- 1
while(idx <= 100){
  if(idx %% 5 == 0) {
    cat(idx, '\t')
  }
  idx = idx +1
}


# NA 확인방법 처리

is.na(c(1,2,3,4,NA))
sum(c(1,2,3,4,NA), na.rm = T)

na.df <- data.frame(x = c(NA, 2, 3),
                    y = c(4, 5, NA))
sum(is.na(na.df))


install.packages('caret')
library(caret)

na.omit(c(1,2,3,4,NA))
na.pass(c(1,2,3,4,NA))
na.fail(c(1,2,3,4,NA))

# NA를 중위수로 처리하기
data.na.vector <- c(2,3,NA,5,6,NA)
is.na(data.na.vector) # 불리언 인덱스 리턴
data.na.vector[is.na(data.na.vector)] <- median(data.na.vector, na.rm = T)
data.na.vector

# heatmap
iris.df <- iris
iris.df[4:10, 3] <- NA
iris.df[1:5, 4] <- NA
iris.df[60:70, 5] <- NA
iris.df[97:103, 5] <- NA
iris.df[133:138, 5] <- NA
iris.df[140, 3] <- NA

iris.df

?heatmap
heatmap(1 * is.na(iris.df),
        Rowv = NA,
        Colv = NA,
        scale = 'none',
        cexCol = .8)


# 함수 ( 코드의 재활용성 높이기 )
# function

user.function <- function(){
  print('no input and no return')
}

user.function()

user.function <- function(x) {
  print('input and no return')
  print(x)
}

user.function(2)

user.function <- function(x, y){
  print('input and return')
  return (x+y)
}
user.function(10,5)

user.function <- function(){
  print('no input and return')
  return('맛점하세요')
}



# 선언
new.user.func <- function(x, y)     {
  cat("x = ", x , '\n')
  cat("y =" , y , '\n')
  result <- x + y                         # 로컬 변수. 글로벌 변수가 아님
}

# 호출
result.sum <- new.user.func(y=5, x=10)
result.sum


new.user.func2 <- function(...) {      # ...은 가변인자
  args <- list(...)
  for(idx in args) {
    print(idx)
  }
}

new.user.func2(1)
new.user.func2(1,2)
new.user.func2(1,2,3,4,6,1,2,4,3)     # 인자 개수가 가변적

# 결측치 비율을 계산하는 함수 정의
iris.df

sum(is.na(iris.df)) / {nrow(iris.df)*ncol(iris.df)} * 100
#
naMissFunc <- function(df) {
  sum(is.na(df)) / length(df) * 100
}

rowMissPer <- apply(iris.df , 1 , naMissFunc)
colMissPer <- apply(iris.df , 2 , naMissFunc)

barplot(colMissPer)


# 조작함수
# cbind() -> 컬럼이 추가된다, rbind() -> 로우가 추가된다, merge()

tmp.df01 <- data.frame(name = c('임정섭', '임은결', '임재원'),
                       math = c(100, 60, 100))

tmp.df02 <- data.frame(name = c('임재원', '임은결', '임정섭'),
                       eng = c(95, 80, 100))

tmp.df01
tmp.df02

cbind(tmp.df01, tmp.df02)  # 원하는 결과가 아님!

merge(tmp.df01, tmp.df02)  # 중복되는 name컬럼을 하나로 하여 합쳐준다.

# mapply
# 다수의 인자를 함수에 넘겨줄 때

mapply(function(i, s){
        sprintf("%d, %s", i, s)
      },
      1:3,
      c('a','b','c'))


head(iris)
apply(iris[-5], 2, mean)
mapply(mean, iris[1:4])

# doBy package
# summaryBy, orderBy, splitBy, sampleBy
install.packages("doBy")
library(doBy)

summary(iris)

# 수치형 자료의 분포를 확인하는 함수는 quantile()
quantile(iris$Sepal.Length)

quantile(iris$Sepal.Length, seq(0,1, by=0.2))


?summaryBy
# 원하는 컬럼의 값을 특정 조건에 따라 요약할 때
summaryBy(. ~ Species, iris)

orderBy(~Species + Sepal.Width , iris)

?splitBy

splitBy(. ~ Species, iris)

#base package
library(base)

# Sepal Length 기준으로 정렬
iris[order(iris$Sepal.Length), ]

# sample()
# 데이터의 표본을 추출할 때, 예를 들어 80%는 학습용, 20%는 검증용으로 사용한다면
# 예측 정확성을 위해 각 범주에서 고르게 추출할 필요가 있다.

iris[ sample(NROW(iris), NROW(iris)), ]

# 각 그룹에서 따로따로 추출하기
test.sample <- sampleBy( ~Species, frac=0.1, data=iris)
test.sample

# split()
split(iris, iris$Species)
lapply(split(iris$Sepal.Length, iris$Species), mean)
class(lapply(split(iris$Sepal.Length, iris$Species), mean))

# 리스트 -> 벡터 -> 매트리스 -> 데이터프레임으로 변환하는 절차 (복습)
irisVec <- unlist(lapply(split(iris$Sepal.Length, iris$Species), mean))
class(irisVec)
irisVec

irisMat <- matrix(irisVec, ncol=3, byrow = T)

irisFrm <- data.frame(irisMat)
irisFrm

names(irisFrm) <- c('setosa_mean', 'versicolor_mean', 'virginica_mean')
irisFrm

# subset()
# 데이터에서 부분의 데이터셋을 만드는 것 (복습)

iris.setosa.df <- subset(iris, Species == 'setosa')

iris.setosa.df <- subset(iris, Species == 'setosa' & Sepal.Length > 5.0)

iris.setosa.df <- subset(iris, Species == 'setosa' & Sepal.Length > 5.0, select = c(3,5))

iris.setosa.df

# order() -> 인덱스 표시, sort() -> 값 표시, which(), which.max(), which.min() -> 인덱스
x <- c(20, 11, 33, 50, 47)
x
order(x, decreasing=T )
x[order(x)]
head( iris[order(iris$Sepal.Length, iris$Petal.Length) , ])
sort(x)
sort(x, decreasing = T)

x <- c(2,4,6,7,10)
x
which(x %% 2 == 0) 
which.min(x)
which.max(x)
# 위와 같이, 인덱스가 리턴되는 함수를 값으로 바꾸기
x[which.min(x)]

