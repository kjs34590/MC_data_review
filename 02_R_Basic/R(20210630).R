# 변수의 데이터 타입

# scalar
var.scalar <- 100
str(var.scalar)

# vector
var.vector <- c(1,2,3)
var.vector

# matrix
var.matrix = matrix(1:4, nrow = 2, ncol =2)
var.matrix
var.matrix %*% var.matrix

# array
var.array <- array(1:8, dim=c(2,2,2))
var.array

# list
userInfo <- list(name    = c('임정섭', '임섭순'),
                 address = c('seoul', 'seoul'),
                 tel     = c('010-4603-2283', '010-4603-2283'),
                 age     = c(20, 30),
                 marriage= c(F,T))
userInfo
class(userInfo$name)
userInfo$name[1]
userInfo$name[2]

userInfo$age[1]<-30
userInfo$age

# 새로운 키, 값을 추가한다면?
userInfo$id <- c("jslim", "parksu")
userInfo
str(userInfo)

# 키, 값 삭제
userInfo$id <- NULL
userInfo

# 서로 다른 자료구조 (vector, matrix, array)
lst01 <- list(one = c("one", "two", "three"),
              two = matrix(1:9, nrow = 3),
              three = array(1:12, dim = c(2,3,2)))
lst01
str(lst01)
lst01$one
lst01$two[2,2]
lst01$three[1,3,2]

lst02 <- list(1:5)
lst02[[1]][4]
class(lst02)

# list -> vector
# vector -> list
# 형변환 as.

lst03 <- unlist(lst02)
lst03
lst03[4]
class(lst03)

# lapply() : list, key=value
# sapply() : list, value
?lapply

lst04 <- list(1:5)
lst05 <- list(6:10)

# FUN은 안 써도 됨. 그냥 max로
lapply(X = c(lst04, lst05), FUN = max)
sapply(X = c(lst04, lst05), FUN = max)

result <- lapply(c(2,4,3), function(x) {x*4})
class(result)

result2 <- sapply(c(2,4,3), function(x){x*4})
class(result2)

class(result)
class(unlist(result))

# data.frame

id     <- c(100, 200, 300)
name   <- c("김지수", "지수스", "JESSE")
salary <- c(1000000, 2000000, 3000000)

exDF <- data.frame(ID = id, NAME = name, SALARY = salary)
exDF

# matrix로 데이터프레임 만들기
?matrix

matDF <- matrix(data = c(1, "jslim", 150,
                         2, "jslim", 150,
                         2, "jslim", 150),
                nrow = 3,
                byrow = T)
class(matDF)

matDF <- data.frame(matDF)
matDF$X2

str(matDF)

sampleDF <- data.frame(x=c(1,2,3,4,5),
                       y=c(2,4,6,8,10))
sampleDF
sampleDF$x
sampleDF$y
sampleDF[,2]
sampleDF[1,2]
sampleDF[c(1,3),2]
sampleDF[-1,]

class(sampleDF[-1, c("x","y")])

sampleDF[-1, "x"]
class(sampleDF[-1, "x"])
sampleDF[-1, c("x"), drop=F]
str(sampleDF)

head(sampleDF)

# rownames(), colnames()
colnames(sampleDF) <- c('feature01','featur02')
rownames(sampleDF) <- c('idx01','idx02','idx03','idx04','idx05')
sampleDF

names(sampleDF)
class(names(sampleDF))

tmp.student <- c('John','Mary','Ethan','Dora')
tmp.score <- c(76,82,84,67)
tmp.grade <- c('C','B','B','D')

tmp.class.df <- data.frame(tmp.student, tmp.score, tmp.grade)
tmp.class.df

str(tmp.class.df)
# 행의 개수

# 행/열 이름 변경
rownames(tmp.class.df) <- c('idx01','idx02','idx03','idx04')
colnames(tmp.class.df) <- c('Name','Score','Grade')

# 잠


id     <- c(1,2,3,4,5,6,7,8,9,10)
gender <- c('F', 'M','F', 'M','F', 'M','F', 'M','M','F')
age    <- c(50, 40, 28, 50, 27, 19, 23, 26, 38, 40)
area   <- c('서울','경기','제주','서울','서울','서울','경기','인천','인천', '경기')

# %in%
member.df <- data.frame(id, gender, age, area)
member.df

names(member.df)
member.df[ , names(member.df) %in% c('gender', 'age')]

str(member.df)

member.df$gender <- as.factor(member.df$gender)
member.df$area <- as.factor(member.df$area)
member.df
str(member.df)

levels(member.df$gender)


#
class(iris)
str(iris)

levels(iris$Species)

mean(iris$Sepal.Length)
class(iris$Sepal.Length)

# with(dataset, 표현식), within()
# with(dataset, tapply(vector, factor, func))
# 데이터 프레임 또는 리스트 내에 존재하는 필드에 손쉽게 접근하기
?with

iris
iris

mean(iris$Sepal.Length)
mean(iris$Sepal.Width)

with(iris, { print(mean(Sepal.Length))
             print(mean(Sepal.Width))})

# within은 필드의 값을 수정할 때
x <- data.frame(val=c(1,2,3,4, NA, 5, NA))
x
x <- within(x,
            val <- ifelse(is.na(val), mean(x$val, na.rm = T), val) )
x$val[is.na(x$val)] <- median(x$val, na.rm=T)
x

#
lapply(iris[ , -5], mean)
class(lapply(iris[ , -5], mean))
class(sapply(iris[ , -5], mean))

# vector -> data.frame(as.data.frame())
x <- sapply(iris[ , -5], mean)
x
xx <- as.data.frame(t(x))
xx
class(xx)
xx$Sepal.Length

sapply(iris, class)
str(iris)

iris
# 5.1
iris[1,1]=NA
head(iris)

# setosa 종의 Sepal.length의 평균을 구해서 NA가 있는 값을 대체한다
tmp.mat <- iris
tmp.mat[1,1] <- NA
pos <- tmp.mat$'Species' == 'setosa'
pos

tmp.mat$Sepal.Length[is.na(tmp.mat$Sepal.Length)] <- mean(tmp.mat$Sepal.Length[pos], na.rm=T)
tmp.mat


# 다른 풀이
?split
split(iris$Sepal.Length, iris$Species)$setosa
class(split(iris$Sepal.Length, iris$Species))

iris.sl.median <- sapply(split(iris$Sepal.Length, iris$Species),
                         median,
                         na.rm = T)
iris.sl.median
class(iris.sl.median)

iris <- within(iris,
               {
                 Sepal.Length <- ifelse(is.na(Sepal.Length),
                                        iris.sl.median[Species],
                                        Sepal.Length)
               })
head(iris)

# subset()
# data.frame으로부터 조건 만족하는 행을 추출하여 데이터프레임으로 만드는 것
?subset

x <- 1:5
y <- 6:10

?letters
z <- letters[1:5]

tmp.frm <- data.frame(x,y,z)
tmp.frm

tmp.frm.subset <- subset(tmp.frm, x >= 3)
tmp.frm.subset
class(tmp.frm.subset)

tmp.frm.subset2 <- subset(tmp.frm, y <= 8 & x >= 2)
tmp.frm.subset2
class(tmp.frm.subset2)

tmp.frm.subset3 <- subset(tmp.frm, select = c(x,y))
tmp.frm.subset3
class(tmp.frm.subset3)

# drop은 
tmp.frm.subset4 <- subset(tmp.frm, y <= '8', select = c(x), drop=TRUE)
tmp.frm.subset4
class(tmp.frm.subset4)


# 1,3,5 컬럼을 대상으로 subset하되, 3번 컬럼은 평균 이상만 선택하기
iris
dim(iris)
str(iris)

iris.subset <- subset(iris, 
                      select = c(Sepal.Length, Petal.Length, Species),
                      Petal.Length >= mean(Petal.Length))
iris.subset
str(iris.subset)

