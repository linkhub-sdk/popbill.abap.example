*&---------------------------------------------------------------------*
*& Report  ZPB_EX_CB_REVOKE_PART
*&
*&---------------------------------------------------------------------*
*& 1건의 부분 취소현금영수증을 [즉시발행]합니다.
*&   - 발행일 기준 오후 5시 이전에 발행된 현금영수증은 다음날 오후 2시에 국세청 전송결과를 확인할 수 있습니다.
*&   - 현금영수증 국세청 전송 정책에 대한 정보는 "[현금영수증 API 연동매뉴얼] > 1.3. 국세청 전송정책"을 참조하시기 바랍니다.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_CB_REVOKE_PART.


DATA: lo_popbill_cashbill TYPE REF TO ZPOPBILL_CASHBILL.

CREATE OBJECT lo_popbill_cashbill
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

* 테스트베드 연결 여부.
lo_popbill_cashbill->is_TEST = ABAP_TRUE.

DATA:
      lv_corpnum type String,
      lv_mgtkey type String,
      lv_orgConfirmNum type String,
      lv_orgTradeDate type String,
      lv_smssendyn type boolean,
      lv_isPartCancel type boolean,
      lv_supplycost type string,
      lv_tax type string,
      lv_servicefee type string,
      lv_totalamount type string,
      lv_memo type string,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 회원 사업자번호
lv_corpnum = '6798700433'.
* 취소현금영수증의 관리번호
* 문서번호, 영문, 숫자, 하이픈(-), 언더바(_)를 조합하여 24자리 문자열로 사업자별로
* 중복되지 않도록 구성
lv_mgtkey = '20190104-001'.

* 원본현금영수증 승인번호
lv_orgConfirmNum = '820116333'.

* 원본현금영수증 거래일자
lv_orgTradeDate = '201901003'.

* 안내문자 전송여부
lv_smssendyn = abap_false.

* 부분취소 여부
lv_isPartCancel = abap_true.

* 부분 취소 공급가액
lv_supplyCost = '3000'.

* 부분취소 세액
lv_tax = '300'.

* 부분취소 봉사료
lv_servicefee = '0'.

* 부분취소 합계금액.
lv_totalAmount = '3300'.

lv_memo = '취소발행 메모'.


CALL METHOD lo_popbill_cashbill->RevokeRegistIssue
  EXPORTING
    p_corpNum  = lv_corpnum
    p_mgtkey = lv_mgtkey
    p_orgConfirmNum = lv_orgConfirmNum
    p_orgTradeDate = lv_orgTradeDate
    p_isPartCancel = lv_isPartCancel
    p_smssendyn = lv_smssendYN
    p_supplycost = lv_supplyCost
    p_tax = lv_tax
    p_servicefee = lv_servicefee
    p_totalamount = lv_totalamount
    p_memo = lv_memo
  IMPORTING
    p_result   = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RESULT Message',
      lv_result-message.