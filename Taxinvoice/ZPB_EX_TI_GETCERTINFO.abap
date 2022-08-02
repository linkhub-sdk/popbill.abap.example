*&---------------------------------------------------------------------*
*& Report  ZPB_EX_TI_GETCERTINFO
*&
*&---------------------------------------------------------------------*
*& 세금계산서 발행용 공동인증서 등록정보 확인
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_TI_GETCERTINFO.

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
      lv_TaxCertificate type ZPOPBILL_TAXINVOICE=>S_TAXINVOICE_CERTIFICATE,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 회원 사업자번호
lv_corpnum = '1234567890'.

CALL METHOD lo_popbill_taxinvoice->GetTaxCertInfo
  EXPORTING
    p_corpNum  = lv_corpnum
  IMPORTING
    p_taxCertificate = lv_TaxCertificate
    p_result   = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RESULT Message',
      lv_result-message.
write: /
      'regDT',lv_TaxCertificate-regDT,/,
      'expireDT',lv_TaxCertificate-expireDT,/,
      'issuerDN',lv_TaxCertificate-issuerDN,/,
      'subjectDN',lv_TaxCertificate-subjectDN,/,
      'issuerName',lv_TaxCertificate-issuerName,/,
      'oid',lv_TaxCertificate-oid,/,
      'regContactName',lv_TaxCertificate-regContactName,/,
      'regContactID',lv_TaxCertificate-regContactID.
