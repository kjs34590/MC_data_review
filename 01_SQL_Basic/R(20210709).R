# 실습
library(readxl)
dataset.raw <- read_excel("C:/R_STUDY/data/service_data_exec_eda.xlsx")
str(dataset.raw)

dataset.df <- as.data.frame(dataset.raw)
str(dataset.raw)

# 주소, 상호 -> 서울시에 있는 어느 지역
address <- dataset.df$소재지전체주소
class(address)

# (벡터는 인덱싱이 가능) 동을 확인하고 싶다면?
# 정규표현식 사용
address[1]

address.trim.num <- gsub('[0-9]', "", address)
address.trim.num
address.trim.space <- gsub(' ', "", address.trim.num)
address.trim.space

# 동별 업소의 개수 세기 (빈도 - table() 함수)
?table

library(dplyr)
address.tbl.df <- address.trim.space %>%
  table() %>%
    data.frame()

address.tbl.df

install.packages('treemap')
library(treemap)

treemap(address.tbl.df, 
        index = ".",
        vSize = 'Freq',
        title = '동별 분포표')

arrange(address.tbl.df, desc(Freq)) %>%
  head(10)

# 동별 가게 분포 확인하기
library(stringr)
str_extract(dataset.df$소재지전체주소, '[가-힣]+동|[가-힣]+로')

dong.vec <- str_extract(dataset.df$소재지전체주소, '[가-힣]+동|[가-힣]+로')
dong.df <- as.data.frame(table(dong.vec))
str(dong.df)

treemap(dong.df, 
        index = "dong.vec",
        vSize = 'Freq',
        title = '동별 분포표')

arrange(dong.df, desc(Freq)) %>%
  head(10)

# 실습
# 미세먼지 비교 및 지역별 차이 확인
# 서울시의 구별 미세먼지
dust.dataset.raw <- read_excel("C:/R_STUDY/data/dustdata.xlsx")
View(dust.dataset.raw)
str(dust.dataset.raw)
dust.dataset.df <- as.data.frame(dust.dataset.raw)
dust.dataset.df
dust.dataset.df$area

# 동작구, 서초구 데이터만 추출

dust.dataset.df %>%
  filter(area=='동작구'|area=='서초구')

# %in% 써도 된다
dataset <- dust.dataset.df %>%
  filter(area %in% c('동작구', '서초구'))

# yyyy-mm-dd에 따른 데이터의 수 파악

count(dataset, yyyymmdd)
count(dataset, area)

# 동작구, 서초구 각각의 subset 만들기
dongjak.df <- subset(dataset, area =='동작구')
seocho.df <- subset(dataset, area == '서초구')

dongjak.df
seocho.df

# describe() : 기초 통계량 함수
library(psych)
describe(dongjak.df)
describe(seocho.df)

# 시각화
# barplot()
ggplot(dataset,
       aes(x = yyyymmdd, y = finedust, 
           col = area, group = area)) +
  geom_line() +
  geom_point()

ggplot(dataset,
       aes(x = substr(yyyymmdd, 1, 4), y = finedust, 
           col = area, group = area)) +
  geom_boxplot()

# 혹은
boxplot(dongjak.df$finedust,
        seocho.df$finedust,
        xlab = 'AREA',
        ylab = 'FINEDUST',
        main = '동작구 vs 서초구',
        col = c('skyblue', 'pink'),
        names = c('동작구', '서초구'))
