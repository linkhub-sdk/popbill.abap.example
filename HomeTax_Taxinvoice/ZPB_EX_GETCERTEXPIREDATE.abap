*&---------------------------------------------------------------------*
*& Report  ZPB_EX_HT_GETCERTEXPIREDATE
*&
*&---------------------------------------------------------------------*
*& 팝빌 홈택스 공인인증서 만료일시 확인 예제.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_HT_GETCERTEXPIREDATE.


DATA: lo_popbill_hometax TYPE REF TO ZPOPBILL_HT_TAXINVOICE.

CREATE OBJECT lo_popbill_hometax
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

lo_popbill_hometax->is_TEST = ABAP_TRUE.

DATA:
      lv_expireDT TYPE timestamp,
      lv_corpnum type String,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 확인할 회원 사업자번호
lv_corpnum = '1231212312'.

CALL METHOD lo_popbill_hometax->GETCERTIFICATEEXPIREDATE
  EXPORTING
    p_corpNum = lv_corpnum
  IMPORTING
    P_EXPIREDATE = lv_expireDT
    p_result  = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.
write: /
      'EXPIRE TIMESTAMP',
      lv_expireDT.
