# boolean type
# True | False
# 논리연산자(not, and, or)
# 비교연산자(&, |, ~)
# "", [], (), {}, 0, None -> False

# 32 16 8 4 2 1
a = 5 # 0101
b = 0 # 0000

print('boolean - ', bool(1))
print('bitwise - ', (a&b)) # 둘 다 True ?
print('bitwise - ', bool(a&b)) # 둘 다 True?
print('bitwise - ', bool(a|b)) # 둘 중 하나 True?

tmpList = []
tmpStr = ""
print('list - ', bool(tmpList), bool(tmpStr), bool((1,2)))
# 데이터 유무를 판별할 때, 논리식의 값으로 판별할 수 있다.

trueFlag = True
falsFlag = False

print('True : {} - False : {} '.format(int(trueFlag), int(falsFlag)))
print('and - &', trueFlag and falsFlag, trueFlag & falsFlag)
print('or - |', trueFlag or falsFlag, trueFlag | falsFlag)
print('not', not trueFlag)

# 날짜 ~
'''
install.packages() = conda install ~~
library()
형식) from 패키지명.모듈 import 함수명
형식) from 모듈 import 함수명
형식) import 모듈이름
'''

from datetime import date, datetime
print('type', type(date))

today = date.today()
print('today - ', today, type(today))
print('year month day - ', today.year,'년', today.month,'월',today.day,'일')

user_time = datetime.today()
print('time - ', user_time, user_time.year, user_time.month, user_time.day)
print(user_time.hour, user_time.minute, user_time.second)

# print('today + 1 : ' today+1) --> error

from datetime import date, datetime, timedelta
from dateutil.relativedelta import relativedelta

today = date.today()
days = timedelta(days=-1)
print('어제 날짜 - ', (today+days))

days = relativedelta(days=+14)
print('이틀 뒤 날짜 - ', (today+days))

months = relativedelta(months=-5)
print('두 달 전 날짜 - ', (today+months))


# 특정 날짜 객체를 생성
from dateutil.parser import parse
userDate = parse('2021-7-16')
print('userDate - ', userDate, type(userDate))

today = datetime.today()
print('today - ', today, type(today))

# strftime() : 연-월-일, strptime() : 시-분-초
print('날짜를 문자형식으로 변경 - ', userDate.strftime('%m-%d-%Y'), type(userDate.strftime('%m-%d-%Y')))
print('문자를 날짜형식으로 변경 - ', userDate.strptime('2021-07-16, 10:29:12', '%Y-%m-%d, %H:%M:%S'))



##### 제어문 #####
# if 구문 : python에서는 들여쓰기가 중요
# 블럭을 정의할 때 :
if True : print('pass')
if False : print('pass')
if "" : print('pass')
if [] : print('pass') # 비어 있는 리스트는 False로 본다. 파이썬의 특징!

score = int(input('점수를 입력하세요 : '))
if score >= 60 :
    print('pass')
else :
    print('fail')

# if 조건식 : elif
# 윤년
# 4의 배수이고 100의 배수가 아니거나 400의 배수일 때

year = 2020
if (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0) :
    print('윤년')
else :
    print('평년')

# input()함수를 이용해 연도와 월을 입력받아
# 해당년도가 윤년일 경우 2월의 마지막 일은 29, 평년일 경우 2월의 마지막일은 28일
year_month = [31,28,31,30,31,30,31,31,30,31,30,31]
leap_year_month = [31,29,31,30,31,30,31,31,30,31,30,31]
year = int(input('연도 입력 : '))
month = int(input('달 입력 : '))
if (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0) :
    print('{}년 {}월 말일은 {}일입니다.'.format(year,month,leap_year_month[month-1]))
else :
    print('{}년 {}월 말일은 {}일입니다.'.format(year,month,year_month[month-1]))

# if ~ in 구문
fruits = {'봄':'딸기', '여름':'수박', '가을':'사과','겨울':'귤'}
season = input('계절 입력 : ')
if season in fruits :
    print(fruits.get(season))
else :
    print('정확한 계절을 입력하세요.')


#
grade = 'A'
avg = 91

if grade == 'A' :
    if avg >= 95 :
        print('장학금 100%')
    elif avg >= 90 :
        print('장학금 90%')

# 3항 연산자 : 조건식, 참, 거짓
# 형식 : 변수 = 참 if 조건식 else 거짓
num = 9
if num >= 5 :
    result = num * 2
else :
    result = num + 2
print(result)

result = num*2 if num >= 5 else num + 2
print('result = ', result)

# if ~ in, not in
tmpList = [10, 20, 30]
tmpSet = {70, 80, 90}
tmpDict = {'name' : 'jskim', 'city' : 'ansan', 'gender' : 'M'}
tmpTpl = (10, 12, 14)
print(10 in tmpList)

if 10 in tmpList :
    print('ok')
else :
    print('fail')

if 'name' in tmpDict :
    print('ok')
else :
    print('fail')

if 'jskim' in tmpDict.values() :
    print('ok')
else :
    print('fail')

# 현재 13:22
time = '12:32'
result = '{}시 정각입니다.'.format(time[0:2]) if time[-2: ] == '00' else '{}시 {}분입니다.'.format(time[0:2],time[-2:])
print('time -', result)

# 011 SK, 016 KTF, 019 LGU
# 011-1234-1234
phoneNumber = '011-6610-7063'
dialing = phoneNumber.split('-')[0]

if dialing == '011' :
    print('SK')
elif dialing == '016' :
    print('KTF')
else :
    print('LGU')

# 주민번호 >> 성별 >>
ssn = '930817-1014567'
gender = ssn[7:8]
local = ssn[8:10]
m_ssn = ['1','3']
f_ssn = ['2','4']
loc_seoul = ['00','01','02','03','04','05','06','07','08']
result1 = '' if gender in ['5','6','7','8','9','0'] else '출생지가 서울인' if local in loc_seoul else '출생지가 서울이 아닌'
result2 = '남성입니다.' if gender in m_ssn else '여성입니다.' if gender in f_ssn else '잘못된 주민등록번호입니다.'
print(result1+" "+result2)

ssn = '930817-1084567'
local = int(ssn[8:10])
loc_seoul = range(0,9)
result = '출생지가 서울입니다.' if local in loc_seoul else '출생지가 서울이 아닙니다.'
print(result)

# 1~10 사이의 난수를 생성하고 숫자를 맞혀보는 Guess Game
from random import randint
answer = randint(1, 100)
for i in range(1, 11) :
    guess = int(input('1~100 사이의 숫자를 입력하세요 : '))
    if guess == answer:
        print('{} 정답입니다. (시도횟수:{})'.format(answer, i))
        break
    elif guess > answer:
        print('Down (시도횟수:{})'.format(i))
        i = i+1
    else:
        print('Up (시도횟수:{})'.format(i))
        i = i+1
print('정답은 {}였습니다.'.format(answer))

# 모범답안
answer = randint(1, 100)
print('기회는 열 번!')
tries = 1
for idx in range(1, 11):
    guess = int(input('1 ~ 100 사이의 숫자를 입력하세요 : '))
    if guess == answer :
        break
    elif guess > answer :
        print('DOWN (시도횟수:{})'.format(tries))
    else :
        print('UP (시도횟수:{})'.format(tries))
    tries += 1
print('정답 {}, 시도횟수 {}'.format(answer, idx))

# for, while
# for idx in <collection> :
# for idx in range(start, end, step) :
# for idx in str, dict, list :
endingMsg = 'see you next week'
for char in endingMsg :
    print(char, end=" ")
print()
# 리스트에 있는 요소 cnt
cnt_list = [1,4,2,5,24,52,42,15,25,25,24,62,140,50,24,24,5,1,4,63,44,73,42,61,62,1,4,25]
freq = {}
for i in cnt_list :
    if i in freq :
        freq[i] += 1
    else :
        freq[i] = 1
print('freq - ', freq)

