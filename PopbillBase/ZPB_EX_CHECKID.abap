*&---------------------------------------------------------------------*
*& Report  ZPB_EXAM_CHECKID
*&---------------------------------------------------------------------*
*& 팝빌 회원아이디 중복여부를 확인합니다.
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_CHECKID.

DATA:
      lo_popbill_hometax TYPE REF TO ZPOPBILL_HT_TAXINVOICE.

CREATE OBJECT lo_popbill_hometax
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

lo_popbill_hometax->is_TEST = ABAP_TRUE.

DATA: lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT,
      lv_checkID  TYPE STRING.

lv_checkID = 'IDTOCheck'.

CALL METHOD lo_popbill_hometax->CHECKID
  EXPORTING
    P_ID     = lv_checkID
  IMPORTING
    p_result = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.
