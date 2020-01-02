*&---------------------------------------------------------------------*
*& Report  ZPB_EX_CB_REGISTISSUE
*&
*&---------------------------------------------------------------------*
*&
*& 현금영수증 1건 발행.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_CB_REGISTISSUE.


DATA: lo_popbill_cashbill TYPE REF TO ZPOPBILL_CASHBILL.

CREATE OBJECT lo_popbill_cashbill
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

* 테스트베드 연결 여부.
lo_popbill_cashbill->is_TEST = ABAP_TRUE.

DATA:
      lv_corpnum type String,
      lv_cashbill type ZPOPBILL_CASHBILL=>S_CASHBILL,
      lv_memo type string,
      lv_emailSubject type string,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 회원 사업자번호
lv_corpnum = '6798700433'.

*발행자 사업자번호
lv_cashbill-franchiseCorpNum = lv_corpnum.
lv_cashbill-franchiseCorpName = '발행자 상호'.
lv_cashbill-franchiseCEOName = '발행자 대표자'.
lv_cashbill-franchiseAddr = '발행자 주소'.
* 발행자 연락처
lv_cashbill-franchiseTEL = '07043042990'.
* 발행안내문자 전송여부
lv_cashbill-smsSendYN = abap_false.
lv_cashbill-customerName = '고객명'.
lv_cashbill-itemName = '상품명'.
lv_cashbill-orderNumber = '주문번호'.
* 고객 안내 이메일주소
lv_cashbill-email = 'pallet027@gmail.com'.
* 발행안내문자 수신번호
lv_cashbill-hp = '01041680206'.
*  문서형태, {승인거래, 취소거래} 중 기재
lv_cashbill-tradetype = '승인거래'.
* 거래구분, {소득공제용, 지출증빙용} 중 기재
lv_cashbill-tradeusage = '소득공제용'.
* 거래유형, {읿반, 도서공연, 대중교통} 중 기재
lv_cashbill-tradeopt = '일반'.
*  문서번호, 최대 24자리, 영문, 숫자 '-', '_'로 구성
lv_cashbill-mgtkey = '12345'.

* 거래처 식별번호, 거래유형에 따라 작성
* 소득공제용 - 주민등록/휴대폰/카드번호 기재가능
* 지출증빙용 - 사업자번호/주민등록/휴대폰/카드번호 기재가능
lv_cashbill-identitynum = '8009251559817'.
* 과세형태, {과세, 비과세} 중 기재
lv_cashbill-taxationtype = '과세'.
* 봉사료, 숫자만 가능
lv_cashbill-serviceFee = '0'.
* 공급가액, 숫자만 가능
lv_cashbill-supplyCost = '10000'.
* 세액, 숫자만 가능
lv_cashbill-tax = '1000'.
* 합계금액, 숫자만 가능 , 봉사료 + 공급가액 + 세액
lv_cashbill-totalAmount = '11000'.

* 취소거래시 기재, 원본 현금영수증 국세청 승인번호 - getInfo API를 통해 confirmNum 값 기재
lv_cashbill-orgConfirmNum = ''.
*  취소거래시 기재, 원본 현금영수증 거래일자 - getInfo API를 통해 tradeDate 값 기재  : YYYYMMDD
lv_cashbill-orgTradeDate = ''.

lv_memo = '발행메모'.

* 발행안내 메일의 이메일 제목을 변경하고자 할때 설정합니다.
lv_emailSubject = ''.

CALL METHOD lo_popbill_cashbill->RegistIssue
  EXPORTING
    p_corpNum  = lv_corpnum
    p_cashbill = lv_cashbill
    p_memo = lv_memo
    p_emailsubject = lv_emailSubject
  IMPORTING
    p_result   = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RESULT Message',
      lv_result-message.