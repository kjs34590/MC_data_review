# R을 이용한 DBMS 정형 데이터 처리
install.packages('rJava')
install.packages('DBI')
install.packages('RJDBC')

Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jdk1.8.0_121')

library(rJava)
library(DBI)
library(RJDBC)

# DB 연동 순서는?
# Driver loading -> Connection -> Query 수행 -> 결과집합을 처리하는 과정
# Vender Specific 영역을 Driver라고 함

# 1. Driver loading
driver <- JDBC(driverClass = 'oracle.jdbc.driver.OracleDriver',
               classPath   = 'C:\\oraclexe\\app\\oracle\\product\\11.2.0\\server\\jdbc\\lib\\ojdbc6.jar')

# 2. connection
conn <- dbConnect(driver,
                  'jdbc:oracle:thin:@localhost:1521:xe',
                  'hr',
                  'hr')

select.sql <- 'select * from employee'

#dbGetQuery() : select
emp.tbl <- dbGetQuery(conn, select.sql)
str(emp.tbl)

# dbSendUpdate() : DML(insert, update, delete), DDL(create, drop, alter)

create.tbl <- 'create table r_tbl(
  id        varchar2(20) primary key,
  pwd       varchar2(20) not null,
  username  varchar2(50) not null,
  upoint    number       default 100
)'

dbSendUpdate(conn, create.tbl)

# insert
insert.sql <- "insert into r_tbl values('jslim', 'jslim', '섭섭', default)"
dbSendUpdate(conn, insert.sql)

r.tbl <- dbGetQuery(conn, 'select * from r_tbl')
str(r.tbl)

emp.tbl <- dbGetQuery(conn, 'select * from tabs')
str(emp.tbl)
emp.tbl$TABLE_NAME

update.sql <- "update r_tbl
set username = 'admin'
where id = 'jslim'"

# update
dbSendUpdate(conn, update.sql)

# delete
dbSendUpdate(conn, "delete from r_tbl where id = 'jslim'")

###
select.sql <- 'select * from employee'
emp.tbl <- dbGetQuery(conn, select.sql)
str(emp.tbl)

# 파생변수로 gender 추가
library(stringr)
size <- NROW(emp.tbl)
size

 # 1. for 사용
gender <- c()
for(idx in 1:size){
  if(str_sub(emp.tbl$EMP_NO[idx], 8, 8) == 1 | str_sub(emp.tbl$EMP_NO[idx], 8, 8) == 3) {
    gender[idx] = 'M'
  }else{
    gender[idx] = 'F'
  }
}
gender
emp.tbl$gender <- gender

 # 2. elseif 사용
emp.tbl$gender <- ifelse(str_sub(emp.tbl$EMP_NO, 8, 8) == 1 | str_sub(emp.tbl$EMP_NO, 8, 8) == 3, 'M', 'F')
emp.tbl$gender

# 성별에 따른 급여 평균 구하기
library(dplyr)
gender_mean <- emp.tbl %>%
  group_by(gender) %>%
  dplyr::summarise(mean.sal = mean(SALARY))

# 혹은
genderGroupMean <- aggregate(emp.tbl$SALARY,
                             list(emp.tbl$gender),
                             mean)
# 시각화
library(ggplot2)
ggplot(gender_mean, aes(x=gender, y=mean.sal, fill = gender)) +
  geom_bar(stat ='identity')

gender_mean


# 비정형 데이터(텍스트마이닝)
# 단어 빈도를 나타내는 시각화(wc, KoNLP, tm)
?file
dataset <- file(file.choose(), encoding = 'UTF-8')
dataset.read <- readLines(dataset)

str(dataset.read)
head(dataset.read)
dataset.read[1]

# 문장부호, 특수문자, 숫자 제거, 모든 영문자는 소문자로 변경
library(dplyr)
library(plyr)
sentence1 <- gsub("[[:digit:]]", "", dataset.read)
sentence2 <- gsub("[[:punct:]]", "", sentence1)
sentence3 <- gsub("[[:cntrl:]]" , "", sentence2)
sentence4 <- tolower(sentence3)
sentence4

# 문장을 단어로 나눈다면? (공백 정규식)
?str_split
library(stringr)
words <- str_split(sentence4, "\\s+")
words

# list -> vector
word.vec <- unlist(words)
word.vec[1:10]

# 불용어, stopword
# 단어사전 가져오기
pDic <- readLines(file.choose(), encoding = 'UTF-8')
nDic <- readLines(file.choose(), encoding = 'UTF-8')
length(pDic)
length(nDic)


pDic[1:10]
nDic[1:10]

# 단어사전에 단어 추가도 가능하다
pDic <- c(pDic, '지원')

# 감성분석
?laply
# 단어 - 사전 매칭 match()

pMatch <- match(word.vec, pDic)
nMatch <- match(word.vec, nDic)

# 사전에 등록된 단어 추출
pMatched <- !is.na(pMatch)
nMatched <- !is.na(nMatch)

# 긍정단어 합 - 부정단어 합 처리한 후 점수로 반환
scores <- sum(pMatched) - sum(nMatched)
scores

scoresDF <- data.frame(score = scores , text = word.vec)
head(scoresDF)

# 함수화 : data.frame -> score(점수), text(단어)
sentimental.function <- function(words, positive, negative) {
  scores = laply(words, function(words, positive, negative){
  pMatched = match(words, positive)
  nMatched = match(words, negative)
  
  pMatched = !is.na(pMatched)
  nMatched = !is.na(nMatched)
  
  score = sum(pMatched) - sum(nMatched)
  return(score)
  }, positive, negative)
  
  scores.df <- data.frame(score = scores, text = words)
  return (scores.df)
}
sum(!is.na(match(words, pDic)))
class(word.vec)
class(words)
# result type : data.frame
result <- sentimental.function(word.vec, pDic, nDic)
result

# 감성분석 빈도수
result$color[result$score >= 1] <- 'blue'
result$color[result$score == 0] <- 'green'
result$color[result$score < 0] <- 'red'

table(result$color)

# 시각화도 가능하다
result$remark[result$score >= 1] <- '긍정'
result$remark[result$score == 0] <- '중립'
result$remark[result$score < 0] <- '부정'
table(result$remark)

sentimental.pie <- table(result$remark)
class(sentimental.pie)
names(sentimental.pie)

# 시각화
?pie
pie(sentimental.pie, main='감정분석 결과',
    col = c('blue', 'red', 'green'), labels = names(sentimental.pie),
    radius = .8,
    angle = 45)


### 실습 과제 ###
# spss 파일을 위한 패키지 설치
install.packages('foreign')
library(foreign)

dataset.raw <- read.spss(file.choose(), to.data.frame = T)

dataset <- dataset.raw

# 데이터 특성 확인
View(dataset)

# 분석에 필요한 column의 이름을 변경합니다.

gender = h10_g3,         # 성별
birth = h10_g4,          # 태어난 연도
marriage = h10_g10,      # 혼인 상태 
religion = h10_g11,      # 종교
income = p1002_8aq1,     # 월급
code_job = h10_eco9,     # 직업 코드
code_region = h10_reg7  # 지역 코드


dataset <- rename(dataset, 
                  gender = h10_g3,         # 성별
                  birth = h10_g4,          # 태어난 연도
                  marriage = h10_g10,      # 혼인 상태 
                  religion = h10_g11,      # 종교
                  income = p1002_8aq1,     # 월급
                  code_job = h10_eco9,     # 직업 코드
                  code_region = h10_reg7)  # 지역 코드

#################################################

# 1. 성별에 따른 월급 차이
# 그래프로 확인해보자( 확인할 때는 gqplot이용 )

# 0~250만원 사이에 가장 많은 사람이 분포하고 있다.

# 결측치가 12030 존재 => 월급을 받지 않은 응답자.
# 결측치부터 제거해야 한다.
# 또한 값이 0 이거나 무응답에 해당하는 9999는 이상치 처리


# 그래프 그리기
# 해당 결과를 ggplot2를 이용하여 그래프로 표현하자

##########################################

# 2. 나이와 월급의 관계
# 몇 살 때 월급을 가장 많이 받을까? 또 그때의 월급은 얼마인가?
# 월급을 가장 많이 받는 나이는 : 53살 월급 : 318.6777

# 나이에 따른월급을 선 그래프로 표현하자


# 코드북에 따르면 출생연도는 1900~2014이며 무응답은 9999
# 먼저 결측치가 존재하는지 확인

# 이상치를 확인한다.

# 나이를 구해야 하니 파생변수 age를 생성


# 전처리가 끝났으니 이제 나이에 따른 월급의 관계를 분석
# 나이별 평균월급을 구하자


# 가장 월급을 많이 받는 나이는?


# 결과에 대한 선 그래프를 그려보자

# 20초반에는 100만원가량
# 40대부터 50대 중반까지 300만원 으로 가장많은 월급
# 60대 이후로는 급격히 감소하는 추세
# 평균 이상의 월급을 받는 나이는 20대 말에서 60대 초반까지


#################################


# 3. 연령대에 따른 월급 차이
# 30세 미만을 초년(young), 
# 30~59세 : 중년(middle), 
# 60세 이상 : 노년(old)
# 위의 범주로 연령대에 따른 월급의 차이를 알아보자

# 연령대(age_group) column을 조건에 맞게 추가하자


# 연령대별 평균 월급을 구해보자


# 해당 결과를 그래프로 표현하자


# ggplot은 기본적으로 막대변수를 알파벳 순으로 오름차순
# 정렬. 막대가 young, middle, old 순으로 정렬해보자
# scale_x_discrete(limits=c("young","middle","old")) 이용


############################################


# 4. 연령대 및 성별 월급 차이
# 성별 월급 차이는 연령대에 따라 다른 양상을 보일 수 있습니다.
# 성별 월급 차이가 연령대에 따라 다른지 분석해보자

# 기존에는 3그룹(초년,중년,노년)이었지만 이젠 6그룹으로
# 그룹핑을 해야 한다.(초년남성,초년여성,..)


# 그래프로 표현해 보자


# 다르게 표현하면 다음과 같이 표현해도 된다.



# 누적시키지 않고 옆으로 따로 막대를 분리


# 사회초년생일때는 남녀의 월급이 큰 차이가 없지만
# 중년으로 들어서면 월급의 차이가 크게 벌어진다.
# 남성의 경우 초년과 노년의 월급차이가 크지 않다는 것을
# 파악할 수 있다.

##############################################

# 5. 나이 및 성별 월급 차이 분석
# 연령대를 구분하지 않고 나이 및 성별 월급 평균표를 만들어서
# 그래프로 표현해 보자
# 선 그래프로 표현하고 월급 평균 선이 성별에 따라 다른 색으로
# 표현되도록 한다.




