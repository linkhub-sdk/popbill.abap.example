*&---------------------------------------------------------------------*
*& Report  ZPB_EX_CB_CHECKMGTKEYINUSE
*&
*&---------------------------------------------------------------------*
*&
*& 현금영수증 관리번호 등록여부 확인.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_CB_CHECKMGTKEYINUSE.

DATA: lo_popbill_hometax TYPE REF TO ZPOPBILL_CASHBILL.
DATA: lv_inuse type boolean.


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
lv_corpnum = '6798700433'.

CALL METHOD lo_popbill_hometax->CheckMgtKeyInUse
  EXPORTING
    p_corpNum = lv_corpnum
    p_mgtKey = '20190819-002'
  IMPORTING
    p_inuse = lv_inuse
    p_result  = lv_result.

write: /
      'IN_USE',
     lv_inuse.
write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.
write: /
      'REMAIN POINT',
      lv_balance.