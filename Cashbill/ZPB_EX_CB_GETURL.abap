*&---------------------------------------------------------------------*
*& Report  ZPB_EX_CB_GETURL
*&
*&---------------------------------------------------------------------*
*&
*& 팝빌 현금영수증 화면에 로그인된 상태로 접근가능한 URL 반환.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_CB_GETURL.



DATA: lo_popbill_hometax TYPE REF TO ZPOPBILL_CASHBILL.
DATA: lv_inuse type boolean.


CREATE OBJECT lo_popbill_hometax
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

lo_popbill_hometax->is_TEST = ABAP_TRUE.

DATA:
      lv_corpnum type String,
      lv_url type String,
      lv_togo type string,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 확인할 회원 사업자번호
lv_corpnum = '6798700433'.
* TBOX-임시문서함 / PBOX-발행문서함 / WRITE-현금영수증 신규작성 중 택1
lv_togo = 'PBOX'.

CALL METHOD lo_popbill_hometax->GetURL
  EXPORTING
    p_corpNum = lv_corpnum
    p_togo = lv_togo
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