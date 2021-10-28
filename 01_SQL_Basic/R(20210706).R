# 외부파일(csv, xsl, txt) & 데이터 가공 & 시각화

library(readxl)
tmp.xl <- read_excel("C:/R_STUDY/data/service_data_tap_ex.xlsx")
class(tmp.xl)
View(tmp.xl)
tmp.xl.df <- as.data.frame(tmp.xl)

tmp.txt <- read.table(file.choose(),
                      header = T,
                      nrows = 7,
                      sep = "\t")
class(tmp.txt)
tmp.txt


tmp.txt <- read.table("C:/R_STUDY/data/service_data_tap_ex2.txt",
                      header = T,
                      nrows = 7,
                      sep = "\t")

tmp.txt <- read.table("C:/R_STUDY/data/service_data_tap_ex2.txt")
tmp.txt

### 여기부터 못들음
# 컬럼 네임
colname <- c(id = ,  )
colnames()

# 저장하기
write.csv()

### 데이터 불러와 가공하고 실습하기
# 불러오기
ex_data <- read.

# 데이터 프레임으로
as.data.frame(ex_data)

# 성별과 지역을 factor로
factor()
nlevels()

# 성별에 따른 AMT_17 평균과 지역에 따른 CNT_17 (chain과 split 각각 이용)

#


# 1. colRename 데이터 세트에서 ID 변수만 추출

# 2. colRename 데이터 세트에서 ID, AREA, Y17_CNT 변수 추출

# 3. colRename 데이터 세트에서 AREA 변수만 제외하고 추출

# 4. colRename 데이터 세트에서 AREA, Y17_CNT 변수를 제외하고 추출

# 5. colRename 데이터 세트에 AREA(지역)가 서울인 경우만 추출

# 6. colRename 데이터 세트에서 AREA(지역)가 서울이면서 
#    Y17_CNT(17년 이용 건수)가 10건 이상인 경우만 추출 

# 7. colRename 데이터 세트의 AGE 변수를 오름차순 정렬

# 8. colRename 데이터 세트의 Y17_AMT 변수를 내림차순 정렬


# 정렬 중첩 
# 9. colRename 데이터 세트의 AGE 변수는 오름차순, Y17_AMT 변수는 내림차순 정렬

# 데이터 요약하기
# 10. colRename 데이터 세트의 Y17_AMT(17년 이용 금액) 변수 값 합계를
# TOT_Y17_AMT 변수로 도출


# 11. colRename 데이터 세트의 AREA(지역) 변수 값별로 
# Y17_AMT(17년 이용 금액)를 더해 SUM_Y17_AMT 변수로 도출

# 12. colRename 데이터 세트의 AMT를 CNT로 나눈 값을 
# colRename 데이터 세트의 AVG_AMT로 생성

# 13. colRename 데이터 세트에서 AGE 변수 값이 50 이상이면 “Y”
# 50 미만이면 “N” 값으로 colRename 데이터 세트에 AGE50_YN 변수 생성 


# ::나이분류
# 14. colRename 데이터 세트의 
# AGE 값이 50 이상이면 “50++”, 
# 40 이상이면 “4049”
# 30 이상이면 “3039”, 
# 20 이상이면 "2029”, 
# 나머지는 “0019”를 값으로 하는 AGE_GR10 변수 생성


m.history.df <- read_excel("C:/R_STUDY/data/service_data_excel_m_history.xlsx")
f.history.df <- read_excel("C:/R_STUDY/data/service_data_excel_f_history.xlsx")

m.f.history.df <- rbind(m.history.df, f.history.df)

m.f.history.df %>%
  group_by(AREA) %>%
  dplyr::summarise(SUM_Y17_AMT=sum(AMT17))

library(descr)

freq(m.f.history.df$AREA)
freqGender <- freq(m.f.history.df$SEX, plot = T)

barplot(freqGender)

# 시각화
# 변수 구분(이산 vs 연속)
# 이산변수 : 명목변수, 순위변수
# 막대, 점, 파이 plot

chart.data <- c(380, 520, 330, 390, 320, 460, 300, 405)
names(chart.data) <- c("2020 1Q", "2020 2Q", "2020 3Q", "2020 4Q", "2021 1Q", "2021 2Q", "2021 3Q", "2021 4Q")

chart.data
range(chart.data)
max(chart.data)
min(chart.data)
length(chart.data)

# 막대 차트 (세로, 가로)
?barplot
barplot(chart.data, 
        xlim = c(0,600),
        col = rainbow(8),
        main = '2020 vs 2021',
        horiz = T,
        ylab = '연도별 현황',
        xlab = '매출 현황')

# 도트 차트
?dotchart

dotchart(chart.data,
         color = c("green", "red"),
         lcolor = 'black',
         pch = 1:3,
         xlab = '매출액',
         cex = .8)

?pie
pie(chart.data,
    labels = names(chart.data),
    border = 'blue',
    cex = 1.8)

iris
pie(table(iris$Species))

barplot(table(m.f.history.df$SEX),
        names = c('남자', '여자'),
        main = '성별')

# 연속형 : 변수가 연속된 구간을 가지고 있다
# 간격변수, 비율변수
# 상자, 히스토그램, 산점도
# boxplot(), hist(), plot()

?boxplot

boxplot(m.f.history.df$Y17_CNT, m.f.history.df$Y16_CNT)

iris
hist(iris$Sepal.Length,
     xlab = '꽃받침 길이',
     ylim = c(0,40))

# 산점도
?plot
x <- runif(5, min = 0, max = 1)
y <- x^2
x

plot(x, y, type = 'l')
plot(x, y, type = 'o')
plot(x, y, type = 'h')
plot(x, y, type = 's')

# pairs
?pairs
pairs(iris[1:4])

# 3차원 산점도
install.packages('scatterplot3d')
library(scatterplot3d)

scatterplot3d(iris$Sepal.Length,
              iris$Petal.Length,
              iris$Sepal.Width, type = 'p',
              color = 'red')

# 시각화 알아보기

install.packages('mlbench')
library(mlbench)
str(ozone)
data(Ozone)
Ozone
?Ozone

# 수치형 데이터 산점도
plot(Ozone$V8, Ozone$V9)

# 축 이름 넣기
range(Ozone$V8, na.rm = T)
plot(Ozone$V8, Ozone$V9,
           xlab = 'sandburg Temp',
           ylab = 'EI Monte Temp',
           main = 'Region Temp',
     pch = '+',
     cex = 0.5,
     col = 'red',
     xlim = c(20,100),
     ylim = c(25,85))

iris
summary(iris)

# IQR(3사분위-1사분위수)
summary(iris$Sepal.Width)
boxplot(iris$Sepal.Width)
# 3 -> 3.3
# 1 -> 2.8
# m -> 3
# whisker?
# low whisker : median - 1.5 * IQR : 2.25
# high whisker : median + 1.5 * IQR : 3.75

boxplot(iris$Sepal.Width,
        horizontal = T)

# iris의 setosa 종과 versicolor 종의 Sepal.Width에 대한 박스플롯
# subset()
