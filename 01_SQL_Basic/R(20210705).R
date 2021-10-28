## 조작
# package :: plyr, dplyr
# filter() : 지정한 조건식에 따른 추출
# select() : 열 추출
# mutate() : 열 추가
# arrange() : 정렬
# group_by() :
# summarise() : 

install.packages(c("plyr", "hflights"))
library(plyr)
library(dplyr)
library(hflights)

# hflights :: 휴스턴에서 출발하는 모든 비행기의 이착륙 기록 (2011년)
hflights
str(hflights)
head(hflights)

flight.df <- hflights

#tbl_df() : d.f를 테이블형식으로 변환하는 함수
flight.tbl <- tbl_df(flight.df)
flight.tbl

# filter()로 1월 1일 데이터 추출
?filter
filter(flight.df, Month==1, DayofMonth==1)
View(filter(flight.df, Month==1, DayofMonth==1))

filter(flight.tbl, Month==1|Month==2)

# arrange() 정렬 (기본:오름차순)
arrange(flight.tbl, Month)
arrange(flight.tbl, desc(Month))

select(flight.tbl, Year, Month, DayofMonth)
select(flight.tbl, -c(Year, Month, DayofMonth))
select(flight.tbl, 1:3)
select(flight.tbl, -(Year:DayofMonth))

# 열 추가(파생변수)
# mutate 함수 안에 만들어진 파생변수를, 바로 활용해 다른 파생변수를 만들 수 있다.
mutate(flight.tbl,
       gain <- ArrDelay - DepDelay,
       gain.per.hour <- gain/(AirTime/60))

head(flight.tbl)
View(flight.tbl)

# transform 함수도 있지만, 파생변수 재활용이 불가능하다.
transform(flight.tbl,
          gain <- ArrDelay - DepDelay,
          gain.per.hour <- gain/(AirTime/60)) # 오류

# summarise()
# 출발지연시간 평균 및 합계
?summarise
sum(is.na(flight.df$DepDelay))
summarise(flight.df, 
          delay.avg = mean(DepDelay, na.rm=T),
          delay.sum = sum(DepDelay, na.rm=T))

# group_by
planes.df <- group_by(flight.df, TailNum)
planes.df
str(planes.df)
View(planes.df)

 # 항공기별 요약 통계량 : 평균 비행거리, 평균 도착지연시간
tmp.df <- summarise(planes.df, 
                    count = n(),
                    avgdis = mean(Distance, na.rm=T),
                    avgdel = mean(ArrDelay, na.rm=T),
)
tmp.df

 # 편수가 20 이상이고 거리가 2000 이상인 데이터 추출
delay <- filter(tmp.df,
                count >= 20,
                avgdis >= 2000)

# 단계 1 : group_by
# Year, Month, DayofMonth의 수준별 그룹화
flight.df
step1 <- group_by(flight.df, Year, Month, DayofMonth)
class(step1)
# 단계 2 : select
# Year부터 DayofMonth, ArrDelay, DepDelay 열 선택
step2 <- select(step1, Year, DayofMonth, ArrDelay, DepDelay)

# 단계 3 :summarise
# 평균 연착시간과 평균 출발 지연시간을 구한다
step3 <- summarise(step2, 
                   avgdel.arr = mean(ArrDelay, na.rm=T),
                   avgdel.dep = mean(DepDelay, na.rm=T))
step3

# 단계 4 : filter
# 평균 연착시간과 평균 지연시간의 30분 이상인 데이터만 추출
step4 <- filter(step3,
                avgdel.arr >= 30,
                avgdel.dep >= 30)
step4

# chain 함수 : %>%
# 위 과정을 한번에 쓰기
flight.df %>% 
  group_by(Year, Month, DayofMonth) %>% # 앞의 flight.df가 뒤로 전달되므로, group by 안에 쓸 필요 없음
    select(Year, DayofMonth, ArrDelay, DepDelay) %>%
      summarise(avg.arr = mean(ArrDelay, na.rm =T),
                avg.dep = mean(DepDelay, na.rm=T)) %>%
        filter(avg.arr >= 30 | avg.dep >= 30)
# 함수가 충돌할 수 있으므로, dplyr::select, dplyr::summarise 이런 식으로 명시해주기도 함.

# adply() (array - d.f) / ddply() (d.f - d.f)
# 데이터 분할(split)
# 분할된 데이터에 함수를 적용(apply)
# 결과를 조합(combine)
# 입력값은 배열, 데이터프레임, 리스트 -> 리턴타입 배열, 데이터프레임, 리스트

    # apply 복습
iris
apply(iris[, 1:4], 1 , function(row){
  print(row)
})

# Sepal.Length가 5.0 이상이고
# Species가 setosa인 것들만 가져와 새로운 열(sepal.5.setosa) 추가
iris %>%
  filter(Sepal.Length >= 5.0, 
         Species == "setosa") %>%
    mutate(sepal.5.setosa = 'Y')
##
tmp.setosa <- split(iris, iris$Species)$setosa
class(tmp.setosa)

tmp.filtered <- apply(tmp.setosa, 2, function(x){
                      x >= 5.0
})

class(tmp.filtered)


# adply
adply(iris,
      1,
      function(row){
        data.frame(sepal.5.setosa = c(row$Sepal.Length >= 5.0 &
                                      row$Species == 'setosa'))
      })


# package::plyr
# data.frame
# join() : key값을 기준으로 두 개의 프레임을 병합
# inner join, left join, right join, full join

tmp.x.df <- data.frame(
  id = c(1, 2, 3, 4, 6),
  height = c(160, 175, 180, 177, 194)
)

tmp.y.df <- data.frame(
  id = c(5, 4, 3, 2, 1),
  weight = c(55, 77, 90, 78, 95)
)

library(dplyr)
inner.df <- join(tmp.x.df, tmp.y.df, by='id', type='inner')
inner.df
inner_join(tmp.x.df, tmp.y.df, by='id')



####### 연습문제 #######
library(MASS)
Cars93
str(Cars93)
head(Cars93)
# 컬럼명 확인
names(Cars93)
# distinct 중복 없이 유일한 값 리턴
distinct(Cars93, Origin)

# 문) Cars93 데이터 프레임에서 '차종(Type)'과 '생산국-미국여부(Origin)' 변수를 기준으로 
#     중복없는 유일한 값을 추출하시오.
distinct(Cars93, Type, Origin)

# 문) Cars93 데이터 프레임(1~5번째 변수만 사용)에서 10개의 관측치를 무작위로 추출하시오.
sample_n(Cars93[ , 1:5], 10)

# 문) Cars93 데이터 프레임(1~5번째 변수만 사용)에서 
# 10%의 관측치를 무작위로 추출하시오.
sample_frac(Cars93[ , 1:5], 0.1)

# 문) Cars93 데이터 프레임(1~5번까지 변수만 사용)에서 
# 20개의 관측치를 무작위 복원추출 하시오.
sample_n(Cars93[ , 1:5], 20, replace=T)

# 문) Cars93 데이터 프레임에서 
# '제조국가_미국여부(Origin)'의 'USA', 'non-USA' 요인 속성별로 
# 각 10개씩의 표본을 무작위 비복원 추출하시오.
Cars93[ , c('Manufacturer', 'Model', 'Type', 'Price', 'Origin')] %>%
  group_by(Origin) %>%
    sample_n(10)

# 문) Cars93 데이터프레임에서 
# 최소가격(Min.Price)과 최대가격(Max.Price)의 범위(range), 
# 최소가격 대비 최대가격의 비율(=Max.Price/Min.Price) 의 
# 새로운 변수를 생성하시오.

new.df <- Cars93[c(1:10), c('Manufacturer','Model','Min.Price', 'Max.Price')]
mutate(new.df, 
       Range.Price = Max.Price - Min.Price,
       Range.Price.Rate = Max.Price/Min.Price)

# 문) Cars93 데이터 프레임에서 
# 가격(Price)의 (a) 평균, (b) 중앙값, (c) 표준편차, (d) 최소값, 
# (e) 최대값 합계를 구하시오. 
# (단, 결측값은 포함하지 않고 계산함)
# cf) 표준편차란 : 편차는 데이터 값 - 평균값. 이를 제곱한 값 - 분산.
#                  여기에 제곱근을 하면 표준편차

mean(Cars93$Price, na.rm=T)
median(Cars93$Price, na.rm=T)
sd(Cars93$Price, na.rm=T)

min(Cars93$Price, na.rm=T)
max(Cars93$Price, na.rm=T)

  # summarise로 풀기
summarise(Cars93,
          Price.mean = mean(Price, na.rm=T),
          Price.median = median(Price, na.rm=T),
          Price.sd = sd(Price, na.rm=T),
          Price.var = var(Price, na.rm=T))


# 문) Cars93_1 데이터 프레임에서 
# (a) 총 관측치의 개수, 
# (b) 제조사(Manufacturer)의 개수(유일한 값), 
# (c) 첫번째 관측치의 제조사 이름, 
# (d) 마지막 관측치의 제조사 이름, 
# (e) 5번째 관측치의 제조사 이름은?
exercise.df <- Cars93[c(1:20), c('Manufacturer', 'Model', 'Type')]
exercise.df
summarise(exercise.df,
          total = n(),
          distinct_cnt = n_distinct(Manufacturer),
          first.obs = first(Manufacturer),
          last.obs = last(Manufacturer),
          nth.obs = nth(Manufacturer, 5))

# 문) Cars93 데이터 프레임에서 
# '차종(Type)' 별로 구분해서 
# (a) 전체 관측치 개수, 
# (b) (중복 없이 센) 제조사 개수, 
# (c) 가격(Price)의 평균과 (d) 가격의 표준편차를 구하시오. 
# (단, 결측값은 포함하지 않고 계산함)
str(Cars93)
grouped <- group_by(Cars93, Type)

summarise(grouped,
          total = n(),
          distinct_cnt = n_distinct(Manufacturer),
          price.mean = mean(Price, na.rm=T),
          price.sd = sd(Price, na.rm=T))


# ddply()
?ddply
iris
ddply(iris, 
      .(Species),
      function(sub){
       data.frame(Sepal.Width.mean = mean(sub$Sepal.Length)) 
      })

ddply(iris, 
      .(Species, Sepal.Length>5.0),
      function(sub){
        data.frame(Sepal.Width.mean = mean(sub$Sepal.Length)) 
      })

baseball
str(baseball)

subset(baseball, id=='ansonca01')
filter(baseball, id=='ansonca01')
baseball[baseball$id=='ansonca01', ]

# ddply() 이용해서 각 선수가 출전한 게임수의 평균을 구하면?
names(baseball)
ddply(baseball,
      .(id),
      function(sub){
        data.frame(g.mean=mean(sub$g))
      })

# 각 선수 별로 최다 플레이한 해의 기록을 구한다면?
head(baseball)
View(baseball)
ddply(baseball,
      .(id),
      subset,
      g == max(g))

#
ddply(baseball,
      .(id),
      summarise,
      minyear = min(year),
      maxyear = max(year))

# reshape
# 프레임의 구조를 변경할 때
# melt, cast
library(reshape2)
french_fries
str(french_fries)

head(french_fries)

# melt
# ID, 측정대상 변수, 측정치 값
french_fries.melt <- melt(id = 1:4, french_fries)
View(french_fries.melt)

french_fries.dcast <- dcast(french_fries.melt, time + treatment + subject + rep ~ ...)
class(french_fries.dcast)

french_fries.acast <- acast(french_fries.melt, time + treatment + subject + rep ~ ...)
class(french_fries.acast)

tmp.data <- read.csv(file.choose())
tmp.data
str(tmp.data)
head(tmp.data)
unique(tmp.data$Customer_ID)
length(unique(tmp.data$Customer_ID))

wide <- dcast(tmp.data, Customer_ID~Date , sum)
long <- melt(wide, id='Customer_ID')
long


#
install.packages("data.table")
library(data.table)
# 앞 5건, 뒤 5건을 보여주는 table 형식
iris.table <- data.table(iris)
iris.table

