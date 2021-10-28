
# csv , excel
# restful service - ajax - 비동기통신
# json - {key : {key : value} , key : [] }

import pandas as pd

def load_file(filePath) :
    if filePath.split('.')[-1] == 'csv' :
        # raw_data = pd.read_csv(filePath , encoding='UTF-8')
        raw_data = pd.read_csv(filePath, encoding='ms949' , header=None)
    elif filePath.split('.')[-1] == 'xlsx' :
        raw_data = pd.ExcelFile(filePath)
    else :
        with open('./data/usagov_bitly.txt', 'r', encoding='UTF-8') as file:
            lines = file.readlines()
            lines = [j.loads(line) for line in lines]
            raw_data = pd.DataFrame(lines)
    return raw_data

def bim_caller(filePath) :
    data = load_file(filePath)
    print( type(data))
    # print(data.head())
    # print(data.info())
    # print( type(data['height']) , data.height)
    # label 컬럼을 활용하여 빈도수를 출력한 구문 작성해 본다면?
    labelFreq = {}
    for key in data.label :
        labelFreq[key] = labelFreq.get(key , 0) + 1
    print(labelFreq)

# bim_caller('./data/service_bmi.csv')

def kospi_caller(filePath) :
    data = load_file(filePath)
    data = data.parse('sam_kospi')
    print('kospi parse - ', type(data))
    data.info()

kospi_caller('./data/sam_kospi.xlsx')

# json
# 네트워크 상에서 표준으로 사용되는 파일 형식
# json -> python(dict , list) : decoding
# json <- python(dict , list) : encoding

import json as j

# tmpDict = { 'id' : 'jslim' , 'pwd' : 'jslim' }
# print( type(tmpDict) , tmpDict)
# # dict -> json
# jsonDict = j.dumps(tmpDict)
# print( type(jsonDict) , jsonDict)
#
# # json -> dict
# pyObj = j.loads(jsonDict)
# print( type(pyObj) , pyObj['id'] , pyObj['pwd'])

def json_caller(filePath) :
    dataDF = load_file(filePath)
    print( type(dataDF) )
    # print( dataDF.head() )

json_caller('./data/usagov_bitly.txt')

# with open('./data/usagov_bitly.txt' , 'r' , encoding='UTF-8') as file :
#     lines = file.readlines()
#     # print( type(lines) )
#     # print( type(lines[0]) , lines[0] )
#     # print(type(j.loads(lines[0])), j.loads(lines[0]))
#     lines = [ j.loads(line) for line in lines]
#     # print( type(lines[0]) , lines[0]['c'])
#     raw_data = pd.DataFrame(lines)
#     # print( type(raw_data) )
#     # print( raw_data.head() )

def spam_caller(filePath) :
    data = load_file(filePath)
    target = data[0]
    msg    = data[1]
    print( type(target) , type(msg))
    target = [ 1 if t == 'spam' else 0 for t in target]
    print(target)
    print(msg)
    clean_msg = clean_txt(msg)
    print(clean_msg)


# 텍스트 전처리 -> 특수문자, 숫자, 공백, 영문 제거 -> 한글 단어만
import re
def clean_txt(msg) :
    # 문장부호 제거
    msg = re.sub('[,.?!:;]', ' ', str(msg))
    # 특수문자 제거
    msg = re.sub('[@#$%^&]|[0-9]', ' ', str(msg))
    # 영문자를 소문자 변경 삭제
    msg = re.sub('[a-z]', ' ', msg.lower())
    # 공백 제거
    msg = ' '.join(msg.split())
    return msg

spam_caller('./data/spam_data.csv')

