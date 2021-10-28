### 파이썬 1일차
# 출력함수
print('Hello World')

'''
This is a multi-line comment
'''
print('''
You can print it
like this''')

# Tip : 한번에 주석잡기 : 블럭잡고 Ctrl + /
# 가나다라
# 마바사
# 아자차카

# print() : sep, end
print('010','6610','7063', sep='-')
print('P','Y','T','H','O','N', sep='')

print('Welcome To', end=' ')
print("PYTHON")

# format (d, s, f)
print('{} and {}'.format('one', 'two'))

print('{2} {0} {1}'.format('one','two', 'three'))

print('%s %d' %('one', 100))

print('%s이 뭐니?' %('이름'))

# 자리수 지정
print('%10s' % 'seop')
print('%-10s' % 'seop')
print('%12s' % 'pythonGood') # %12는 총 12칸을 출력한다는 뜻. string 글자수가 그보다 적으면 나머지는 공백으로

print('%d' % 100)
print('%10.4f' % 3.141592) # '.' 포함 10칸 출력하는데, number에서 소수점아래 4자리를 가져오고, 남는 자리는 공백으로

print('{:>10}'.format('nice'))
print('{:_>10}'.format('nice'))
print('{:$>10}'.format('nice'))
print('{:10}'.format('nice'))

# 중앙정렬
print('{:^10}'.format('nice'))

# 절사
print('%.5s' % 'pythonstudy')
print('{:15.5}'.format('pythonstudy'))
print('{:.5}'.format('pythonstudy'))
print('%4d' % 42)
print('{:.4}'.format(42.124))

# 변수 Variable
'''
Built-In Types
- Numeric
- Sequence
- Text Sequence
- Set
- Mapping(dict , tuple)
- Boolean
- Class(Object Oriented Programming)
변수 지정방법
- Camel  Case -> function , method (ex numberOfCollege)
- Pascal Case -> class (ex NumberOfCollege)
- Snake  Case -> variable , method , function (ex number_of_college)
주의사항
변수는 숫자로 시작할 수 없다
허용되는 특수문자 _ , $
예약어는 변수명으로 사용이 불가
'''
year  = 2021
month = 7
day   = 14

print('{}년 {}월 {}일'.format(year , month , day))
print(type(year) , type(month) , type(day))

import keyword
print(keyword.kwlist)


intValue   = 123
floatValue = 3.14
boolValue  = True
strValue   = 'jskim'
print( type(intValue) , type(floatValue) , type(boolValue) , type(strValue))

# 형변환
numStr = "720"
numCnt = 100

print( numStr + str(numCnt) )
print( int(numStr) + numCnt )

# list
list = ['jskim', 'python', numStr]
print(list, type(list))
print(list[0])

# dict(key, value)
dict = {
    "name"  : "machine Learning",
    "version" : 2.0
}
print(dict, type(dict))

# tuple()
tuple = (3,5,7)
print(tuple, type(tuple))

# set{}
set = {3, 5, 7}
print(set, type(set))

# input()
# 키보드 입력
inputNum = int(input('평수를 ㎡로 변환하기 : '))
print("{}㎡".format(inputNum * 3.305785))

# 문자형(중요)
str01 = "I am Python"
str02 = "I am Python"
str03 = """this is a
           multi line"""
str03 = '''this is a
            multi line'''
print(str02)

strSlicing = 'Nice Python'
print(strSlicing[0:4])
print(strSlicing[5:])
print(strSlicing[0:len(strSlicing):2])
print(strSlicing[:len(strSlicing):])
print(strSlicing[-6:])
print(strSlicing[::-1])

exStr = "홀짝홀짝홀짝홀짝홀짝홀짝"
print(exStr[0:len(exStr):2])
print(exStr[0:4:2])

cap = 'nice python'
print('Capitalize : ', cap.capitalize())

phone_number = "010-6610-7063"
print(phone_number, phone_number.replace('-', ""))

dumpStr = "aslkdjgijalekjflasdkfj"
print(dumpStr, dumpStr.upper())

cap = "welcome to JESSE's blog"
print('Capitalize : ', cap.capitalize())
print(cap.upper())
print(cap.lower())

# 문자열에서 도메인만 출력
url = 'http://www.naver.com'
print(url[-3:])
print(url[url.find('com'):])
print((url.replace('www', '*'))[7:])

url_list = url.split('.')
print(url_list, type(url_list), url_list[-1])


# strip(), rstrip(), lstrip()
company_name = "    삼성전자    "
print(company_name * 4)
print(company_name.strip(), company_name.rstrip(), company_name.lstrip())

# upper(), lower()
company_name = "samsung"
print(company_name.upper(), company_name.lower())

# 확장자가 xls, xlsx 파일인지 여부를 확인하고 싶다면?
# endswith()
file_name = 'report.xls'
print(file_name, file_name.endswith(('xls', 'xlsx')), type(file_name.endswith(('xls', 'xlsx'))))

# in, not in -> T|F
dummyTxt = 'apple banana pineapple mango grape melon'
print('Apple'.lower() in dummyTxt)

drinking = 'cocacola'
print(len(drinking), drinking.count('c'), drinking.find('f'), drinking.find('l'), drinking.index('a'))
# find 함수는 있으면 index가, 없으면 -1이 리턴된다.


x = '::'
y = 'abcd'
print(x.join(y))


# list (중요)
# 파이썬에는 array X, list는 R의 Vector와 유사
# 순서 O, 중복 O, 수정, 삭제 가능
# index 0~
# 선언 [] 또는 list() 함수
blankList = []
blankList = list()
print(blankList)

dummyList = [1,2,3,4,'jskim',['show','me','the','money']]
print(dummyList, type(dummyList))
print(dummyList[5][1])

# list 연산 가능 (단순 결합, 원소 개수 맞을 필요 X)
x = [1,2,3]
y = [4,5,6]
z = x + y
print(z, type(z))
print(z[0])

z[0] = 10 #(인덱스 위치에 추가하는게 아니라, 기존 인덱스 값을 변경)
print(z, z[0])

z.append(7)
print('append - ', z)

z.insert(0,0)
print('insert - ', z)

z.sort()
print('sort - ', z)
z.reverse()
print('reverse - ', z)

print('result - ', z, z[0])

# pop() : 기존 리스트에서 원소를 가져오면서 삭제해버림
# 인덱스 없이 실행하면 가장 뒤의 값에 실행됨
print('pop - ', z.pop(), z)
print('pop - ', z.pop(0), z)

# ---- 실습
movie_rank = ['크루엘라', '랑종', '모가디슈', '블랙위도우', '미나리', '킹덤']
'''
1. 배트맨을 추가
2. 랑종과 모가디슈 사이에 기생충 추가
3. 블랙위도우 삭제
4. 킹덤의 익덱스를 구해서 pop()함수를 이용해 삭제
5. 최종 리스트 출력
'''
movie_rank.append('배트맨')
print(movie_rank)

movie_rank.insert(2,'기생충')

movie_rank.





print('실습01')
movie_rank.append('배트맨')
print(movie_rank)

print('실습02')
movie_rank.insert(2, '임정섭')
print(movie_rank)

print('실습03')
idx = movie_rank.index('블랙위도우')
movie_rank.pop(idx)
print(movie_rank)

print('실습04')
del movie_rank[2]
del movie_rank[2]
print(movie_rank)

print('실습05')
idx = movie_rank.index('그루엘라')
movie_rank.pop(idx)
print(movie_rank)

print('실습06')
print(movie_rank)
