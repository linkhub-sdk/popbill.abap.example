*&---------------------------------------------------------------------*
*& Report  ZPB_EX_CB_DELETE
*&
*&---------------------------------------------------------------------*
*&
*& 발행취소된 현금영수증 삭제. 관리번호 재사용을 위해서는 취소된 건을 삭제해야 가능함.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_CB_DELETE.




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
      lv_memo type string,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 회원 사업자번호
lv_corpnum = '6798700433'.
* 삭제할 현금영수증 관리번호
lv_mgtkey = '12345'.


CALL METHOD lo_popbill_cashbill->Delete
  EXPORTING
    p_corpNum  = lv_corpnum
    p_mgtkey = lv_mgtkey
  IMPORTING
    p_result   = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RESULT Message',
      lv_result-message.