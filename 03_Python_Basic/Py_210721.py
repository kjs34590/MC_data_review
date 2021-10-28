from bigdata.inheritance.oop_inheritance02 import *

tmpObj = Tmp('객체생성을 통한 인스턴스변수 바인딩')
print(tmpObj.sayPrint())
tmpObj.callSayPrint()


# 상속
# 코드의 재활용성을 줄인다

unit = Unit(100, 100)
status = unit.status()
print(help(Unit))
print('unit - status, ', status)

marine01 = Marine(100, 100, 50, 50)
print('marine01 - status, ', marine01.status())

medic01 = Medic(0, 100, 0)
print('medic01 - status, ', medic01.status())

marine01.attack()
marine01.stimPack()
print('stimpacked marine01 - status, ', marine01.status())

medic01.attack()


marine01 = Marine(100, 100, 50, 50)
marine02 = Marine(100, 100, 50, 50)
marine03 = Marine(100, 100, 50, 50)
medic01 = Medic(0, 100, 0)
medic02 = Medic(0, 100, 0)

ship01 = DropShip(0, 200)
ship01.board(marine01)
ship01.board(medic01)
ship01.board(marine02)
ship01.board(medic02)
ship01.board(marine03)
ship01.attack()
ship01.drop()




# [실습]
# 1. Account class 작성 - account, balance, interestRate, type(계좌 종류 S|F)


# 1-1. SavingAccount , FundAccount 추가


# 1-2.  |                       |


# 1.3.  -- printInterestRate()  -- printInterestRate()


# 1.4  SavingAccount - printInterestRate()
#      기본 이자율에 만기시 이자율을(0.1) 복리로 계산


# 1.5  FundAccount - printInterestRate()
#      기본 이자율에 잔액 10만원 이상이며 10%
#      기본 이자율에 잔액 50만원 이상이며 15%
#      기본 이자율에 잔액 100만원 이상이며 20%


# 2. accountInfo() - 계좌의 정보를 출력한다(account, balance, interestRate)


# 3. deposit(amount) - 계좌 잔액에 매개변수로 들어온 amount를 누적한다.


# 4. printInterestRate() - 현재 잔액에 이자율을 계산하여 소수점 자리 2자리까지 출력한다.


# 5. withDraw(amount) - 매개변수로 들어온 금액만큼을 출금하여 잔액을 변경한다.
# 단) 잔고가 부족할 경우 '잔액이 부족하여 출금할 수 없습니다' 출력한다.


