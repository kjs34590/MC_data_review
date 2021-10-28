# closure, decorator, generator
# file(input/output)
# pandas <- csv, excel, txt, ... 로딩하는 데 더 용이

'''
1. closure
일급객체함수(first-class function)
변수의 스코프(글로벌, 로컬 변수)
'''

def outer(x):
    tmp = x
    def inner():
        print(tmp)
    return inner()
outer(100)


def outer(x):
    tmp = x # free variable (코드블럭 안에 정의되었지만 블럭 안에 정의되지 않은 변수)
    def inner():
        print(tmp * 100)
    return inner            # 괄호를 뺀다 : 함수의 결과값이 아닌 주소를 return한다.
result = outer(100)
result()

print('address : ', result)
print('dir : ', dir(result))
print('closure : ', type(result.__closure__))
print('closure : ', result.__closure__[0])
print('cell_contents : ', result.__closure__[0].cell_contents)


'''
2. decorator
함수를 호출 시 함수의 인자로 함수를 넘겨줄 수 있다.
'''
print('***decoratpr***')
import time
def outer(func) :
    def inner() :
        # print('공통의 업무로직 수행 전')
        print('{} 함수의 수행시간 계산'.format(func.__name__))
        strTime = time.time()
        func()
        endTime = time.time() - strTime
        print('{} 함수의 수행시간 {}'.format(func.__name__, endTime))
        # print('공통의 업무로직 수행 후')
    return inner

def coreFunc01() :
    for idx in range(0,501) :
        print(idx)
def coreFunc02() :
    for idx in range(0, 10001) :
        print(idx)

decorator = outer(coreFunc02)
decorator()

@outer
def coreFunc02() :
    for idx in range(0, 10001) :
        print(idx)

decorator()


# *args : tuple, **kwargs : dict
def outer(func) :
    def inner(*args, **kwargs) :
        # print('공통의 업무로직 수행 전')
        print('{} 함수의 수행시간 계산'.format(func.__name__))
        strTime = time.time()
        func(*args, **kwargs)
        endTime = time.time() - strTime
        print('{} 함수의 수행시간 {}'.format(func.__name__, endTime))
        # print('공통의 업무로직 수행 후')
    return inner

def outer1(func):
    def inner(*args, **kwargs) :
        print('**************** outer1')
        print('{} 함수가 실행됩니다.'.format(func.__name__))
        return func(*args, **kwargs)
    return inner

@outer
@outer1
def coreFunc03(x, y) :
        print("************", x+y)

coreFunc03(10,20)


'''
3. generator
메모리 용량이 적을 때 루핑을 효율적으로 컨트롤할 수 있다.
yield 구문 이용해서 한 번 호출할 때마다 하나의 값만 리턴 받는 것
'''

def generatorFunc(dataList) :
    for tmp in dataList :
        yield tmp * 2

generatorList = generatorFunc([1,2,3,4,5,6,7,8,9,10])
print(generatorList)
print('generatorList type : ', type(generatorList))
print('generatorList dir : ', dir(generatorList))
print(next(generatorList))
print(next(generatorList))
print(next(generatorList))

# for tmp in generatorList :
#   print(tmp

dummyList = [tmp * 2 for tmp in [1,2,3,4,5,6,7,8,9,10]]
print('dummyList type : ', type(dummyList))

dummyList = (tmp * 2 for tmp in [1,2,3,4,5,6,7,8,9,10])
print('dummyList type : ', type(dummyList))


#filer caller

from bigdata.file.file_module import *

fileFunc('./data/greeting.txt', 'r')
print('process kill')


#
fileFunc('.data/test.txt', w) :


withFunc(fileName, mode) :
with open(fileName, mode, encoding='utf-8') as file :
    print(file.read())

withMultiLineWriteFunc('./data/multiText.txt')

lines = ['js_kim\n', 'this\t', 'is\t', 'a\t', 'list\t']
withListWriteFunc('./data/multiText.txt', 'w', lines)
withListReadFunc('./data/multiText.txt')
print('process')

print(cntFunc('./data/cnt_words.txt'))

includeFunc()

print(searchAddr())

print(searchAddr2())

isPalindrome()

palindromeFunc()