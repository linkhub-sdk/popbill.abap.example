*&---------------------------------------------------------------------*
*& Report  ZPB_EX_TI_GETPOPUPURL
*&
*&---------------------------------------------------------------------*
*&
*& 팝빌 세금계산서 화면에 로그인된 상태로 접근가능한 URL 반환.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_TI_GETPOPUPURL.

DATA: lo_popbill_taxinvoice TYPE REF TO ZPOPBILL_TAXINVOICE.
DATA: lv_inuse type boolean.


* 발급받은  LinkID 와 SecretKey 설정.
CREATE OBJECT lo_popbill_taxinvoice
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

* 테스트 베드로 연결설정.
lo_popbill_taxinvoice->is_TEST = ABAP_TRUE.

DATA:
      lv_corpnum type String,
      lv_mgtkeyType TYPE ZPOPBILL_TAXINVOICE=>MGTKEYTYPE,
      lv_mgtkey type String,
      lv_url type String,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 회원 사업자번호
lv_corpnum = '1234567890'.
*세금계산서 관리번호 유형
lv_mgtkeytype = ZPOPBILL_TAXINVOICE=>SELL.
* 세금계산서 관리번호
lv_mgtkey = '20220718-ABAP001'.



CALL METHOD lo_popbill_taxinvoice->GetPopUpURL
  EXPORTING
    p_corpNum = lv_corpnum
    p_mgtkeytype = lv_mgtkeytype
    p_mgtkey = lv_mgtkey
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
