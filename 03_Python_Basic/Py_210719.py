# 지난 시간 복습
for v1 in range(10) :
    print('v1 is ', v1)

print()
for v2 in range(1, 11) :
    print('v2 is ', v2)

print()
for v3 in range(1, 11, 2) :
    print('v3 is ', v3)

print()
scores = []
for i in range(5) :
    scores.append(int(input('점수 입력 : ')))

for element in scores :
    print(element)
print()

for idx in range(len(scores)):
    print(scores[idx], end='\t')
print()
print('scores 총합 평균')
sum = 0
avg = 0
for idx in range(len(scores)) :
    sum += scores[idx]   # sum = sum + scores[i] 와 같다.
print('총합 : ', sum)
print('평균 : ', sum / len(scores))

# 반복구문 (for ~, while)
dogNames = []
isFlag = True

while isFlag :
    name = input('강아지의 이름을 입력하세요(종료 시 엔터 입력) :')
    if name == "" :
        isFlag = False
        # break
    else :
    dogNames.append(name)
print('outer while : ', dogNames)

# while 이용한 guessGame
from random import randint
answer = randint(1, 100)
print('기회는 열 번!')
tries = 1
while tries <= 10 :
    guess = int(input('1 ~ 100 사이의 숫자를 입력하세요 : '))
    if guess == answer :
        break
    elif guess > answer :
        print('DOWN (시도횟수:{})'.format(tries))
    else :
        print('UP (시도횟수:{})'.format(tries))
    tries += 1 # while에서 횟수를 증감시켜주는 행 필요. 없으면 무한 루프
print('정답 {}, 시도횟수 {}'.format(answer, idx))

tmpList = [('name', 'jskim'),('age',20),('address','seoul')]
for key, value in tmpList :
    # print(e)
    print('{}, {}'.format(key, value))

tmpList = [1,2,3,4,5,6,7,8,9]
myList = []
for e in tmpList :
    myList.append(e*2)
print(myList)

myList = [ e * 2 for e in tmpList ]
print(myList)

# 올림픽은 4년마다 개최
# 2000~2050년 사이의 올림픽이 개최되는 연도 출력
# 한 줄에 5개씩 출력
cnt=0
for year in range(2000, 2051, 4) :
    cnt += 1
    if cnt%5 == 0 :
        print(year, end='\n')
    else :
        print(year, end='\t')


# 아래 리스트에서 세 글자 이상만 출력
print()
tmpList =  ['I', 'AM', 'studying', 'PYTHON', 'language', '!']
for e in tmpList :
    if len(e) >= 3 :
        print(e)

# 대문자인 문자만 출력
for e in tmpList :
    if e.isupper() :
        print(e)

# 확장자를 제외하고 파일 이름만 출력
tmpList = ['greeting.py', 'ex01.py', 'intro.hwp', 'bigdata.doc']
for i in tmpList :
    print(i.split('.')[0])

# 구구단
# 출력형식 2 * 1 = 2, 2 * 2 = 4
# 5단 skip
for idx in range(2, 10) :
    if idx == 5 :
        continue
    for i in range(1, 10) :
        print('{} * {} = {}'.format(idx, i, (idx*i)), end='\t')
    print('\n')

# 인덱스 번호와 요소값을 확인할 수 있는 enumerate()
tmpList = ['greeting.py', 'ex01.py', 'intro.hwp', 'bigdata.doc']
for idx, value in enumerate(tmpList) :
    print('{}번째 인덱스이고 값은 {}입니다.'.format(idx, value))

# 분류정확도
answer = [1,0,2,1,0]
predct = [1,0,2,0,0]
acc = 0
for i in range(len(answer)) :
    fit = answer[i] == predct[i]
    # print(int(fit, end='\t'))
    acc += int(fit) * 20
print('분류정확도는 {}%입니다.'.format(acc))

apartments = [['101호','102호'], ['201호','202호'],['301호','302호']]
for row in apartments :
    for col in row :
        print(col)
    print('------')

# function : 사용자 함수 정의하기

from bigdata.study.userFunc import *

printGreeting()
printCoin()

# 호출
# printCoin()
# result = mySum(1,2)
# print('call mySum() -', result)

# msg = returnMsg(10)
print('msg - ', printcoin())

# 변수의 스코프
data = [1,3,5,7,9]
tot = 0

for d in data :
    tot =+ d
print('tot - ', tot)

def totalCalc(data) :
    total = 0
    for d in data :
        total += d
    return total

print(totalCalc(data))


countSum(1,100)

# makeUrl() call
# print('makeUrl call - ', makeUrl('naver'))
# makeUrl() call - List
url = ['naver', 'google', 'samsung']
urlList = makeUrl(url)
print(urlList)

# 입력 문자열을 한줄에 다섯 글자씩 출력하는 print_5Line(line) 함수 작성하기
print_5xn('아이엠어보이유알어걸')

# 숫자로 구성된 리스트를 입력 받아, 짝수들을 추출해 리스트로 반환하는 pickupEven 함수
myList = [3,4,10,23,34,3,6]


result = pickupEven(myList)
print('result - ', result)

argsTupe('kim')
argsTupe('kim', 'lim')
argsTupe('kim', 'lim', 'park')

userStatistic('SUM', 1,2,3,4)
userStatistic('AVG', 1,2,3,4,5)
userStatistic('STD', 1,2,3)

kwargsDict(name='jskim')
kwargsDict(name='jskim', name1='parksu')
kwargsDict(name='jskim', name1='parksu', name2='cho')

personInfo(77, 178, name='jslim', address='seoul', gender='M', age='49')

# 전체 혼합 (tuple, dict)
mixtype(10, 20, 'jskim', 'ksmin', age1 = 28, age2 = 29)

# lambda 함수
# lambda 인자 ; 구현부
# def mulFunc(x, y) :
#   return x*y

lambdaFunc = lambda x, y : x * y
print(lambdaFunc(10, 20))


def func_final(x,y,func) :
    print(">>>> ", x*y*func)

func_final(10, 20, lambda x, y : x * y)

# Hint
def tot_length(word : str, num : int) -> int :
    return len(word) * num

print('hint - ', tot_length('i love you', 10))

def tot_length2(word : str, num : int) -> None :
    return len(word) * num

tot_length2('niceman', 10)


def leay_year_loop(strYear : int, endYear : int) -> list :





