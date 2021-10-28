# EDA(exploratory Data Analysis)
# 탐색적 데이터 분석 (데이터 전처리 + 시각화 + 통계분석)

# 통계분석 위한 가설 수립

# 데이터 전처리
# 1. 데이터 탐색(조회)
# 2. 결측값 처리
# 3. 이상치 발견하고 처리
# 4. 코딩변경(컬럼명 변경, 파생변수), 데이터 조작
# 5. 탐색적 분석을 위한 시각화

# 가설 검증

######
# 연습
library(ggplot2)

midwest.df <- as.data.frame(midwest)
str(midwest.df)
names(midwest.df)

head(midwest.df)

# 전체인구 -> total 변경
# 아시아인구 -> asian 변경
midwest.df <- rename(midwest.df, total = poptotal)
midwest.df <- rename(midwest.df, asian = popasian)

# total, asian 변수를 이용해서 '전체인구대비 아시아 인구 백분율'
# 파생변수 percasian 만들고
# 히스토그램으로 만들어 도시들이 어떻게 분포하는지 보기

midwest.df <- midwest.df %>%
                mutate(percasian = (asian/total)*100)

hist(midwest.df$percasian)

# 3. 아시아 인구 백분율 전체 평균을 구하고 평균을 초과하면 'over',
# 그 외에는 'under'를 부여하는 파생변수 생성

midwest.df <- midwest.df %>%
  mutate(asian_mean_ou = ifelse(
    percasian > mean(percasian), 'over', 'under'
  ))

View(midwest.df)

# 4. mean에 대한 빈도를 확인 -> 막대그래프 시각화

table(midwest.df$mean)

barplot(table(midwest.df$asian_mean_ou))

ggplot(midwest.df, aes(x = mean)) +
  geom_col(col = 'blue', width = .8, fill = 'blue')


# 5. 전체인구대비 미성년 인구 백분율 추가(percyouth)
midwest.df <- midwest.df %>%
  mutate(percyouth = ((total-popadults)/total)*100)

View(midwest.df)

# 6. 미성년 인구 백분율이 가장 높은 상위 5개 지역
mw_percyouth <- midwest.df %>%
  arrange(desc(percyouth))

mw_percyouth[1:5,c('PID','county','state','percyouth')]

# 7. 전체 인구 대비 아시안 인구 백분율 ratio_asian 파생변수 추가
# 하위 10개 지역 state

midwest.df %>%
  mutate(ratio_asian = (asian/total)*100) %>%
     arrange(ratio_asian) %>%
      select(state, county, ratio_asian) %>%
        head(10)


# 8. 미성년자 등급 변수 추가 (gradeyouth)
# 40% 이상 large, 30~40 middle, 30미만 small. 빈도를 시각화

midwest.df <- midwest.df %>%
  mutate(gradeyouth = ifelse(percyouth >= 40, 'large', 
                             ifelse(percyouth >= 30, 'middle', 'small')))

ggplot(midwest.df, aes(gradeyouth)) +
  geom_bar()


####
eda.data <- read.csv('C:/R_STUDY/data/service_data_new_data_eda.csv')
str(eda.data)
dim(eda.data)

# resident2, gender2 범주형 변환하고 두 변수의 분포 확인
eda.data$resident2 <- as.factor(eda.data$resident2)
eda.data$gender2 <- as.factor(eda.data$gender2)
str(eda.data)

class(table(eda.data$resident2, eda.data$gender2))
resident.gender.tbl <- table(eda.data$resident2, eda.data$gender2)

barplot(resident.gender.tbl, 
        legend = row.names(resident.gender.tbl),
        col = c('pink', 'skyblue', 'orange', 'yellow', 'green'))

# ggplot 쓰려면 tbl -> df로 변경해야
resident.gender.df <- as.data.frame(resident.gender.tbl)

resident.gender.df
ggplot(resident.gender.df) +
  geom_bar(aes(x = Var2 ,y = Freq,fill = Var1),
           stat = 'identity',
           position = 'dodge')

# job2, age2 범주형 변환하고 분포 확인
eda.data$job2 <- as.factor(eda.data$job2)
eda.data$age2 <- as.factor(eda.data$age2)
class(table(eda.data$job2, eda.data$age2))
job.age.tbl <- table(eda.data$job2, eda.data$age2)
barplot(job.age.tbl,
        legend = row.names(job.age.tbl))

job.age.df <- as.data.frame(job.age.tbl)

ggplot(job.age.df) +
  geom_bar(aes(x = Var2 ,y = Freq,fill = Var1),
           stat = 'identity',
           position = 'dodge')

# 직업유형에 따른 나이 비율?
ggplot(data = eda.data,
       aes(x=age, fill=job2)) +
  geom_bar()

result <- c(10,20,30,40,50) * 10
print(result[4])


# service_data_visualization_seoul_subway

seoul_sub <- read.csv('C:/R_STUDY/data/service_data_visualization_seoul_subway.csv')

head(seoul_sub)
str(seoul_sub)

# x 축을 평균일 승차인원(AVG_ONEDAY)으로 설정하고
# y 축을 각 노선의 운행횟수(RUNNINGTIMES_WEEKDAYS)로 설정하고
# 평균 혼잡도(AVG_CROWDEDNESS)로 산점도를 그려보자

ggplot(seoul_sub,
       aes(x = AVG_ONEDAY, y = RUNNINGTIMES_WEEKDAYS)) +
  geom_point(aes(col = LINE, size = AVG_CROWDEDNESS))

# x 축 각 노선(LINE)으로 일평균 막대그래프를 만들어보자

ggplot(seoul_sub,
       aes(x = LINE, y = AVG_ONEDAY)) +
  geom_bar(stat = 'identity')


# 데이터 전처리
dataset <- read.csv(file.choose(), header = T)
str(dataset)
head(dataset)
names(dataset)

# 결측값 확인
table(is.na(dataset))
dataset[!complete.cases(dataset), ]

# 결측값 제거 ( caret 패키지 )
dataset.new <- na.omit(dataset)
table(is.na(dataset.new))
str(dataset.new)

# 평균으로 결측값 대체
price <- dataset$price
ifelse(is.na(dataset$price), mean(dataset$price, na.rm = T), price)

# 통계적 방법으로 처리
price.avg <- mean(dataset$price, na.rm = T)
dataset$type <- rep(1:3, 100)
# type : 1 * 1.5 , 2 * 1.0, 3 * 0.5
# 가변수 priceState

dataset %>% mutate(priceState = ifelse(type==1, type*1.5,
                                       ifelse(type==2, type*1, type*0.5)))


# 이상치
str(dataset)
gender <- dataset$gender
range(gender)
table(gender)

gender.subset <- subset(dataset , gender == 1 | gender == 2)
gender.subset$gender <- as.factor(gender.subset$gender)
str(gender.subset)

# 변수의 유형이 연속형이라면
# 어떻게 이상치를 제거할까요?

seq.price <- dataset$price
length(seq.price)
summary(seq.price)
boxplot(seq.price)

# low   whisker : 중앙값 - 1.5 * IQR : 2.2875
# high  whisker : 중앙값 + 1.5 * IQR : 8.2125

dataset <- subset(dataset , seq.price >= 2.2875 & seq.price <= 8.2125)

seq.price <- dataset$price
boxplot(dataset)

# age
summary(dataset$age)

na.age <- na.omit(dataset$age)
sum(is.na(na.age))
table(is.na(na.age))
boxplot(na.age , horizontal = F)


# 리코딩
# 데이터의 가독성을 위해서 연속형변수 -> 범주형

dataset$resident
length(dataset$resident)
range(dataset$resident)

# 1 : 서울 , 2 : 부산 , 3: 광주 , 4: 대전 , 5 : 대구
# dataset$resident.new 추가한다면?

dataset$resident.new[dataset$resident == 1] <- '서울'
dataset$resident.new[dataset$resident == 2] <- '부산'
dataset$resident.new[dataset$resident == 3] <- '광주'
dataset$resident.new[dataset$resident == 4] <- '대전'
dataset$resident.new[dataset$resident == 5] <- '대구'


dataset %>% mutate(resident.new = ifelse(resident == 1, '서울',
                                         ifelse(resident == 2, '부산',
                                                ifelse(resident == 3, '광주',
                                                       ifelse(resident == 4, '대전', '대구')))))

# NA -> 행정수도인 대전
dataset$resident.new <- ifelse(is.na(dataset$resident.new), '대전' , dataset$resident.new)

dataset$job

