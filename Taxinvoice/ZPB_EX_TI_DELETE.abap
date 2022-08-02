*&---------------------------------------------------------------------*
*& Report  ZPB_EX_TI_DELETE
*&
*&---------------------------------------------------------------------*
*&
*& 세금계산서 삭제. 발행취소 또는 국세청 전송실패건에 대해서 가능.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_TI_DELETE.

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
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 회원 사업자번호
lv_corpnum = '1234567890'.
* 삭제할 세금계산서 관리번호 유형
lv_mgtkeytype = ZPOPBILL_TAXINVOICE=>SELL.
* 삭제할 세금계산서 관리번호
lv_mgtkey = '20220718-ABAP001'.


CALL METHOD lo_popbill_taxinvoice->Delete
  EXPORTING
    p_corpNum  = lv_corpnum
    p_mgtkeytype = lv_mgtkeytype
    p_mgtkey = lv_mgtkey
  IMPORTING
    p_result   = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RESULT Message',
      lv_result-message.
