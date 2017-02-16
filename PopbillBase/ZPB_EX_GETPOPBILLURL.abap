*&---------------------------------------------------------------------*
*& Report  ZPB_EX_GETPOPBILLURL
*&
*&---------------------------------------------------------------------*
*& 팝빌 관련 팝업 URL을 반환합니다.
*& - 보안정책에 따라 반환된 URL은 30초의 유효시간을 갖습니다.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_GETPOPBILLURL.

DATA: lo_popbill_hometax TYPE REF TO ZPOPBILL_HT_TAXINVOICE.

CREATE OBJECT lo_popbill_hometax
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

lo_popbill_hometax->is_TEST = ABAP_TRUE.

DATA:
      lv_url TYPE STRING,
      lv_corpnum type String,
      lv_TOGO   type String,
      lv_userid type String,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 확인할 회원 사업자번호
lv_corpnum = '1231212312'.
* URL 종류.
lv_TOGO = 'CHRG'.
* 확인할 회원 아이디. optional.
lv_userID = 'userid'.

CALL METHOD lo_popbill_hometax->GETPOPBILLURL
  EXPORTING
    p_corpNum = lv_corpnum
    P_TOGO = lv_togo
    p_userID = LV_USERID
  IMPORTING
    P_URL     = lv_url
    p_result  = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.
write: /
      'URL',
      lv_url.

CALL METHOD cl_gui_frontend_services=>execute
  EXPORTING
    document = lv_url
  EXCEPTIONS
    others   = 1.
