*&---------------------------------------------------------------------*
*& Report  ZPB_EX_CB_CANCELISSUE
*&
*&---------------------------------------------------------------------*
*&
*& 현금영수증 발행취소. 국세청 전송전까지 가능.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_CB_CANCELISSUE.

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
* 발행취소할 현금영수증 관리번호
lv_mgtkey = '12345'.
* 발행취소시 메모.
lv_memo = '발행취소 메모'.


CALL METHOD lo_popbill_cashbill->CancelIssue
  EXPORTING
    p_corpNum  = lv_corpnum
    p_mgtkey = lv_mgtkey
    p_memo = lv_memo
  IMPORTING
    p_result   = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RESULT Message',
      lv_result-message.
