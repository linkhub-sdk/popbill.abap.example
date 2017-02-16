*&---------------------------------------------------------------------*
*& Report  ZPB_EX_HT_GETXML
*&
*&---------------------------------------------------------------------*
*& XML형식의 전자(세금)계산서 상세정보를 1건을 확인합니다.
*& - 응답항목에 관한 정보는 "[홈택스 전자(세금)계산서 연계 API 연동매뉴얼]
*&  > 3.3.4. GetXML (상세정보 확인 - XML)" 을 참고하시기 바랍니다
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_HT_GETXML.

DATA: lo_popbill_hometax TYPE REF TO ZPOPBILL_HT_TAXINVOICE.

CREATE OBJECT lo_popbill_hometax
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

lo_popbill_hometax->is_TEST = ABAP_TRUE.

DATA:
      lv_xmlString type String,
      lv_corpnum type String,
      lv_confirmNum type String,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 확인할 회원 사업자번호
lv_corpnum = '6798700433'.

* 확인할 세금계산서의 국세청 승인번호
lv_confirmnum = '20161121410002030000079e'.

CALL METHOD lo_popbill_hometax->GETXML
  EXPORTING
    p_corpNum       = lv_corpnum
    P_NTSCONFIRMNUM = lv_confirmNum
  IMPORTING
    P_XMLSTRING     = lv_xmlString
    p_result        = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.
write: /
      'Taxinvoice XML',
      lv_xmlString.
