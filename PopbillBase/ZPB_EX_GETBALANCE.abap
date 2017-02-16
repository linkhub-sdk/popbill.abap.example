*&---------------------------------------------------------------------*
*& Report  ZPB_EXAM_GETBALANCE
*&
*&---------------------------------------------------------------------*
*& 팝빌 연동회원 잔여포인트 확인 예제.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_GETBALANCE.

DATA: lo_popbill_hometax TYPE REF TO ZPOPBILL_HT_TAXINVOICE.

CREATE OBJECT lo_popbill_hometax
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

lo_popbill_hometax->is_TEST = ABAP_TRUE.

DATA:
      lv_balance TYPE p decimals 2,
      lv_corpnum type String,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 확인할 회원 사업자번호
lv_corpnum = '1234567890'.

CALL METHOD lo_popbill_hometax->getBALANCE
  EXPORTING
    p_corpNum = lv_corpnum
  IMPORTING
    p_balance = lv_balance
    p_result  = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.
write: /
      'REMAIN POINT',
      lv_balance.
