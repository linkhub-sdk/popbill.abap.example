*&---------------------------------------------------------------------*
*& Report  ZPB_EXAM_CHECKISMEMBER
*&
*&---------------------------------------------------------------------*
*& 팝빌 연동회원 가입여부 확인.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_CHECKISMEMBER.

DATA: lo_popbill_hometax TYPE REF TO ZPOPBILL_HT_TAXINVOICE.

CREATE OBJECT lo_popbill_hometax
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

lo_popbill_hometax->is_TEST = ABAP_TRUE.

DATA: lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT,
      lv_checkCorpNum  TYPE STRING,
      lv_linkID type STRING.

* 확인할 사업자번호.
lv_checkCorpNum = '1231212312'.
* 파트너의 링크아이디.
lv_linkID = 'TESTER'.

CALL METHOD lo_popbill_hometax->CHECKISMEMBER
  EXPORTING
    P_CORPNUM = lv_CheckCorpNum
    P_LINKID  = lv_linkID
  IMPORTING
    p_result  = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.
