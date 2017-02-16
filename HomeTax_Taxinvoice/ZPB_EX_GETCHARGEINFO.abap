*&---------------------------------------------------------------------*
*& Report  ZPB_EX_HT_GETCHARGEINFO
*&
*&---------------------------------------------------------------------*
*& 팝빌 홈택스연계 과금정보 확인 예제.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_HT_GETCHARGEINFO.

DATA: lo_popbill_hometax TYPE REF TO ZPOPBILL_HT_TAXINVOICE.

CREATE OBJECT lo_popbill_hometax
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

lo_popbill_hometax->is_TEST = ABAP_TRUE.

DATA:
      lv_chargeInfo TYPE ZPOPBILL_HT_TAXINVOICE=>S_PB_CHARGEINFO,
      lv_corpnum type String,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 확인할 회원 사업자번호
lv_corpnum = '1231212312'.

CALL METHOD lo_popbill_hometax->GETCHARGEINFO
  EXPORTING
    p_corpNum    = lv_corpnum
  IMPORTING
    P_CHARGEINFO = lv_chargeInfo
    p_result     = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.
write: /
      'Charge Info',
      lv_chargeInfo-unitCost,
      lv_chargeInfo-chargemethod,
      lv_chargeInfo-rateSystem.
