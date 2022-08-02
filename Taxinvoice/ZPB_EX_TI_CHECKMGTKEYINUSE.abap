*&---------------------------------------------------------------------*
*& Report  ZPB_EX_TI_CHECKMGTKEYINUSE
*&
*&---------------------------------------------------------------------*
*&
*& 세금계산서 관리번호 등록여부 확인.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_TI_CHECKMGTKEYINUSE.

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
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 회원 사업자번호
lv_corpnum = '1234567890'.

CALL METHOD lo_popbill_taxinvoice->CheckMgtKeyInUse
  EXPORTING
    p_corpNum = lv_corpnum
    p_mgtKeyType = ZPOPBILL_TAXINVOICE=>SELL
    p_mgtKey = '20220718-ABAP001'
  IMPORTING
    p_inuse = lv_inuse
    p_result  = lv_result.

write: /
      'IN_USE',
     lv_inuse.
write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.
