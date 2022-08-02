*&---------------------------------------------------------------------*
*& Report  ZPB_EX_TI_SENDEMAIL
*&
*&---------------------------------------------------------------------*
*&
*& 세금계산서 안내 메일 재발송.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_TI_SENDEMAIL.

DATA: lo_popbill_taxinvoice TYPE REF TO ZPOPBILL_TAXINVOICE.

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
      lv_receiver_email type string,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 회원 사업자번호
lv_corpnum = '1234567890'.
* 세금계산서 관리번호 유형
lv_mgtkeytype = ZPOPBILL_TAXINVOICE=>SELL.
* 세금계산서 관리번호
lv_mgtkey = '20220726-ASP-002'.
* 수신이메일 주소
lv_receiver_email = 'pallet027@gmail.com'.


CALL METHOD lo_popbill_taxinvoice->SendEmail
  EXPORTING
    p_corpNum  = lv_corpnum
    p_mgtkeytype = lv_mgtkeytype
    p_mgtkey = lv_mgtkey
    p_receiver_email = lv_receiver_email
  IMPORTING
    p_result   = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RESULT Message',
      lv_result-message.
