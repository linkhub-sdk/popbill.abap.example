*&---------------------------------------------------------------------*
*& Report  ZPB_EX_CB_GETPRINTURL
*&
*&---------------------------------------------------------------------*
*&
*& 현금영수증을 출력할 수 있는 팝빌 화면 URL  반환.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_CB_GETPRINTURL.


DATA: lo_popbill_hometax TYPE REF TO ZPOPBILL_CASHBILL.
DATA: lv_inuse type boolean.


CREATE OBJECT lo_popbill_hometax
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

lo_popbill_hometax->is_TEST = ABAP_TRUE.

DATA:
      lv_corpnum type String,
      lv_mgtkey type String,
      lv_url type String,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 확인할 회원 사업자번호
lv_corpnum = '6798700433'.
* 확인할 현금영수증 관리번호.
lv_mgtkey = '20190819-002'.

CALL METHOD lo_popbill_hometax->GetPrintURL
  EXPORTING
    p_corpNum = lv_corpnum
    p_mgtkey = lv_mgtkey
  IMPORTING
    p_url = lv_url
    p_result  = lv_result.
write: /
      'URL',
      lv_url.
write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.