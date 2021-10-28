library(ggplot2)
library(dplyr)

# 크게 4가지 종류로 분류할 수 있다
#ggplot()
#geom_XXXXXXX (그래프, 도형)
# coord_XXXXXX (옵션)

# ggplot()
# aes(x축변수, y축변수)
# geom_point() : 산점도
# geom_line() : 선 그래프
# geom_boxplot() : 
# geom_histogram()
# geom_bar()

# ggplot() + geom_xxxx() + coord_xxx()

iris
?ggplot
ggplot(data = iris,
       mapping = aes(x = Sepal.Length,
                     y = Sepal.Width)) +
  geom_point(colour = c('red', 'blue', 'green')[iris$Species],
             pch = c(0,2,20)[iris$Species],
             size = c(1,1,5,2)[iris$Species])

# geom_abline(), geom_hline(), geom_vline(), geom_rect(), geom_text()

tmp <- ddply(iris,
             .(Species),
             summarise,
             min_x = min(Sepal.Length),
             max_x = max(Sepal.Length),
             min_y = min(Sepal.Width),
             max_y = max(Sepal.Width)
             )

tmp

start_x <- max(tmp$min_x)
end_x   <- min(tmp$max_x)

start_y <- max(tmp$min_y)
end_y   <- min(tmp$max_y)

# annotate() - 어떤 도형을 그릴
?annotate
annotate()

g <- ggplot(data = iris,
            mapping = aes(x = Sepal.Length,
                          y = Sepal.Width)) +
  geom_point(colour = c('red', 'blue', 'green')[iris$Species],
             pch = c(0,2,20)[iris$Species],
             size = c(1,1,5,2)[iris$Species])
g

# box를 만들어 영역 지정 (겹쳐 보이게)
cat(start_x, end_x, start_y, end_y)

g + annotate(
  geom = 'rect',
  xmin = start_x , 
  xmax = end_x,
  ymin = start_y ,
  ymax = end_y,
  fill = 'red',
  alpha = 0.2,
  colour = 'black',
  lty = 2
)

# 옵션 주기 (축의 범위 변경)
g + coord_cartesian(xlim = c(start_x, end_x),
                    ylim = c(start_y, end_y))

# 라벨 달기
?labs
g + labs(title = '제목',
         subtitle = '부제목',
         caption = '주석',
         x = 'x축 이름',
         y = 'y축 이름')


### 연습
tmp.df <- data.frame(
  years = c(2015, 2016, 2017, 2018, 2019, 2020, 2021),
  gdp = c(300, 350, 400, 450, 500, 550, 600)
)

# 틀 그리고
ggplot(data = tmp.df,
       aes(x = years, y = gdp)) +
  geom_point(colour = 'red',
             pch = 2,
             size = 4) + # 점 그리고
  geom_line(linetype = 'dashed') # 선 그리기


### 연습 2 (gcookbook)
install.packages('gcookbook')
library(gcookbook)
uspopage
str(uspopage)

 # geom_area
?geom_area
ggplot(uspopage,
       aes(x = Year, y = Thousands, fill=AgeGroup)) +
  geom_area(colour = 'white',
            size   = 1,
            alpha  = .6)

 # geam_bar (막대그래프)
ggplot(uspopage,
       aes(x = Year, y = Thousands, fill=AgeGroup)) +
  geom_area(colour = 'white',
            size   = 1,
            alpha  = .6)

 # 히스토그램과 막대 차트의 차이? : 
 # 히스토그램은 양적 데이터. 막대의 너비가 질량, 즉 계급의 폭을 나타냄
 # 막대 그래프의 너비는 질량이 아닌, 범주를 의미함
 # 아래는 막대그래프 실습
?geom_bar

tmp.df <- data.frame(
  movies = c('강철비2', '발신제한', '아바타', '크루엘라', '루카'),
  cnt    = c(5, 11, 3, 8, 10)
)
str(tmp.df)

 # x축, y축을 그릴 때
ggplot(tmp.df,
       aes(x = movies, y = cnt)) +
  geom_col(col = 'blue', width = .4, fill = 'red') +
  ggtitle('bar chart')

 # x축만 이용(factor type)
library(MASS)
ggplot(Cars93,
       aes(x = Type)) +
  geom_bar()
Cars93

# dataframe을 sql로 구현하는 라이브러리
install.packages('sqldf')
library(sqldf)

head(Cars93, 10)
names(Cars93)

type.cnt <- sqldf('select Type, count(*) as cnt
      from Cars93
      group by Type
      order by Type')
class(type.cnt)
str(type.cnt)

ggplot(data = type.cnt,
       aes(x = Type, y = cnt)) +
  geom_bar(stat = 'identity', fill = 'yellow', col = 'orange') + 
  ggtitle('bar chart using type')

# Stacked Bar chart
# 학급의 총인원과 남학생/여학생 수를 하나의 그래프에 누적하기
class.num <- c(1,2,3,4,5,6)
class.m   <- c(30, 20, 24, 37, 43, 23)
class.f   <- c(20, 18, 38, 32 ,34, 45)

tmp.cls.df <- data.frame(class.num, class.m, class.f)

  # reshape2 : melt, cast(dcast, acast)
library(reshape2)
?melt

cls.melt.df <- melt(tmp.cls.df,
                    id = c('class.num'))
cls.melt.df

ggplot(data = cls.melt.df,
       aes(x = class.num, y = value, fill = variable)) +
  geom_bar(stat = 'identity', width = .6)

# multi bar
# position = dodge
ggplot(data = cls.melt.df,
       aes(x = class.num, y = value, fill = variable)) +
  geom_bar(stat = 'identity', 
           position = position_dodge(width = .6))


# Cars93 차종(Type)별 제조국(Origin) 자동차 수를 막대그래프로
library(MASS)
Cars93
ggplot(Cars93,
       aes(x = Type, fill = Origin)) +
  geom_bar(position = position_dodge(width = .4)) +
    ggtitle('USA/non-USA Cars by Types(multi bar)')


# 막대그래프에 오차막대 추가하기
# 오차 : 신뢰도를 벗어나는
# geom_errobar()

letters[1:5]
sample(seq(4,15),5)
sd = c(1,0,2,3,4)

tmp.avg.df <- data.frame(
  name = letters[1:5],
  value = sample(seq(4,15),5),
  sd = c(1,0,2,3,4)
)

ggplot(tmp.avg.df) + 
  geom_bar(aes(x = name, y = value),
           stat = 'identity',
           fill = 'skyblue',
           width = 0.8) +
  geom_errorbar(aes(x=name, ymin = value - sd, ymax = value + sd),
                width = 0.6,
                col = 'orange',
                alpha = .8,
                size = .8)

iris.df <- iris
data <- select(iris.df, Species, Sepal.Length)
data <- iris %>% select(Species, Sepal.Length) # 윗줄과 동일!

# 평균, 표준편차 열 추가
# 표준오차
# 신뢰구간(Confidence Interval, CI : 95~99%)

# 뭐가 틀렸지?
data.ms <- data %>%
  group_by(Species) %>%
     dplyr::summarise(cnt = n(),
               mean = mean(Sepal.Length),
               sd = sd(Sepal.Length)) %>%
    mutate(se = sd / sqrt(cnt)) %>%
    mutate(ic = se * qt((1-0.05)/2 + .5 cnt-1))

data.mean.sd <- data %>% 
  group_by(Species) %>%
  dplyr::summarise(cnt  = n() , 
                   mean = mean(Sepal.Length) , 
                   sd   = sd(Sepal.Length)) %>%
  mutate( se = sd / sqrt(cnt) ) %>%
  mutate( ic = se * qt( (1-0.05)/2 + .5 , cnt-1) )

ggplot(data.mean.sd) +
  geom_bar(aes(x = Species, y = mean),
           stat = 'identity',
           fill = 'green',
           alpha = 0.5) +
  geom_errorbar(aes(x=Species, ymin = mean-sd, ymax = mean+sd))+
  ggtitle('using standard deviation')

str(data.ms)


# 히스토그램 vs 막대그래프
#  양적자료        범주
# 히스토그램 : 도수분포를 표현한다.
# 가로축 -> 계급, 세로축 -> 도수
# geom_histogram()
# rnorm() : 정규분포난수

hist.df <- data.frame(
  gender = factor(rep(c('F','M'), each = 200)),
  weight = round(c(rnorm(200, mean = 55, sd =5), rnorm(200, mean = 65, sd = 5)))
)
hist.df

ggplot(hist.df) +
  geom_histogram(aes(x=weight, fill = gender))

ggplot(hist.df) +
  geom_histogram(aes(x=weight, fill = gender),
                 bins = 20,
                 binwidth = 5)


# 산점도
# geom_point()

tmp.df <- data.frame(
  years = c(2015, 2016, 2017, 2018, 2019, 2020, 2021),
  gdp = c(300, 350, 400, 450, 500, 550, 600)
)

ggplot(data = tmp.df,
       aes(x = years, y = gdp)) + # 틀 만들기
  geom_point(shape = 24, size = 4, color = 'red')

# 그룹명 라벨링하기
rownames(tmp.df) <- letters[1:7]

ggplot(data = tmp.df,
       aes(x = years, y = gdp)) + # 틀 만들기
  geom_point(shape = 24, size = 4, color = 'red') +
  geom_text(label = rownames(tmp.df))


# plot에 라벨링된 그룹명 색깔로 구분하기
tmp.df <- cbind(tmp.df , 
                gender = c('F', 'M', 'M', 'M', 'M', 'F', 'F'))

ggplot(data = tmp.df,
       aes(x = years, y = gdp, shape = gender, color=gender)) + # 틀 만들기
  geom_point(size = 4, color = 'red') +
  geom_text(label = rownames(tmp.df))

# boxplot
# boxplot의 박스는 정규분포의 중위수 기준 50%, 즉 1분위~3분위수. 

weight1 <- c(56, 67, 42, 48, 55, 61, 52, 39,
             47, 58, 50, 40, 59, 62, 44, 57, 129)
weight2 <- c(78, 34, 37, 72, 58, 
            68, 27, 55, 65, 40, 75, 33, 66, 116)

data1 <- data.frame(weight = weight1, 
                    num = as.factor(rep(1,17)))
data1

data2 <- data.frame(weight = weight2,
                    num = as.factor(rep(2,14)))
data2

data3 <- rbind(data1, data2)
data3

ggplot(data = data3) + 
  geom_boxplot(aes(x = num, y = weight),
               outlier.color = 'red', outlier.shape = 23,
               outlier.size = 4) +
  coord_flip() # 가로-세로축 변경

# dotplot
ggplot(data = data3, aes(x = num, y = weight)) + 
  geom_boxplot(outlier.color = 'red', outlier.shape = 23,
               outlier.size = 4) +
  geom_dotplot(binaxis = 'y',
               stackdir = 'center',
               dotsize = .8)

# jitter : 겹쳐지지 않게 흩어서 표시해줌
ggplot(data = data3, aes(x = num, y = weight)) + 
  geom_boxplot() +
  geom_jitter(shape = 16)


### Word Cloud
## KoNLP
install.packages('wordcloud2')
library(wordcloud2)

str(demoFreq)

# 기본
wordcloud2(demoFreq,
           size = 1.6,
           color = 'random-light',
           backgroundColor = 'black')

# 저장하기 (html, image파일 등)
install.packages('webshot')
install.packages('htmlwidgets')

library(webshot)
library(htmlwidgets)

myhtml <- wordcloud2(demoFreq,
                     size = 1.6,
                     color = 'random-light',
                     backgroundColor = 'black')
saveWidget(myhtml, 'tmp.html', selfcontained = F)
webshot::install_phantomjs()
webshot('tmp.html',
        'tmp.pdf',
        delay = 5,
        vwidth = 480,
        vheight = 480)


### Google 개발자 도구에서 Google Map API 키 받기
