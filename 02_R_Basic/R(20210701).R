# data.frame
# tapply(vector, index, function) -> (group by의 역할. vector는 범주형)
?tapply

tapply(1:10, rep(1, 10), sum)

# 1 ~ 10까지 숫자를 홀수, 짝수별로 묶어서 합계 구하기
tapply(1:10, rep(c("odd","even"), 5), sum)

tapply(1:10, ifelse(1:10%%2 == 1, 1, 2), sum)
 
tapply(1:10, 1:10 %% 2 == 0, sum)

# iris 활용
iris.df <- iris
iris.df
str(iris.df)
head(iris.df)



# iris 종별 Sepal.Length의 평균을 구하기
tapply(iris.df$Sepal.Length, iris.df$Species, mean)

sample.mat <- matrix(1:8, 
                     ncol = 2,
                     dimnames = list(c('spring','summer','fall','winter'),
                                     c('male', 'female')))
sample.mat


# 반기별 남성 셀의 값 합과 여성 셀의 합
tapply(sample.mat, list(c(1,1,2,2,1,1,2,2,),
                        c(1,1,1,1,2,2,2,2,)), sum)

# with(dataset, tapply())

height <- c(173, 190, 164, 166, 180, 177, 184, 169, 157)
gender <- c('m', 'm', 'f', 'f', 'm', 'm', 'm', 'f', 'f')

height.gender.df <- data.frame(height, gender)
str(height.gender.df)

height.gender.df$gender <- as.factor(height.gender.df$gender)
str(height.gender.df)
levels(height.gender.df$gender)

tapply(height.gender.df$height, height.gender.df$gender,mean)

with(height.gender.df, tapply(height, gender, mean))

# f,m도 dataframe으로 반환되는 차이 (위 방법과 달리)
?aggregate
gender.mean <- with(height.gender.df, aggregate(height, list(gender), mean))
gender.mean
str(gender.mean)

# exercise
car.df <- mtcars
car.df
str(car.df)

# 실린더별 전체 컬럼의 평균 구하기
with(car.df, aggregate(car.df, list(cylmean = cyl),mean))

# disp 컬럼이 120 이상인 조건 추가
with(car.df, aggregate(car.df, list(cyl, disp>=120), mean))

# cyl 컬럼을 기준으로 wt 컬럼의 평균만 구하기
with(car.df, aggregate(wt, list(cylmean = cyl), mean))

# carb , gear 컬럼 두가지를 기준으로 wt 구하기
with(car.df, aggregate(wt,list(carb, gear), mean))

# gear 기준으로 disp, wt 평균 구하기
with(car.df, aggregate(cbind(disp, wt), list(gear), mean))

with(car.df, aggregate(car.df[c('disp', 'wt')], list(gear), mean))

with(car.df, aggregate(cbind(disp, wt) ~ gear, car.df, mean))

# carb , gear 컬럼 기준으로 disp, wt 평균
with(car.df, aggregate(cbind(disp, wt), list(carb, gear), mean))

# cyl 제외한 다른 모든 컬럼을 기준으로 cyl 의 평균을 구하기
aggregate(cyl ~ . , car.df , mean)

install.packages("MASS")
library(MASS)
car93.df <- Cars93
str(car93.df)

levels(car93.df$Type)

# 타입별 고속도로 연비 평균
car93.df
with(car93.df, tapply(MPG.highway, Type, mean))
with(car93.df, aggregate(MPG.highway, list(Type), mean))
with(car93.df, aggregate(MPG.highway ~ Type, car93.df, mean))
aggregate(MPG.highway ~ Type, car93.df, mean)

install.packages("ggplot2")
library(ggplot2)

# qplot(number vector, dataset, facets=factor, binwidth=n)
qplot(c(MPG.highway), data = car93.df, facets = Type ~ . , binwidth=2)


# 형변환, 연산자, 제어구문, 반복구문
# as.*
# data.frame(matrix)

class(matrix(1:4, ncol=2))

casting.data.frame.df <- as.data.frame(matrix(1:4, ncol=2))
colnames(casting.data.frame.df) <- c('x', 'y')
class(as.data.frame(matrix(1:4, ncol=2)))

class(list(x=c(1,2), y=c('3','4')))


# 산술연산자
# <-, =. +, -, *, /, %/%, %%, ^

# 관계연산자
# ==, !=, >, >=, <. <=

# 논리연산자(TRUE, FALSE, T, F)
# &, |, xor(exclusive or)

# 제어 구문 & 반복 구문 (업무 로직 처리를 위한 프로그램 흐름 제어가 필요한 경우)
# if, switch
# for, while, do ~ while
# if, if ~ else, if ~ else if ~ else ~~~, ifelse(조건, T, F)

data.logical <- T
if(data.logical){
  print("true")  
} else {
  print("false")
}


data.logical <- F
score <- 70
if(score >= 60){
  print("합격")  
} else {
  print("불합격")
}

# scan()


if(score >= 90){
  grade <- 'A'
}else if(score >= 80){
  grade <- 'B'
}else if(score >= 70){
  grade <- 'C'
}else if(score >= 60){
  grade <- 'D'
}else {
  grade <- 'F'
}


cat("당신의 점수는 ", score , "점이고, 당신의 학점은 ", grade)
sprintf("당신의 점수는 %d이고 당신의 학점은 %s", score, grade)


# 주민번호로 성별 구분
user.ssn <- "730910-1xxxxxx"

gender <- substr(user.ssn, 8, 8)
if(gender == '1' | gender == '3'){
  print('남자')
}else {
  print('여자')
}

# 혹은,
class(substr(user.ssn, 8,8))
# ifelse에는 input되는 형식이 벡터이므로
ifelse(substr(user.ssn, 8, 8)==1, "남자", "여자")
# 혹은
gender <- substr(user.ssn, 8, 8)
ifelse(gender == '1'| gender == '2', '남자', '여자')

scores <- c(96, 91, 100, 88, 90)
ifelse(scores >= 90, 'pass', 'fail')

na.vec <- c(96, 91, 100, 88, 90, NA, 95, 80, NA, 72)

ifelse(sum(is.na(na.vec))>=1, mean(na.vec, na.rm=T), mean(na.vec))

mean(ifelse(is.na(na.vec)==F, na.vec, na.rm=T))

# 파일 선택하기
tmp.csv <- read.csv(file.choose())
str(tmp.csv)

tmp.csv$q5

q6 <- ifelse(tmp.csv$q5 >= 3, 'bigger', 'smaller')

tmp.csv$q6 <- q6
tmp.csv$q6 <- as.factor(tmp.csv$q6)
str(tmp.csv)

# factor와 number의 연산이 된다?
with(tmp.csv, tapply(q5, q6, sum))



### 
tmp.csv <- read.csv(file.choose())
str(tmp.csv)
head(tmp.csv,10)

tmp.csv$State

# Hawaii 행만 출력하기
# 특정 행을 가져오려면, 조건에 만족하는 행 index 얻어와야 함
# which()

x <- c(2,3,4,5,6,7)
which(x==6)

tmp.csv[which(tmp.csv$State == 'Hawaii'), ]

# switch(data, case 구문, case 구문, case 구문)

user.name <- scan(what = character())
user.name

switch(user.name,
       '섭섭해' = 30,
       '임정섭' = 40,
       '임섭순' = 50)

#
sum(1:10)

# for(변수 in 시퀀스 값){}

for(n in 1:10){
  print(n)
}

user.sum = 0
for(n in 1:10){
  user.sum = user.sum+n
}
user.sum

for(idx in 1:10) {
  cat("idx ->", idx, "\n")
  print(idx*2)
}

for(idx in 1:10) {
  if(idx %% 2 != 0){
    cat(idx, '\t')
  }
}

# 1~100 사이의 홀수/짝수의 합을 출력한다면?
even <- 0
odd <- 0

for(idx in seq(1,100)){
  if(idx %% 2 == 0) {
    even <- even + idx
  }else {
    odd <- odd + idx
  }
}

cat("even = ", even, " odd = ", odd)