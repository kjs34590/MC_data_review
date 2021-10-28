# select로 출력하기
print('Hello World!')
 # sep=, end=
print('010','6610','7063', sep='-')
print('What is your name?', end='  ')
print('My name is JISU KIM')

 # format(d,s,f)
print('{} {} {}'.format('one','two', 3))
print('{1}, {0}, {2}'.format('2번', '1번', '3번'))

 # 자리수 지정
print('%d' %100)
print('%f' %4.23)
print(':2%f' %4.24)
print('{:.2}'.format('4.2442'))