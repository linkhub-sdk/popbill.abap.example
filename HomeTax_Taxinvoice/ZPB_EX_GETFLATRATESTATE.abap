*&---------------------------------------------------------------------*
*& Report  ZPB_EX_HT_GETFLATRATESTATE
*&
*&---------------------------------------------------------------------*
*& 연동회원의 정액제 서비스 이용상태를 확인합니다.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_HT_GETFLATRATESTATE.

DATA: lo_popbill_hometax TYPE REF TO ZPOPBILL_HT_TAXINVOICE.

CREATE OBJECT lo_popbill_hometax
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

lo_popbill_hometax->is_TEST = ABAP_TRUE.

DATA:
      lv_flatrateState TYPE ZPOPBILL_HT_TAXINVOICE=>S_HT_FLATRATE_STATE,
      lv_corpnum type String,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 확인할 회원 사업자번호
lv_corpnum = '1231212312'.

CALL METHOD lo_popbill_hometax->GETFLATRATESTATE
  EXPORTING
    p_corpNum = lv_corpnum
  IMPORTING
    P_STATE   = lv_flatrateState
    p_result  = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.
write: /
      'Contract State Info',
       lv_flatrateState-STATE,
       lv_flatrateState-CONTRACTDT,
       lv_flatrateState-BASEDATE.
