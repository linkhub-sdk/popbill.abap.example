*&---------------------------------------------------------------------*
*& Report  ZPB_EXAM_GETCORPINFO
*&
*&---------------------------------------------------------------------*
*& 회원 정보 확인 예제.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EXAM_GETCORPINFO.

DATA: lo_popbill_hometax TYPE REF TO ZPOPBILL_HT_TAXINVOICE.

CREATE OBJECT lo_popbill_hometax
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

lo_popbill_hometax->is_TEST = ABAP_TRUE.

DATA:
      lv_corpInfo TYPE ZPOPBILL=>S_PB_CORPINFO,
      lv_corpnum type String,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 확인할 회원 사업자번호
lv_corpnum = '1231212312'.

CALL METHOD lo_popbill_hometax->GETCORPINFO
  EXPORTING
    p_corpNum  = lv_corpnum
  IMPORTING
    P_CORPINFO = lv_corpInfo
    p_result   = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.
write: /
      'Corp Info',
      lv_corpinfo-ceoname,
      lv_corpinfo-corpname,
      lv_corpinfo-addr,
      lv_corpinfo-biztype,
      lv_corpinfo-bizclass.
