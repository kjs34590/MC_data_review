# PACKAGE -> 함수(FUNCTION) + 데이터셋(DATASET)
# install.packages('해당패키지')
# library('해당패키지')
# 디버깅 print(), sprintf(), paste(), cat()
# ?print

print(letters)

print(LETTERS)

month.abb

month.name

print('하이')
print('지수')

?sprintf

sprintf("%d", 123)
sprintf("Number : %d", 123)
sprintf("Number : %d, String : %s", 124, 'hello')

?paste

paste('a', 'b', 'c', sep='-')

name = 'jskim'
name <- 'jskim'

myFunc <- function(){
  total <- 0
  cat('append ... ')
  # print('append ... ')
  for(i in 1:10) {
    total <- total + i
    cat(i, "...")
    #print(i)
  }
  cat("End!!", "\n")
  # print("End!!")
  return (total)
}

myFunc()

# 변수 : 데이터를 담을 수 있는 그릇
# 변수명 : (알파벳, 숫자, _ ) 반드시 첫 글자는 문자 또는 
# 단일형 변수 : vector, matrix, array
# 복수형 변수 : list, data.frame

#vector(정수형, 실수형, 문자형, 논리형)
# c()
sampleVec <- c(1,2,3,4,5)
class(sampleVec)

sampleVec <- c(1,2,3,4,"5")
sampleVec
class(sampleVec)

x <- c(0,1,4,9,16)
x

avg <- sum(x) / length(x)
avg

mean(x)

x <- 1:10
x
y <- x^2
y

plot(x, y)

# 상관계수
cor(x, y)

# 변수의 데이터형을 확인하려면
typeof(x)
class(x)

# 논리형 벡터
ex_vec <- c(TRUE, FALSE, TRUE, FALSE)
typeof(ex_vec)
mode(ex_vec)

str_vec <- c('김지수')
typeof(str_vec)
mode(str_vec)
str(str_vec)

sample_na_vec <- NA
print(sample_na_vec)
is.na(sample_na_vec)

sample_null_vec <- NULL
print(sample_null_vec)
is.null(sample_null_vec)

over_vec = c(1,2,3, c(1,2,3, c(1,2,3)))
over_vec
typeof(over_vec)
mode(over_vec)
str(over_vec)
class(over_vec)

# 수치형 벡터 데이터를 만들 때 start:end 형태로
x <- 1:10
x

# 반복된 값의 벡터를 만든다면
?rep
rep(1:5, 5)
rep(1:5, each=5)

?seq
seq(1, 10, 2)
seq(1, 10, length.out = 5)

ex_seq_vec <- seq(1, 100, by = 3)
ex_seq_vec

length(ex_seq_vec)

# indexing 할 수 있다
ex_seq_vec[2]
ex_seq_vec[length(ex_seq_vec)-4]
ex_seq_vec[ex_seq_vec >= 10 & ex_seq_vec <= 30]

# 문제) ex_seq_vec 인덱스가 홀수번째인 값 추출
ex_seq_vec_odd <- ex_seq_vec[seq(1,length(ex_seq_vec), 2)]
ex_seq_vec_odd

ex_seq_vec[seq(1,length(ex_seq_vec), 2)][ex_seq_vec_odd>=10&ex_seq_vec_odd<=30]
ex_seq_vec[ex_seq_vec>=10&ex_seq_vec_odd<=30][seq(1,length(ex_seq_vec), 2)]

str(seq(1, length(ex_seq_vec),2))

# 벡터의 각 셀에 이름을 부여할 수 있다.
x <- c(1,3,5)
col <- c('feature01', 'feature02', 'feature03')
names(x) <- col
x['feature02']
x
x[c(1,3)]
x[1:2]
x[c('feature01', 'feature02')]

# 음수 인덱스를 사용해 특정 요소만 제외할 수 있다.
x[-2]
x[c(-1,-3)]

# 길이 length(), nrow(), NROW()
length(x)
# 소문자 nrow는 matrix에서 쓰는 것(테이블)
nrow(x)
NROW(x)

# 벡터의 연산 %in% - 어떤 값이 벡터에 포함되는지 알려준다
a_vec <- 'a' %in% c('a','b','c')
a_vec
a_vec <- 'f' %in% c('a','b','c')
a_vec

# setdiff() 차집합, union() 합, intersect 교, setequal
setdiff(c("a","b","c"), c('a','b'))
union(c("a","b","c"), c('a','b'))
intersect(c("a","b","c"), c('a','b'))
setequal(c("a","b","c"), c('a','b','c'))

# 100에서 200으로 구성된 벡터 sampleVec 생성 후
# 아래 문제 풀기

sampleVec <- seq(100,200,1)
sampleVec

# 01 인덱스 10번째 값
sampleVec[10]

# 02 끝에서 10개의 값 잘라내기
sampleVec[sampleVec > (sampleVec[91])]
tail(sampleVec, 10)

# 03 홀수만 출력
sampleVec[sampleVec %% 2 == 1]

# 04 3의 배수만 출력 (%% 나머지 연산자)
sampleVec[sampleVec %% 3 == 0]

# 05 앞에서 20개 값 잘라낸 후 변수 d.20
d.20 <- head(sampleVec,20)
d.20

# 06 d.20의 5번째 값을 제외한 나머지 값들 출력
d.20[c(-5)]
d.20

# 07. d.20의 5,7,9번째 값을 제외한 나머지 출력
d.20[c(-5, -7, -9)]

?month.name
absent <- c(10, 8, 14, 15, 8, 10, 15, 12, 9, 7, 8, 7)
names(absent) <- month.name
absent

# 5월의 결석생 수
absent['May']

# 7월, 9월 결석생 수
absent[c('July', 'September')]

# 상반기 결석생 수 합계
sum(absent[1:6])
# 슬라이싱은 인덱스로만 가능하다.
# 이름으로는 열거해야 한다.

# 하반기 결석생 수 평균
mean(absent[7:12])


# 문자형 벡터
c('a', 'b', "c")
strVec <- c("H","s","T","N","O")
strVec[3] > strVec[5]

paste("May I","help u?")

month.abb
paste(moth.abb , 1:12)

paste(month.abb, 1:12, c("st","nd","rd",rep("th",9)))

paste("/user", "local","bin")
paste("/user", "local","bin",sep="/")
paste("/user", "local","bin",sep="")


# [정규표현식(regular expression)]

# *  0 or more.
# +  1 or more.
# ?  0 or 1.
# .  무엇이든 한 글자를 의미
# ^  시작 문자 지정 
# ex) ^[abc] abc중 한 단어 포함한 것으로 시작
# [^] 해당 문자를 제외한 모든 것 ex) [^abc] a,b,c 는 빼고
# $  끝 문자 지정
# [a-z] 알파벳 소문자 중 1개
# [A-Z] 알파벳 대문자 중 1개
# [0-9] 모든 숫자 중 1개
# [a-zA-Z] 모든 알파벳 중 1개
# [가-힣] 모든 한글 중 1개
# [^가-힣] 모든 한글을 제외한 모든 것
# [:punct:] 구두점 문자, ! " # $ % & ’ ( ) * + , - . / : ; < = > ? @ [ ] ^ _ ` { | } ~.
# [:alpha:] 알파벳 대소문자, 동등한 표현 [A-z]
# [:lower:] 영문 소문자, 동등한 표현 [a-z]
# [:upper:] 영문 대문자, 동등한 표현 [A-Z].
# [:digit:] 숫자, 0,1,2,3,4,5,6,7,8,9,
# [:xdigit:] 16진수  [0-9A-Fa-f]
# [:alnum:] 알파벳 숫자 문자, 동등한 표현[A-z0-9].
# [:cntrl:] \n, \r 같은 제어문자, 동등한 표현[\x00-\x1F\x7F].
# [:graph:] 그래픽 (사람이 읽을 수 있는) 문자, 동등한 표현
# [:print:] 출력가능한 문자, 동등한 표현
# [:space:] 공백 문자: 탭, 개행문자, 수직탭, 공백, 복귀문자, 서식이송
# [:blank:] 간격 문자, 즉 스페이스와 탭.


# grep
?grep

strVec <- c("gender", "height", "age", "weight", "eight")

grep("^ei", strVec, value = T)
grep("EI" , strVec, ignore.case = T, value = T)

grep("^ei", strVec, value = T)

# ei라는 문자열이 있는 요소 추출

grep("ei", strVec, value=T)
grep("+ei+", strVec, value=T)
strVec[grep('ei', strVec)]

txtVec <- c("BigData", "Bigdata", "bigdata", "Data", "dataMining", "class1", "class2")

# 소문자 b로 시작하는 데이터 추출
grep("^b+", txtVec, value=T)
grep('^b+', txtVec, value=T, ignore.cas = T)

#gsub()
# big 문자열이 있는 요소를 찾아 bigger로
?gsub
?sub

gsub("big", "bigger", txtVec, ignore.case = FALSE)

# 숫자 제거하기
gsub("[0-9]", "", txtVec)
gsub("[[:digit:]]", "", txtVec)


