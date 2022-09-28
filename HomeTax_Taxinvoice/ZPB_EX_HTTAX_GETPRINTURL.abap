*&---------------------------------------------------------------------*
*& Report  ZPB_EX_HTTAX_GETPRINTURL
*&
*&---------------------------------------------------------------------*
*&
*& 홈택스  세금계산서 인쇄 화면에 로그인된 상태로 접근가능한 URL 반환.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_HTTAX_GETPRINTURL.

DATA: lo_popbill_ht_taxinvoice TYPE REF TO ZPOPBILL_HT_TAXINVOICE.


* 발급받은  LinkID 와 SecretKey 설정.
CREATE OBJECT lo_popbill_ht_taxinvoice
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

* 테스트 베드로 연결설정.
lo_popbill_ht_taxinvoice->is_TEST = ABAP_TRUE.

DATA:
      lv_corpnum type String,
      lv_ntsconfirmnum type String,
      lv_url type String,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 회원 사업자번호
lv_corpnum = '1234567890'.
* 세금계산서 승인번호
lv_ntsconfirmnum = '200209248888888800000001'.


CALL METHOD lo_popbill_ht_taxinvoice->GetPrintURL
  EXPORTING
    p_corpNum = lv_corpnum
    p_ntsconfirmnum = lv_ntsconfirmnum
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


if lv_result-code = 1.
  cl_gui_frontend_services=>execute(
  EXPORTING
    application = 'chrome.exe'
    parameter = lv_url
  EXCEPTIONS
    OTHERS = 1 ).
endif.
