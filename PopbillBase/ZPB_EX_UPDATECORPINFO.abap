*&---------------------------------------------------------------------*
*& Report  ZPB_EX_UPDATECORPINFO
*&
*&---------------------------------------------------------------------*
*& 회원 사업자 정보 수정.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_UPDATECORPINFO.

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

* 수정할 회원 사업자번호
lv_corpnum = '1231212312'.
* 대표자명
lv_corpinfo-ceoname = '대표자명'.
* 상호
LV_CORPINFO-corpname = '상호'.
* 주소
lv_corpinfo-addr = '주소'.
* 업태
lv_corpinfo-biztype = '업테'.
* 업종
LV_CORPINFO-BIZCLASS = '업종'.


CALL METHOD lo_popbill_hometax->UPDATECORPINFO
  EXPORTING
    p_corpNum    = lv_corpnum
    P_CORPINFO   = lv_corpinfo
  IMPORTING
    p_result     = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.
