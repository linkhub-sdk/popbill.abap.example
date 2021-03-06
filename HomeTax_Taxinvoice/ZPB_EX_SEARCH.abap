*&---------------------------------------------------------------------*
*& Report  ZPB_EX_HT_SEARCH
*&
*&---------------------------------------------------------------------*
*&검색조건을 사용하여 수집결과를 조회합니다.
*&- 응답항목에 관한 정보는 "[홈택스 전자(세금)계산서 연계 API 연동매뉴얼]
*&  > 3.3.1. Search (수집 결과 조회)" 을 참고하시기 바랍니다.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_HT_SEARCH.


DATA: lo_popbill_hometax TYPE REF TO ZPOPBILL_HT_TAXINVOICE.

CREATE OBJECT lo_popbill_hometax
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

lo_popbill_hometax->is_TEST = ABAP_TRUE.

DATA:
      lv_corpnum type String,
      lv_userid type string,
      lv_jobid  type string,
      lv_type type STANDARD TABLE OF String,
      lv_taxtype type STANDARD TABLE OF String,
      lv_purposeType type STANDARD TABLE OF String,
      lv_TaxRegIDType type String,
      lv_taxregidyn type boolean,
      lv_taxregid type string,
      lv_page type i,
      lv_perpage type i,
      lv_order type string,
      lv_pagedResult type ZPOPBILL_HT_TAXINVOICE=>S_HT_SEARCH_RESULT,
      lv_TaxinvoiceAbbr type ZPOPBILL_HT_TAXINVOICE=>S_HT_TAXINVOICEABBR,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 확인할 회원 사업자번호
lv_corpnum = '6798700433'.

* RequestJob 호출로 획득한 작업ID
lv_jobid = '017021517000000002'.

* 문서 형태  N - 일반세금계산서, M-수정세금계산서, 아무것도 append하지 않으면 전체.
append 'N' to lv_type.
append 'M' to lv_type.

* 과세형태 T - 과세 , N - 면세 , Z - 영세 , 아무것도 append하지 않으면 전체.
append 'T' to lv_taxtype.
append 'N' to lv_taxtype.
append 'Z' to lv_taxtype.

* 영수/청구 구분 R - 영수 , C - 청구 , N - 없음 , 아무것도 append하지 않으면 전체.
append 'R' to lv_PurposeType.
append 'C' to lv_PurposeType.
append 'N' to lv_PurposeType.

*종사업자번호 검색 사업자 유형 S - 공급자 , B - 공급받는자 , T - 수탁자.
* lv_TaxRegIDType = 'S'.
* lv_TaxRegIDYN = abap_false.
* lv_taxRegID = '1234'.

* 페이지 번호
lv_page = 1.

* 페이지당 세금계산서 갯수.
lv_perpage = 10.
* 정렬방향 , D - 내림차순 , A - 오름차순.
lv_order = 'D'.


CALL METHOD lo_popbill_hometax->SEARCH
  EXPORTING
    p_corpNum = lv_corpnum
    P_JOBID = lv_jobid
    P_TYPE = lv_type
    P_TAXTYPE = lv_taxtype
    P_PURPOSETYPE = lv_purposetype
    P_TAXREGIDTYPE = lv_taxRegIDType
    P_TAXREGIDYN = lv_taxregIDYN
    P_TAXREGID = lv_taxregid
    P_PAGE = lv_page
    P_PERPAGE = lv_perpage
    P_ORDER = lv_order
    p_userid = lv_userid
  IMPORTING
    P_PAGEDRESULT = lv_pagedResult
    p_result  = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.

write: / 'code : ' , LV_PAGEDRESULT-code.
write: / 'message : ' , LV_PAGEDRESULT-message.
write: / 'total : ' , LV_PAGEDRESULT-total.
write: / 'perpage : ' , LV_PAGEDRESULT-perpage.
write: / 'pageNum : ' , LV_PAGEDRESULT-pagenum.
write: / 'pageCount : ' , LV_PAGEDRESULT-pageCount.

loop at lv_pagedResult-list into lv_TaxinvoiceAbbr.
  write : /
      LV_TAXINVOICEABBR-INVOICEECORPNAME,
      LV_TAXINVOICEABBR-TOTALAMOUNT,
      LV_TAXINVOICEABBR-ITEMNAME.
endloop.
