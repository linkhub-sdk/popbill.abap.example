*&---------------------------------------------------------------------*
*& Report  ZPB_EX_HT_GETTAXINVOICE
*&
*&---------------------------------------------------------------------*
*& 팝빌 홈택스 세금계산서 상세정보 확인 예제.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_HT_GETTAXINVOICE.

DATA: lo_popbill_hometax TYPE REF TO ZPOPBILL_HT_TAXINVOICE.

CREATE OBJECT lo_popbill_hometax
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

lo_popbill_hometax->is_TEST = ABAP_TRUE.

DATA:
      lv_Taxinvoice type ZPOPBILL_HT_TAXINVOICE=>S_HT_TAXINVOICE,
      lv_corpnum type String,
      lv_confirmNum   type String,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 확인할 회원 사업자번호
lv_corpnum = '6798700433'.

* 확인할 세금계산서의 국세청 승인번호
lv_confirmnum = '20161121410002030000079e'.

CALL METHOD lo_popbill_hometax->GETTAXINVOICE
  EXPORTING
    p_corpNum       = lv_corpnum
    P_NTSCONFIRMNUM = lv_confirmNum
  IMPORTING
    P_TAXINVOICE    = lv_taxinvoice
    p_result        = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.
write: /
      'Taxinvoice Info',
       LV_TAXINVOICE-INVOICERCORPNAME,
       LV_TAXINVOICE-INVOICEECORPNAME,
       LV_TAXINVOICE-TOTALAMOUNT.
