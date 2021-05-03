# korea_pension_data

공공데이터 포털에 있는 **국민연금공단_국민연금 가입 사업장 내역** 데이터를 json 형식으로 변환
(https://www.data.go.kr/data/3046071/fileData.do)

## 파일 다운로드
https://www.data.go.kr/data/3046071/fileData.do 에서 csv 파일을 다운로드해주세요.

## 인코딩 변환

다운로드된 데이터를 utf-8 인코딩으로 변환합니다.

```sh
$ iconv -f cp949 -t UTF-8 KoreaNationalPensionData_202104.csv > KoreaNationalPensionData_202104_UTF8.csv
```

## json 으로 변환

```sh
$ ./transform.rb KoreaNationalPensionData_202104_UTF8.csv > KoreaNationalPensionData_202104_UTF8.json
```
